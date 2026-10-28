# Guion de exposición final — 30 minutos + 15 de discusión

19 slides centrales y 3 apéndices. La exposición es el 28 de octubre, 08:20–09:05 (Lima). El manuscrito de la autora sigue pendiente: la slide 17 debe incorporar una fotografía real y su veredicto antes de exponer.

| Slide | Minutos | Acumulado |
|---|---:|---:|
| 1. Título | 0.5 | 0.5 |
| 2. Pregunta y resultado | 1.5 | 2.0 |
| 3. Baseline | 1.0 | 3.0 |
| 4. Primitivas | 1.5 | 4.5 |
| 5. Asignación y precios | 2.0 | 6.5 |
| 6. Proposición 1 | 1.5 | 8.0 |
| 7. Proposición 2 | 2.0 | 10.0 |
| 8. Regla del producto | 2.0 | 12.0 |
| 9. Beneficio cero | 1.5 | 13.5 |
| 10. Construir la asignación | 1.5 | 15.0 |
| 11. Revisar desvíos | 2.5 | 17.5 |
| 12. Unicidad y producto | 2.0 | 19.5 |
| 13. Ejemplo exacto | 2.0 | 21.5 |
| 14. Simulación uniforme | 1.5 | 23.0 |
| 15. Sensibilidad | 1.5 | 24.5 |
| 16. Lean | 2.0 | 26.5 |
| 17. Revisión de la IA | 1.5 | 28.0 |
| 18. Hecho y abierto | 1.0 | 29.0 |
| 19. Preguntas | 1.0 | 30.0 |

## 1–3. Pregunta, resultado y baseline

«La pregunta es si un gasto real de validación que disminuye con conocimiento puede desplazar el uso directo de IA de la base hacia tipos intermedios. Mi resultado demostrado caracteriza un régimen de tres tipos. No afirmo que ya haya resuelto todo el continuo. En el original, la Proposición 6 pone a los usuarios en la base bajo sus supuestos; mi extensión agrega una fricción propia.»

Define adopción directa: la persona trabaja con la IA como asesora. No adoptar no equivale a perder salario. El teorema y las figuras muestran justamente por qué separar esas dos cosas.

## 4–5. Modelo y cierre

Explica z, a, h, b, n y el gasto c antes de usar fórmulas. La firma toma los salarios por tipo como dados. El gasto no consume tiempo ni modifica éxito. μ>h es una condición suficiente para que sobre cómputo y r=0.

En el primal, d es independiente, x es usuario de IA y y es trabajador con solver humano. El primer sumatorio de recursos cuenta trabajadores; el segundo cuenta el tiempo de solver que requieren trabajadores de otros tipos. Esta segunda suma no es otro trabajador entero: lleva el factor b.

El dual exige no beneficio positivo en todas las actividades. La igualdad se aplica a actividades con masa positiva. No clasifiques adoptantes solo por igualdad salarial: debes mirar x.

## 6–7. Enunciados completos

La Proposición 1 exige máximo local interior y diferenciabilidad para la FOC. Beneficio cero es otra hipótesis, y la pendiente salarial requiere un intervalo activo. La Proposición 2 necesita expertos excedentes, una alternativa humana rentable para M y ofertas netas que discriminen entre base, medio y expertos. Lee las desigualdades y explica cada una. No digas simplemente «si el costo es suficientemente heterogéneo».

La distribución cambia de continuo a tres tipos para el teorema: es el plan B anunciado en el topic. El modelo económico y la fricción se conservan; el supuesto de densidad continua se sustituye explícitamente. Los resultados del continuo son numéricos.

## 8–9. Derivaciones

Dedica tiempo a la regla del producto. Define margen, deriva escala y margen por separado, y muestra por qué aparecen dos signos negativos en n'. Al dividir por n debes comprobar que es positivo. La igualdad derivada es necesaria; aún no demuestra quién contrata a quién.

Después escribe beneficio cero n(a−w−c)=r. Dividir da a−w−c=rh(1−z). Con r=0, despeja w=a−c. En el intervalo activo c'=-κ, de modo que w'=κ. Si te preguntan de dónde sale la igualdad salarial, responde «beneficio cero y renta cero».

## 10–12. Prueba del régimen de tres tipos

Construye, luego verifica: L trabaja con H, M usa IA y el resto de H es independiente. La última actividad fija wH=H; de ella y del beneficio cero de LH sale vL. Verifica recursos tipo por tipo y computo por separado.

Recorre todas las alternativas en la tabla. Detente en LM: muestra la identidad de su holgura y las condiciones que hacen cada término positivo. Esta revisión descarta que la base prefiera contratar al intermedio como solver y es esencial para el resultado.

Para unicidad, explica la cota salarial: cada actividad produce como máximo el valor salarial de los recursos que utiliza. Suma usando vaciado de mercado. El candidato alcanza la cota. Una actividad con holgura estricta no puede entrar en una asignación óptima. Los recursos fijan las tres actividades restantes; sus igualdades fijan los salarios. Esta prueba completa del modelo de tres tipos ya está formalizada en Lean; no la confundas con una prueba del continuo.

Resta los productos y muestra la cancelación. La ganancia es la masa de M por cuánto supera su oferta de IA al salario humano que financiaba antes.

## 13–15. Ejemplo y simulaciones

En el ejemplo racional, qL=.35 está debajo de .38; qM=.4825 supera .475; qH=.7528 está debajo de .76. Solo M adopta. La base conserva salario; el producto sube .003. Hay certificado exacto y LP independiente. Los números no están calibrados.

En el uniforme, muestra primero salarios y luego cantidades adoptantes. El costo constante tiene el mismo promedio entre elegibles del continuo, no el mismo gasto realizado. Con heterogeneidad los adoptantes están cerca de z=.23–.27, lejos de la base. El patrón persiste en tres mallas, pero la masa no converge monótonamente. Los residuos son pequeños; eso certifica cada LP concreto y no el continuo.

## 16. Lean

La slide muestra la cláusula con IA de PropositionTwoSpec: hay un equilibrio candidato y cualquier otro tiene exactamente sus asignaciones y precios. x contiene nueve masas; p contiene tres salarios y la renta de cómputo. hr reúne solamente las condiciones primitivas de la Proposición 2, no su conclusión. candidate_equilibrium prueba existencia; equilibrium_unique prueba unicidad. El enunciado completo incluye también la economía sin IA y la ganancia neta. El kernel verifica estas pruebas con todos los usos alternativos del trabajo y la elegibilidad; r=0 se deriva de la capacidad ociosa. No verifica tu comprensión, ni convierte las mallas en un teorema continuo.

## 17. Una afirmación de la IA que requiere tu veredicto

Un borrador anterior introdujo κ<1 aunque el modelo solo exigía κ≥0. La no negatividad c(z)=κ(1−z) para z∈[0,1] no requiere esa cota superior. Escribe esa prueba a mano y confirma tu propio veredicto. La slide actual explica el hallazgo y declara el manuscrito pendiente; no debes decir que ya lo hiciste si no existe la fotografía.

Como segunda precaución, distingue Δ0>0 de adopción de equilibrio: usa salarios previos, y necesitas resolver el reajuste.

## 18–19. Límite y preguntas

«He demostrado un régimen suficiente de tres tipos, he verificado sus números y he encontrado un patrón compatible en mallas uniformes. No he probado la caracterización continua ni su convergencia. Quiero discutir si esta fricción real aísla un mecanismo útil, qué condiciones permitirían pasar al continuo y cuál comparación de costos es más informativa.»

Deja los 15 minutos de discusión. Los apéndices A–C son material de consulta, no otros diez minutos de exposición.
