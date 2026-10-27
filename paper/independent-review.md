# Revisión independiente sobre el repositorio público

Modelo: `gpt-5.6-sol`; razonamiento `xhigh`; sesión `01a17af1-a48f-7291-870a-50457d3b67b2`. Fuente revisada: commit `450b4d1`. El proceso terminó con exit 0. Es revisión adicional de matemáticas y código; no acredita que ese modelo haya producido la formalización ni un cierre semántico completo.

## Respuesta cruda del revisor

## Dictamen

No encontré errores matemáticos en las pruebas manuscritas de las Proposiciones 1 y 2, sus desigualdades ni el ejemplo racional. Sí encontré límites importantes —correctamente reconocidos en parte— en la cobertura Lean y dos inconsistencias de estado/metadatos.

### Matemática

- **Proposición 1:** la derivada
  \[
  n'(z)=\frac1{h(1-z)^2},\qquad \frac{n'}n=\frac1{1-z}
  \]
  y la FOC son correctas. Beneficio cero implica
  \(a-w-c=rh(1-z)\), de donde \(w'+c'=hr\); con \(r=0\), \(w=a-c\), y para \(c=\kappa(1-z)\), \(w'=\kappa\). La interioridad \(0<z<a\), diferenciabilidad local y \(h>0\) justifican Fermat y las divisiones. Véase [paper/paper.tex:58](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:58>).

- **Hipótesis implícita menor:** la conclusión sobre la pendiente requiere beneficio cero para todos los tipos de un entorno activo, no solo en un punto. El texto lo aclara inmediatamente después, por lo que no constituye un error. Véase [paper/paper.tex:63](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:63>) y [paper/paper.tex:82](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:82>).

- **Proposición 2:** la construcción es factible y el argumento primal–dual de unicidad es válido. La identidad
  \[
  v_L+hv_M-m=(v_M-m)+Hh(1-h)(1-m)>0
  \]
  es algebraicamente correcta. Con IA, todas las actividades no utilizadas tienen holgura estricta; por complementariedad, cualquier óptimo solo puede usar \(LH\), IA de \(M\) e independencia de \(H\). Los recursos y la masa positiva de esas actividades fijan tanto cantidades como salarios. Véase [paper/paper.tex:118](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:118>) y la formulación primal–dual en [paper/paper.tex:205](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:205>).

- La desigualdad \(b_M\beta<h<\mu\) empleada en la prueba se deduce de \(b_M=h(1-m)\), \(m>0\), \(\beta<1\) y la normalización de masas; no es una hipótesis nueva. Véase [paper/paper.tex:126](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:126>).

- La diferencia de producto
  \[
  Y^V-Y^0=\beta(q_M-v_M)
  \]
  también es correcta. Véase [paper/paper.tex:132](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:132>).

### Ejemplo racional

Todos los valores y signos declarados son exactos:

\[
b_M=\frac38,\quad v_L=\frac{19}{50},\quad v_M=\frac{19}{40},\quad
q_L=\frac7{20},\quad q_M=\frac{193}{400},\quad q_H=\frac{941}{1250}.
\]

Los márgenes relevantes son:

\[
\gamma-h\alpha-b_M\beta=\frac3{40}>0,\quad
q_M-v_M=\frac3{400}>0,\quad
H-q_H=\frac9{1250}>0.
\]

Además, \(d_H^V=9/40\), \(Y^0=0.551\), \(Y^V=0.554\), la ganancia es \(3/1000\), el producto bruto es \(0.713\) y el costo es \(0.159\). Todo coincide con [paper/paper.tex:140](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:140>).

### Límites exactos de Lean

Lean cubre:

- derivada de `span`, FOC, consecuencia de beneficio cero, identidad salarial con \(r=0\) y derivada de una oferta lineal local ([lean/MainTheorems.lean:15](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/MainTheorems.lean:15>));
- una especificación conjuntiva de esos resultados locales ([lean/PaperInterface.lean:8](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/PaperInterface.lean:8>));
- holguras y recursos del candidato de tres tipos, la identidad de ganancia y el ejemplo racional ([lean/MainTheorems.lean:67](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/MainTheorems.lean:67>), [lean/MainTheorems.lean:108](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/MainTheorems.lean:108>)).

No cubre:

- una noción formal de actividad usada, libre entrada o equilibrio;
- el paso de “intervalo usado” a igualdad salarial local: `active_interval_slope` recibe esa igualdad como hipótesis ([lean/MainTheorems.lean:62](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/MainTheorems.lean:62>));
- optimalidad, existencia o unicidad de la Proposición 2, ni el equilibrio sin IA;
- el modelo continuo, las simulaciones o su convergencia.

Además, `middle_certificate` exige \(q_H<H\) **incondicionalmente** ([lean/MainTheorems.lean:82](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/MainTheorems.lean:82>)), mientras el manuscrito solo lo exige cuando \(H\le a\) ([paper/paper.tex:101](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/paper.tex:101>)). Por tanto, el certificado Lean general es más restrictivo que la proposición.

### Estado y metadatos

- La fuente formalizada está fijada al commit anterior `3fb4aab…`, no al commit revisado `450b4d1…` ([paper/formalization-status.tex:1](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/formalization-status.tex:1>), [lean/status.json:100](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/status.json:100>)). La afirmación de que las proposiciones se conservaron no constituye una comprobación semántica del commit actual.

- `status.json` apunta a una interfaz bajo `papers/...` y registra cero líneas y cero filas ([lean/status.json:25](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/status.json:25>)), aunque la interfaz revisada contiene una especificación de 23 líneas. El inventario está desactualizado o describe otro artefacto.

- El propio estado deja `paper_coverage_required: false`, listas de cobertura vacías y solo una ruta para la Proposición 1 ([lean/status.json:87](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/lean/status.json:87>)). Esto confirma que no existe cierre semántico completo.

No compilé el proyecto ni verifiqué los registros externos mencionados; tampoco completé el protocolo semántico de AppliedModelingLib. Las afirmaciones de compilación de [paper/formalization-status.tex:12](</Users/belenvasquez/Documents/Codex/2026-10-04/https-github-com-sbvasquezg-ux-ai/work/final/public-review/paper/formalization-status.tex:12>) son afirmaciones del repositorio, no resultados de esta revisión.

## Respuesta del asistente a los hallazgos

- Se alineó `middle_certificate` con la condición `H ≤ a → qH < H` del paper y se recompiló. El dictamen crudo describe la versión anterior.
- Se actualizaron los contadores del inventario: 23 líneas, una especificación y cero revisiones humanas; las rutas `papers/...` son las de AppliedModelingLib, conservadas al exportar.
- Se compararon exactamente ambas proposiciones y pruebas con la fuente fijada: coinciden byte por byte. Evidencia en `lean/audit/proposition_source_comparison.json`. No equivale a cierre semántico del manuscrito.
- Se mantiene el estado parcial: falta la noción global de equilibrio, optimalidad y unicidad de la Proposición 2, inventario semántico completo y revisión humana. El revisor no recompiló; la recompilación posterior fue ejecutada por el asistente.

Nota terminológica: «pruebas manuscritas» en el dictamen significa pruebas del manuscrito LaTeX. No se revisaron derivaciones a mano ni fotografías.
