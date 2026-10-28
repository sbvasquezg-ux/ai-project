# Dos proposiciones del curso probadas en Lean

Fuente: [paper propio fijado en 3fb4aab](https://github.com/sbvasquezg-ux/ai-project/blob/3fb4aab2a2064fb39fa79d48bcfcbc49eb7920fd/paper/paper.pdf). Implementación desarrollada en AppliedModelingLib 194edcc; la carpeta se exportó completa, respetando sus ignores.

| Paper | Endpoint | Resultado |
|---|---|---|
| Proposición 1 | `proposition_one : PropositionOneSpec` | FOC, beneficio cero, renta, salario y pendiente desde un entorno activo. |
| Proposición 2 | `proposition_two : PropositionTwoSpec` | Existencia y unicidad de asignaciones y salarios, con y sin IA, más la ganancia neta. |

`Equilibrium.lean` representa las nueve actividades, los recursos, todas las alternativas y el mercado de cómputo. `ThreeType.lean` construye el candidato y descarta cualquier otro. No se añade existencia/optimalidad/unicidad como hipótesis.

**Chequeo del curso:** --fast pasó, junto con builds forzados de todos los módulos. [Registros](check-output.txt) · [Revisión independiente](docs/SOURCE_CODE_REVIEW.md) · [Informe y alcance](docs/COURSE_VALIDATION_REPORT.md). Sin huecos ni axiomas adicionales. No se atribuye a las simulaciones una prueba del continuo.

**Pendiente de la autora:** sus derivaciones manuscritas y veredicto.

Nota del registro AML: `status.json.status` conserva el estado administrativo parcial porque no se emitió el recibo avanzado de publicación v12; `course_delivery_status` deja constancia de que las DOS proposiciones están probadas. No hay una proposición pendiente ni una revisión humana inventada. La corrida Sol/xhigh se interrumpió por cuota después de compilar; el asistente ejecutó el chequeo final. Para reproducir los resultados sin AML: `bash check.sh`.
