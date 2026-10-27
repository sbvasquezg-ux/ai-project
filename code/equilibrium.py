"""Equilibrio competitivo finito de la extensión, con certificado primal-dual.

Una variable y_ij mide trabajadores i ayudados por humanos j; consume
h(1-z_i)*y_ij unidades del tipo j. x_i mide usuarios humanos de IA.
El código de partida es ai-05-ide/sim.py; aquí se separan las actividades
para recuperar asignaciones y no confundir igualdad salarial con adopción.
"""
from dataclasses import dataclass
import numpy as np
from scipy.optimize import linprog
from scipy.sparse import coo_matrix

@dataclass
class Equilibrium:
    z: np.ndarray
    mass: np.ndarray
    wages: np.ndarray
    independent: np.ndarray
    ai: np.ndarray
    pairs_i: np.ndarray
    pairs_j: np.ndarray
    pairs: np.ndarray
    net_output: float
    gross_output: float
    validation_spending: float
    compute_demand: float
    diagnostics: dict

def equilibrium(z, mass, h, a=None, kappa=0., constant_cost=None, compute=1.):
    z=np.asarray(z,dtype=float);mass=np.asarray(mass,dtype=float)
    assert z.ndim==1 and mass.shape==z.shape and np.all(np.diff(z)>0)
    assert np.all((z>=0)&(z<=1)) and np.all(mass>0)
    assert abs(mass.sum()-1)<1e-10 and 0<h<1 and compute>h
    assert kappa>=0 and (constant_cost is None or constant_cost>=0)
    assert a is None or 0<a<1
    N=len(z);ii,jj=np.triu_indices(N,1);b=h*(1-z)
    eligible=np.array([],dtype=int) if a is None else np.flatnonzero(z<=a)
    J=len(eligible);K=len(ii)
    rows=np.r_[np.arange(N),eligible,ii,jj]
    cols=np.r_[np.arange(N),N+np.arange(J),N+J+np.arange(K),N+J+np.arange(K)]
    vals=np.r_[np.ones(N+J+K),b[ii]]
    B=coo_matrix((vals,(rows,cols)),shape=(N,N+J+K)).tocsr()
    cost=kappa*(1-z[eligible]) if constant_cost is None else np.full(J,constant_cost)
    q=np.array([]) if a is None else a-cost
    products=np.r_[z,q,z[jj]]
    res=linprog(-products,A_eq=B,b_eq=mass,bounds=(0,None),method='highs',
                options={'dual_feasibility_tolerance':1e-9,'primal_feasibility_tolerance':1e-9})
    if not res.success:raise AssertionError(res.message)
    wages=-res.eqlin.marginals
    independent=res.x[:N];ai=np.zeros(N);ai[eligible]=res.x[N:N+J]
    pairs=res.x[N+J:];slack=B.T@wages-products
    net=float(products@res.x);spending=float(cost@ai[eligible])
    diagnostics={
      'resource_residual':float(np.max(np.abs(B@res.x-mass))),
      'negative_activity':float(max(0.,-np.min(res.x))),
      'positive_unit_profit':float(max(0.,-np.min(slack))),
      'complementarity':float(np.max(np.abs(slack*res.x))),
      'duality_gap':float(abs(mass@wages-net)),
    }
    assert max(diagnostics.values())<1e-7,diagnostics
    demand=float(b@ai);assert demand<compute
    return Equilibrium(z,mass,wages,independent,ai,ii,jj,pairs,net,net+spending,
                       spending,demand,diagnostics)
