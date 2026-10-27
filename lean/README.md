# Formalización parcial del paper propio

Generada en AppliedModelingLib, commit 194edcc95df74806a39b961d10dedddc6e730cce, con `scripts/paper_contribution.py new`, y desarrollada para este manuscrito. No se reutilizó una formalización de otro estudiante.

Fuente fijada: [paper por commit](https://github.com/sbvasquezg-ux/ai-project/blob/3fb4aab2a2064fb39fa79d48bcfcbc49eb7920fd/paper/paper.pdf). Identidad exacta en `source-pin.json`. El texto principal de las proposiciones se conserva en la entrega posterior; el apéndice de estado puede actualizarse.

- `ProofInterface.proposition_one`: FOC, relación con renta, identidad salarial y pendiente bajo igualdad local.
- `MainTheorems.middle_certificate`: recursos y holguras del candidato de tres tipos, a partir de desigualdades primitivas.
- `net_output_gain`, `net_output_gain_positive`: identidad y signo de la ganancia.
- `exact_three_type_certificate`: comprobación racional del ejemplo.

**Cobertura parcial de Proposición 2.** No se certifica su unicidad global, optimalidad como teorema completo de equilibrio ni el continuo. El certificado no se cuenta como una traducción de toda esa proposición. No existe un recibo de cierre semántico aceptado de AppliedModelingLib ni revisión humana terminada.

Comprobaciones: `lake build +Vasquez26HeterogeneousVerification` y `python3 scripts/paper_contribution.py check Vasquez26HeterogeneousVerification --fast` desde AppliedModelingLib. Logs en `check-output.txt`. El check rápido verifica compilación y aislamiento; no certifica toda la semántica del paper. Solo axiomas estándar: propext, Classical.choice y Quot.sound.

Para reproducir fuera de AppliedModelingLib, con elan instalado: `bash check.sh`. La primera ejecución descarga la versión fijada de Mathlib y su caché; `.standalone/` queda fuera de git.

Una revisión adicional con GPT-5.6 Sol/xhigh se ejecutó sobre el clon público (dictamen en `paper/independent-review.md` del proyecto). No produjo estas pruebas ni completó el protocolo; la configuración de una corrida completa de formalización de la consigna no se acredita con esa revisión. La condición del certificado para H se alineó con la elegibilidad del paper. Las rutas `papers/...` son relativas al repositorio AppliedModelingLib original, conservadas al exportar; los contadores de inventario son informativos y no representan aprobación humana.
