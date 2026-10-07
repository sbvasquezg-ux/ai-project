# Guion de estudio y exposición — 20 minutos

Este guion acompaña **13 slides centrales**, seguidas de los apéndices A–C. Es una ayuda de estudio, no evidencia de comprensión ya adquirida. Los tiempos suman 20 minutos; practica con cronómetro y deja los apéndices para preguntas.

| Slide | Tiempo | Acumulado |
|---|---:|---:|
| 1. Título | 0:30 | 0:30 |
| 2. Pregunta | 1:30 | 2:00 |
| 3. Baseline | 2:00 | 4:00 |
| 4. Primitivas | 1:30 | 5:30 |
| 5. Costo | 1:30 | 7:00 |
| 6. Firma | 1:30 | 8:30 |
| 7. FOC | 2:30 | 11:00 |
| 8. Beneficio cero | 1:30 | 12:30 |
| 9. Entrada y conjetura | 1:30 | 14:00 |
| 10. Ejemplo | 1:30 | 15:30 |
| 11. Apéndices y versiones | 1:00 | 16:30 |
| 12. Literatura cercana | 1:30 | 18:00 |
| 13. Plan y riesgos | 2:00 | 20:00 |

## 1. Título

«Mi proyecto pregunta si una fricción que depende del conocimiento puede cambiar quién usa directamente un copiloto. Es una extensión formal de la Proposición 6 de Ide y Talamàs, no un modelo ya cerrado. Presentaré la pregunta, el baseline, el resultado esperado, los antecedentes y el plan.»

## 2. La pregunta

En el original, todos pueden acceder técnicamente al mismo copiloto. Tú agregas que validar tiene un costo distinto por trabajador. Un principiante paga más; alguien con más conocimiento paga menos, por supuesto. Pero ese segundo trabajador también tiene mejores alternativas: podría trabajar con otro humano, resolver problemas o producir de forma independiente. Esos dos efectos compiten. La pregunta trata **usuarios directos**, no si los no usuarios ganan o pierden salario.

Para comprobar que lo entiendes: explica con tus palabras por qué no basta decir «el experto valida mejor, entonces adopta». Debes mencionar el costo de oportunidad y el ajuste salarial.

## 3. Baseline

El resultado específico es la Proposición 6 en p.27 de v11. Con adopción, los menos conocedores usan la IA como asesora. El salario que esa actividad financia es plano, igual a a, porque la renta del cómputo es cero y no hay otro gasto en esa actividad. Si a no supera el salario inicial más bajo, no entra esa IA. En el original las letras son z_AI, w y w estrella: tú usas a, w cero y w N. No cambias el significado económico.

No confundas «salario plano entre usuarios» con «todos los humanos ganan a». Los demás pueden trabajar en otras actividades y cobrar salarios diferentes.

## 4. Primitivas

z es conocimiento humano: en el modelo puede interpretarse como el conjunto de problemas que la persona resuelve. a es la capacidad de la IA. h es tiempo de ayuda por consulta. Cuando z aumenta hay menos problemas que escalar; por eso una unidad de IA atiende más trabajadores: n(z)=1/[h(1-z)]. h_0 depende de G y marca el régimen del baseline sin productores independientes. Con G uniforme, el ejemplo h=.5 está debajo de .75.

μ mide cómputo total, r su precio. Cada trabajador requiere como máximo h unidades de cómputo y hay masa humana uno. μ>h garantiza capacidad ociosa; por complementariedad, r=0. No necesitas afirmar que el cómputo sea literalmente gratuito de producir: estás hablando de su renta de equilibrio en esta dotación fija.

## 5. La fricción

c(z) es gasto por trabajador y período, en unidades del bien final. Piensa en una obligación operativa de validar/documentar que cuesta menos a tipos con más conocimiento. Es una representación reducida; no estás modelando minutos adicionales ni cómo se detecta un error. Si validaras gastando tiempo del mismo trabajador o de un gerente, necesitarías cambiar la tecnología y n(z). Esa sería otra extensión.

En c(z)=κ(1-z), κ≥0. Al derivar respecto de z, c'=-κ. Esta propiedad es un supuesto económico, no un hallazgo empírico de que contratar expertos siempre es más barato.

## 6. Firma

El término entre corchetes es producto menos salario menos gasto por trabajador. Multiplicas por n porque una firma de esta actividad usa n trabajadores por unidad de IA; al final restas r, el alquiler de esa unidad. La empresa puede escoger qué tipo contratar, pero toma el salario de cada tipo como precio de mercado. No elige unilateralmente el salario ni la educación de la persona.

La restricción z≤a conserva el dominio de la actividad con IA asesora. Distingue parámetros fijos (a,h,κ,r al derivar) de funciones que varían con z (n,w,c).

## 7. FOC, paso a paso

Escribe Π=n×margen−r. Por la regla del producto, Π'=n'×margen+n×margen'. Como a es fijo, margen'=−w'−c'. Esa es la FOC igualada a cero. Derivar n da 1/[h(1-z)²], de modo que n'/n=1/(1-z). Dividir la FOC por n, que es positivo, deja w'+c'=(a−w−c)/(1-z).

La intuición: al contratar alguien con más conocimiento aumenta la escala atendible, pero también cambia el costo por trabajador. c'<0 contrarresta el crecimiento salarial. Esto es una condición necesaria en un óptimo interior diferenciable. No es suficiente para un máximo global ni funciona como igualdad obligatoria en extremos.

