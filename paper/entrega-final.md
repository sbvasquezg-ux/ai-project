# Cierre de la versión final — 15 de noviembre de 2026

**Autora:** Sofía Belén Vásquez García. **Repositorio:** [sbvasquezg-ux/ai-project](https://github.com/sbvasquezg-ux/ai-project). Fecha límite del curso: jueves 26 de noviembre, 22:00 Lima.

## Versión y alcance

La autora declaró que no recibió observaciones en su exposición y aceptó las contribuciones de IA de la versión final. El mensaje literal se conserva en `../prompts.md`; el apéndice C del paper detalla afirmación, veredicto, razón y comprobación. Esa aceptación no se presenta como una nueva auditoría técnica o una reproducción personal de cada chequeo.

El paper tiene **9 páginas de cuerpo y 13 páginas totales**, con formato de plantilla: 11 puntos, una columna y márgenes de una pulgada. Se conservan las dos proposiciones, sus condiciones, supuestos y pruebas. Se explicita la secuencia de un período y se actualizan fecha, estado, declaración de colaboración y evidencia entregada. El resultado de equilibrio es de tres tipos; el continuo sigue siendo evidencia numérica y una limitación explícita.

## Comprobaciones ejecutadas

| Comprobación | Resultado y evidencia |
|---|---|
| `python3 code/verify.py` | Salida 0; identidades SymPy, tabla de entrada, certificado racional, LP y mallas 100/200/400. [Salida](validation/python-check.txt). |
| `latexmk -pdf` de los cuatro documentos | Salida 0. Propuesta 4 páginas, topic 16, presentación final 22, paper 13. PDFs presentes y rastreados en Git. |
| Compilador del editor | Éxito con raíz del repositorio y `paper/paper.tex` seleccionado. La primera llamada limitada a `paper/` no podía leer la figura hermana; la raíz correcta resuelve el acceso sin cambiar las fuentes. |
| Compilación explícita de módulos Lean | Salida 0 para los seis módulos y la importación raíz; endpoints y axiomas en [salida](validation/lean-build.txt). |
| `python3 scripts/paper_contribution.py check Vasquez26HeterogeneousVerification --fast` | Salida 0 en el clon AML usado para la formalización. [Salida](validation/lean-fast.txt). |
| Correspondencia paper–Lean | Ambos enunciados, todas las pruebas y los supuestos numerados coinciden literalmente con la versión anterior. Los seis archivos Lean coinciden con el clon AML y no se modifican. |
| Integridad | Workflow, evidencia manuscrita y fuentes Lean intactos; hashes en [integrity.json](validation/integrity.json). Sin cajas Replace. |
| Revisión visual | Se inspeccionaron las 13 páginas del PDF para comprobar ecuaciones, figura, tablas y apéndices. |

Comandos de reproducción desde la raíz del proyecto:

```bash
python3 -m pip install -r code/requirements.txt
python3 code/verify.py
latexmk -pdf -cd proposal/proposal.tex
latexmk -pdf -cd slides/topic.tex
latexmk -pdf -cd slides/final.tex
latexmk -pdf -cd paper/paper.tex
```

En el entorno local se utilizaron las dependencias ya instaladas con `PYTHONPATH` y TinyTeX para `latexmk`. El aviso de caché Matplotlib del primer chequeo fue no fatal; el proceso finalizó con salida 0 y los archivos generados coinciden con los rastreados. El workflow de la plantilla instala las dependencias de `code/requirements.txt` en una máquina limpia.

Para Lean, la fuente original sigue fijada en `3fb4aab2a2064fb39fa79d48bcfcbc49eb7920fd`; los endpoints económicos no cambian. Se ejecutaron de nuevo los builds explícitos y el chequeo rápido en AppliedModelingLib `194edcc`. La carpeta exportada se conserva intacta, incluido su estado administrativo: **no se afirma un recibo avanzado AML v12 ni una revisión del dashboard hecha por la autora**. La decisión de aceptación en este chat no cambia esos metadatos históricos.

## Comprobación manuscrita incorporada

`hand/01-revision-kappa.png` conserva la imagen original de la autora con el dominio, la transformación de desigualdades, la prueba de 0≤c(z)≤κ, el ejemplo κ=2 y su veredicto. La slide 17 y el apéndice D del paper presentan esta comprobación. Su descripción es un inventario del material aportado.

Las presentaciones y la guía de estudio conservan sus fechas históricas. La guía privada solicitada para estudiar se mantiene fuera del repositorio público.

## Entrega

La versión se publica mediante `final-paper-submission` → pull request → checks verdes → merge a `main`. No se modifica el workflow ni se escribe directamente a `main`. El link ya publicado en el issue #7 sigue siendo el registro de entrega; no hace falta un comentario nuevo. El resultado del PR y de Actions se informa con los enlaces reales al concluir el merge.
