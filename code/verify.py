"""Chequeos locales de la extensión; no es un solver del nuevo equilibrio.

uniform_baseline adapta ai-05-ide/sim.py (Belén Vásquez, MIT).
Ejecutar desde cualquier carpeta: python3 code/verify.py.
"""
from pathlib import Path
import csv
import numpy as np
import sympy as sp
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent

def symbolic_checks():
    z, h, a, r, k = sp.symbols('z h a r kappa', real=True)
    w, c = sp.Function('w')(z), sp.Function('c')(z)
    n = 1 / (h * (1-z))
    pi = n * (a-w-c)-r
    assert sp.simplify(sp.diff(n,z) / n - 1/(1-z)) == 0
    foc = sp.diff(n,z)*(a-w-c)-n*(sp.diff(w,z)+sp.diff(c,z))
    assert sp.simplify(sp.diff(pi,z)-foc) == 0
    slope = (a-w-c)/(1-z)-sp.diff(w,z)-sp.diff(c,z)
    assert sp.simplify(foc/n-slope) == 0
    wage_zero_profit = sp.solve(pi,w)[0]
    assert sp.simplify(wage_zero_profit-(a-c-r*h*(1-z))) == 0
    margin = sp.simplify(a-wage_zero_profit-c)
    assert sp.simplify(margin/(1-z)-h*r) == 0
    wage_idle = wage_zero_profit.subs(r,0)
    assert sp.simplify(wage_idle-(a-c)) == 0
    wage_linear = wage_idle.subs(c,k*(1-z))
    assert sp.simplify(sp.diff(wage_linear,z)-k) == 0
    assert sp.simplify(wage_linear.subs(k,0)-a) == 0
    # The zero-profit envelope satisfies the FOC on a differentiable active interval.
    assert sp.simplify(foc.subs(w,wage_zero_profit).doit()) == 0
    print('SymPy: razón n\'/n, FOC, beneficio cero, r=0 y pendiente: OK')

def uniform_baseline(h):
    """Fórmula de ai-05-ide, régimen sin independientes G(z)=z, 0<h<3/4.

    Renombramos su variable local c a cutoff para no confundirla con c(z).
    Retorna corte trabajador/solver, constante salarial y salario inferior.
    """
    assert 0 < h < 0.75
    cutoff = 2 / (1+h+np.sqrt(1+h*h))
    C = (1-h*cutoff*(1-cutoff))/(1+h*(1-cutoff))
    return cutoff, C, cutoff-h*C

def uniform_wage(z,h):
    z = np.asarray(z,dtype=float)
    assert np.all((z>=0)&(z<=1))
    b,C,w00 = uniform_baseline(h)
    worker = w00+h*C*z+h*z*z/2
    # Invert f(x)=b+h(x-x²/2); integral of n gives 1-sqrt(...).
    solver = C+1-np.sqrt(np.maximum(1-2*(z-b)/h,0))
    return np.where(z<=b,worker,solver)

def entry_gap(z,h,a,kappa):
    return a-kappa*(1-np.asarray(z))-uniform_wage(z,h)

def numeric_checks():
    h,a,kappa = .5,.88,.53
    b,C,w00=uniform_baseline(h)
    # Baseline boundary/matching conditions, not a new GE computation.
    assert abs(b+h*(b-b*b/2)-1)<1e-12
    assert abs(float(uniform_wage(b,h))-C)<1e-12
    probes=np.array([0,.25,.60]); expected=np.array([-.0070,.0081,-.0232])
    wages=uniform_wage(probes,h); offers=a-kappa*(1-probes)
    actual=entry_gap(probes,h,a,kappa)
    np.testing.assert_allclose(actual,expected,atol=5e-4,rtol=0)
    assert actual[0]<0<actual[1] and actual[2]<0
    grid=np.linspace(0,a,601)
    np.testing.assert_allclose(entry_gap(grid,h,a,0),a-uniform_wage(grid,h),atol=1e-12,rtol=0)
    assert abs(float(entry_gap(0,h,a,0))-(a-w00))<1e-12
    assert a>w00  # baseline adoption criterion for this illustration
    assert np.all(np.diff(uniform_wage(np.linspace(0,1,1001),h))>0)
    (ROOT/'output').mkdir(exist_ok=True);(ROOT/'figures').mkdir(exist_ok=True)
    with (ROOT/'output/entry_check.csv').open('w',newline='') as f:
        writer=csv.writer(f);writer.writerow(['z','w0','a_minus_c','delta0','h','a','kappa'])
        for z,w,offer,d in zip(probes,wages,offers,actual):writer.writerow([z,w,offer,d,h,a,kappa])
    violet,cyan,amber,rose,paper,ink='#6D28D9','#0E7490','#F59E0B','#E11D48','#F4F1FD','#14121F'
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':11,'text.color':ink,'axes.labelcolor':ink,'pdf.fonttype':42})
    fig,(ax,gap)=plt.subplots(1,2,figsize=(10.5,3.8),gridspec_kw={'width_ratios':[1.4,1]},layout='constrained')
    for panel in (ax,gap):
        panel.set_facecolor(paper); panel.spines[['top','right']].set_visible(False);panel.grid(alpha=.16);panel.set_xlabel('Conocimiento humano $z$')
    ax.plot(grid,uniform_wage(grid,h),color=cyan,lw=2.5,label=r'$w^0(z)$: sin IA')
    ax.plot(grid,a-kappa*(1-grid),color=violet,lw=2.5,label=r'$a-c(z)$: oferta neta')
    ax.set_ylabel('Unidades del bien final');ax.legend(frameon=False,loc='upper left');ax.set_title('Comparación a salarios iniciales',fontsize=12)
    d=entry_gap(grid,h,a,kappa)
    gap.axhline(0,color=ink,lw=.8);gap.plot(grid,d,color=violet,lw=2)
    gap.fill_between(grid,0,d,where=d>0,color=amber,alpha=.5)
    gap.scatter(probes,actual,c=[rose,cyan,rose],zorder=4)
    for x,y,label in zip(probes,actual,['−0.0070','+0.0081','−0.0232']):gap.annotate(label,(x,y),xytext=(4,8),textcoords='offset points',fontsize=9)
    gap.set_title(r'$\Delta^0(z)$: detalle $0\leq z\leq0.65$',fontsize=12);gap.set_ylabel('Ventaja de entrada');gap.set_xlim(-.035,.65);gap.set_ylim(-.04,.02)
    fig.savefig(ROOT/'figures/entry_check.pdf',metadata={'Title':'Entrada a salarios iniciales; no es equilibrio','Author':'Sofía Belén Vásquez García','CreationDate':None,'ModDate':None})
    plt.close(fig)
    print('Tabla Δ0:',', '.join(f'{x:+.4f}' for x in actual))
    print('Caso κ=0 y condiciones del baseline: OK. Equilibrio con validación: pendiente.')

if __name__=='__main__':
    symbolic_checks();numeric_checks()
