# Validación de las dos proposiciones del curso

**Resultados numerados abiertos: ninguno.** La Proposición 1 y la Proposición 2 tienen enunciados transparentes y pruebas completas en `PaperInterface.lean` y `ProofInterface.lean`.

La segunda construye el equilibrio competitivo y prueba que cualquier otro tiene sus mismas nueve masas y sus mismos salarios/renta. Se revisan todas las actividades y restricciones, no solo el candidato. La renta cero se deriva de abundancia de cómputo. También se prueba el equilibrio inicial y la ganancia neta. El continuo no es un resultado afirmado por la proposición.

Fuente: paper propio fijado en 3fb4aab. Los enunciados y pruebas matemáticas del paper permanecen iguales. El cambio consiste en completar su traducción formal. La revisión independiente de los seis archivos está en `SOURCE_CODE_REVIEW.md`; no fue realizada por la autora ni equivale a adjudicación humana.

## Comprobaciones reales

Se ejecutó un único build `lake --rehash build` con targets forzados de los seis módulos/importación raíz, y después `python3 scripts/paper_contribution.py check Vasquez26HeterogeneousVerification --fast`. Ambos finalizaron con salida 0. Los registros íntegros de esta comprobación están en `../check-output.txt`. Las pruebas usan únicamente propext, Classical.choice y Quot.sound. No tienen sorry, admit, native_decide ni axiomas añadidos.

## Modelo solicitado por el curso

Se ejecutó GPT-5.6 Sol/xhigh en una copia nueva de AppliedModelingLib y del proyecto público. Partió de las pruebas publicadas en fd89b2a y explicitó condiciones del paper y funciones primitivas, sin añadir condiciones económicas. La cuota terminó durante una auditoría adicional. El chequeo final del código resultante lo ejecutó el asistente coordinador; no se atribuye a ese modelo ni a la autora una validación no realizada.

## Límite administrativo del registro AML

Este informe documenta el criterio de entrega del curso: dos resultados numerados probados y el chequeo --fast exitoso. No es un recibo aceptado del protocolo avanzado v12 de publicación de AML. Ese protocolo encontró un problema de RLIMIT_AS en macOS y no se terminó. El campo de catálogo `status` conserva `partially formalized` exclusivamente para no fingir ese cierre, mientras `course_delivery_status` y los resultados detallan la cobertura real completa del curso. Ninguna proposición del paper sigue abierta en Lean.

## Único requisito personal pendiente

La autora debe escribir las derivaciones, fotografiarlas y emitir su propio veredicto; la slide 17 sigue declarando ese material pendiente. No hay fotos ni aprobación humana fabricadas.