Pausa de estudio: vuelve a obtener la regla del producto sin mirar. Si olvidas un signo, comprueba que un costo creciente debería perjudicar el margen.

## 8. Beneficio cero

**Este es un paso distinto a la FOC.** Competencia y libre entrada implican cero beneficio en las actividades usadas: n(a−w−c)=r. Dividiendo por n obtienes a−w−c=rh(1-z). Solo ahora reemplazas el margen en la FOC y aparece hr. Al imponer r=0, la identidad de beneficio cero deja w=a−c.

Con costo lineal, w'=κ **en un intervalo activo diferenciable**. Si solo sabes que un tipo está activo, puedes escribir la igualdad de nivel, pero no inferir una derivada de todo el salario de equilibrio. Tampoco sabes aún quién está activo. Si todas esas igualdades valen en un intervalo, las firmas pueden ser indiferentes entre sus tipos: no has demostrado un óptimo único.

## 9. Entrada y conjetura

Δ cero compara la oferta neta de la nueva actividad con el salario de la economía **antes** de que entre. Si es positiva, una firma podría pagar algo más que el salario inicial y conservar margen. Si es negativa, no puede competir con ese salario inicial mediante esta actividad. Derivando, Δ'=κ−w cero prima: cuando el ahorro de costo domina el aumento salarial inicial, la ventaja crece.

Con costo constante la oferta solo baja de nivel; con costo decreciente también se inclina. Para separar efectos compararás tanto κ=0 como costos constantes, incluyendo un costo constante de igual promedio. La conjetura no dice que cualquier κ positivo cause selección intermedia, ni que la condición de pendiente sea suficiente.

## 10. Ejemplo

En z=0, la oferta es .88−.53=.35 y el salario inicial .3570: no alcanza. En z=.25, c=.3975, la oferta .4825 supera .4744: aparece una oportunidad pequeña. En z=.60, aunque c cae, la alternativa salarial .6912 supera la oferta .668. Esto muestra el conflicto entre validar barato y tener una buena alternativa.

La figura izquierda muestra los niveles y la derecha amplía la diferencia. El código falla si no reproduce −.0070, +.0081 y −.0232 dentro de 5e−4. Los parámetros son ilustrativos, no estimados. El reajuste del salario puede borrar el intervalo atractivo.

## 11. Apéndices y versiones

El argumento del Lema2.7 usa que los usuarios de IA cobran lo mismo. Tu costo hace que esa igualdad salarial ya no sea plana. Eso explica qué paso hay que reexaminar; no prueba automáticamente el resultado contrario. Se revisaron las doce versiones: la v7 llama «no autónoma» a otra tecnología; v8–v10 ya tienen el resultado de copilotos con otra numeración. Por eso citas v11 y su página exacta.

## 12. Antecedentes

No digas que nadie ha modelado verificación. Xu y coautores ya incorporan validación gerencial, pero cuesta tiempo y elimina alucinaciones. Quispe y Xu ya suponen un costo de verificar que cae con habilidad: su banda de activación es de lenguajes de un desarrollador. Catalini y coautores relacionan verificación y experiencia y advierten el papel de salarios expertos. Tu aporte propuesto es más estrecho: insertar c(z) en el equilibrio de la Proposición6, con salarios y ocupaciones endógenos y tecnología fija.

La búsqueda tiene límites: se inspeccionaron las primeras páginas de Scholar y textos cercanos, no todas las citas; Semantic Scholar no dejó recuperar el listado. La novedad sigue siendo provisional. Turing Valley está anunciado como aceptado, no lo llames ya publicado en la revista.

## 13. Plan y riesgos

Probarás la forma del conjunto de usuarios y recuperarás el caso sin costo. Simularás el LP con producto neto, sin alterar restricciones de recursos; revisarás factibilidad y dualidad y repetirás con mallas más finas. Lean formalizará primero FOC e identidad con hipótesis explícitas y después la proposición propia, una vez que tenga prueba. Hoy no hay certificación Lean del proyecto.

Lo más difícil es cerrar existencia/unicidad en el continuo y conservar selección intermedia después de la reasignación. Si falla, el plan B es un modelo de dos o tres tipos con precios y asignación completos. Si la conjetura resulta falsa, reportarás las condiciones bajo las cuales la base sigue adoptando. La extensión no acusa un error al original.

## Preguntas que debes poder responder

- **¿Por qué w=a−c?** Por beneficio cero y r=0 en una actividad utilizada, no por la FOC sola.
- **¿κ>w0' prueba tu resultado?** No. Solo da pendiente positiva a la ventaja a salarios iniciales.
- **¿El costo cambia n?** No bajo mi definición de gasto real; sí podría hacerlo otro modelo de tiempo.
- **¿Qué prueba el código?** Identidades simbólicas y reproducción numérica; no existencia ni selección en el nuevo equilibrio.
- **¿Qué certifica Lean hoy?** Nada del proyecto todavía. Hay un plan, no una prueba completada.
- **¿Qué es propio?** La fricción insertada aquí, la conjetura y el ejercicio de entrada. El baseline es del paper y las fórmulas uniformes se portan del repo anterior.
- **¿Por qué no cambiar directamente w0 por a−c para todos?** Porque humanos con otras ocupaciones tienen restricciones salariales y de asignación; la igualdad solo es obligatoria donde IA está activa.

Los apéndices A–C son para profundizar en extremos/segunda derivada, cierre de equilibrio y referencias. Si los 20 minutos incluyen preguntas, ensaya una versión de 18 minutos acortando las slides3 y13 y dejando 2 minutos de discusión.
