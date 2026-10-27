"""Chequeos simbólicos, equilibrio finito y aproximación del continuo.

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
    print('Caso κ=0 e ilustración inicial: OK. Los nuevos equilibrios se verifican abajo.')



def full_equilibrium_checks():
    import json
    from equilibrium import equilibrium
    from fractions import Fraction
    rows=[];curves={};h,a,k=.5,.88,.53
    z3=np.array([0.,.25,.76]);m3=np.array([.25,.4,.35])
    exact_w=np.array([.38,.4825,.76])
    base3=equilibrium(z3,m3,h)
    extended3=equilibrium(z3,m3,h,a,k)
    np.testing.assert_allclose(base3.wages,[.38,.475,.76],atol=1e-9)
    np.testing.assert_allclose(extended3.wages,exact_w,atol=1e-9)
    np.testing.assert_allclose(extended3.ai,[0,.4,0],atol=1e-9)
    np.testing.assert_allclose(extended3.independent,[0,0,.225],atol=1e-9)
    assert abs(base3.net_output-.551)<1e-9 and abs(extended3.net_output-.554)<1e-9
    assert abs(extended3.compute_demand-.15)<1e-9
    # Exact rational certificate, independent of the floating-point optimizer.
    L,M,H=map(sp.Rational,['0','0.25','0.76']);hh=sp.Rational(1,2)
    aa=sp.Rational(22,25);kk=sp.Rational(53,100)
    zz=[L,M,H];ww=[sp.Rational(19,50),sp.Rational(193,400),H]
    independent=[0,0,sp.Rational(9,40)];xx=[0,sp.Rational(2,5),0]
    yy={(0,1):sp.Rational(0),(0,2):sp.Rational(1,4),(1,2):sp.Rational(0)}
    mm=[sp.Rational(1,4),sp.Rational(2,5),sp.Rational(7,20)]
    q=[aa-kk*(1-t) for t in zz]
    for i in range(3):
        assert ww[i]>=zz[i] and ww[i]>=q[i]
        use=independent[i]+xx[i]+sum(v for (u,j),v in yy.items() if u==i)
        use+=sum(hh*(1-zz[u])*v for (u,j),v in yy.items() if j==i)
        assert use==mm[i]
        assert independent[i]*(ww[i]-zz[i])==0 and xx[i]*(ww[i]-q[i])==0
    for (i,j),v in yy.items():
        slack=ww[i]+hh*(1-zz[i])*ww[j]-zz[j]
        assert slack>=0 and v*slack==0
    assert sum(mm[i]*ww[i] for i in range(3))==sp.Rational(277,500)
    # Symbolic slack used in the general three-type proof.
    hS,mS,HS=sp.symbols('h m H',real=True)
    vM=HS*(1-hS*(1-mS));vL=HS*(1-hS)
    assert sp.expand((vL+hS*vM-mS)-(vM-mS+HS*hS*(1-hS)*(1-mS)))==0
    # Baseline versus extension output gain in Proposition 2.
    alpha,beta,gamma,qM=sp.symbols('alpha beta gamma qM',real=True)
    Y=alpha*HS+beta*qM+(gamma-hS*alpha)*HS
    Y0=(alpha+beta)*HS+(gamma-hS*alpha-hS*(1-mS)*beta)*HS
    assert sp.expand(Y-Y0-beta*(qM-vM))==0
    for N in [100,200,400]:
        z=(np.arange(N)+.5)/N;mass=np.ones(N)/N
        scenarios={
          'sin_IA':equilibrium(z,mass,h),
          'costo_cero':equilibrium(z,mass,h,a,0),
          'constante':equilibrium(z,mass,h,a,constant_cost=k*(1-a/2)),
          'heterogeneo':equilibrium(z,mass,h,a,k),
        }
        for name,e in scenarios.items():
            used=np.flatnonzero(e.ai>1e-8)
            rows.append(dict(N=N,scenario=name,net_output=e.net_output,gross_output=e.gross_output,
              validation_spending=e.validation_spending,ai_mass=float(e.ai.sum()),
              ai_min=float(z[used[0]]) if len(used) else '',ai_max=float(z[used[-1]]) if len(used) else '',
              compute_demand=e.compute_demand,**e.diagnostics))
            if name=='heterogeneo':
                assert len(used)>0 and .15<z[used[0]]<.35 and z[used[-1]]<.4
                assert e.ai[z<.15].sum()<1e-8
                assert e.net_output>scenarios['sin_IA'].net_output
        baseline=uniform_wage(z,h)
        assert np.max(np.abs(scenarios['sin_IA'].wages-baseline))<.03
        if N==400:curves=scenarios
    with (ROOT/'output/equilibrium_summary.csv').open('w',newline='') as f:
        writer=csv.DictWriter(f,fieldnames=list(rows[0]));writer.writeheader();writer.writerows(rows)
    e=curves['heterogeneo']
    with (ROOT/'output/equilibrium_types.csv').open('w',newline='') as f:
        writer=csv.writer(f);writer.writerow(['z','mass','wage','AI','independent'])
        writer.writerows(zip(e.z,e.mass,e.wages,e.ai,e.independent))
    # Every exact equilibrium table value is serialized from the checked solution.
    with (ROOT/'output/three_type.csv').open('w',newline='') as f:
        writer=csv.writer(f);writer.writerow(['z','mass','w0','wV','AI','independent'])
        writer.writerows(zip(z3,m3,base3.wages,extended3.wages,extended3.ai,extended3.independent))
    exact_report={'baseline_output':base3.net_output,'extended_output':extended3.net_output,
      'gain':extended3.net_output-base3.net_output,'compute':extended3.compute_demand,
      'certificate':'rational SymPy + independent LP','diagnostics':extended3.diagnostics}
    (ROOT/'output/three_type_certificate.json').write_text(json.dumps(exact_report,indent=2)+'\n')
    make_equilibrium_figures(curves,rows)
    print('Proposición 2: certificado racional y LP de tres tipos OK; Y0=.551, YV=.554, usuarios IA=(0,.4,0).')
    for row in rows:
        if row['scenario']=='heterogeneo':print('Malla',row)
    return rows

def make_equilibrium_figures(curves,rows):
    colors={'sin_IA':'#14121F','costo_cero':'#0E7490','constante':'#F59E0B','heterogeneo':'#6D28D9'}
    labels={'sin_IA':'Sin IA','costo_cero':'Costo cero','constante':'Costo constante','heterogeneo':'Costo heterogéneo'}
    fig,(ax,bx)=plt.subplots(1,2,figsize=(10.5,4),layout='constrained')
    for name,e in curves.items():
        ax.plot(e.z,e.wages,color=colors[name],label=labels[name],lw=2)
        bx.plot(e.z,e.ai/e.mass,color=colors[name],label=labels[name],lw=1.6)
    for panel in (ax,bx):
        panel.spines[['top','right']].set_visible(False);panel.grid(alpha=.15);panel.set_xlabel('Conocimiento humano $z$')
    ax.set_ylabel('Salario de equilibrio');bx.set_ylabel('Fracción del tipo que usa IA')
    ax.legend(frameon=False,fontsize=9);bx.set_xlim(0,.9);bx.set_ylim(-.03,1.06)
    fig.savefig(ROOT/'figures/equilibrium.pdf',metadata={'CreationDate':None,'ModDate':None});plt.close(fig)
    fig,ax=plt.subplots(figsize=(7.7,3.6),layout='constrained')
    for name in colors:
        rr=[r for r in rows if r['scenario']==name]
        ax.plot([r['N'] for r in rr],[r['net_output'] for r in rr],marker='o',color=colors[name],label=labels[name])
    ax.set(xlabel='Número de tipos en la malla',ylabel='Producto neto',title='Sensibilidad a la discretización')
    ax.spines[['top','right']].set_visible(False);ax.legend(frameon=False,fontsize=9);ax.grid(alpha=.15)
    fig.savefig(ROOT/'figures/grid_check.pdf',metadata={'CreationDate':None,'ModDate':None});plt.close(fig)

if __name__=='__main__':
    symbolic_checks();numeric_checks();full_equilibrium_checks()
