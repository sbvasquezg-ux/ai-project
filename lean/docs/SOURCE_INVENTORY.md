# Source-only intake report

Validator: `/root/source_inventory`. Timestamp: `2026-10-28T02:11:16Z`. Canonical public paper commit: `3fb4aab2a2064fb39fa79d48bcfcbc49eb7920fd`.

Read all canonical paper.tex lines 1–241 without Lean, source maps, prior audit judgments or other agents work. Independently identified four assumptions, two propositions, actual prose prerequisites and standalone holistic deep candidates. Ordinary numbered equation labels are context, not extra named results. The formalization-status input at 227 was not expanded. This is source-only intake, not semantic correspondence or acceptance. No PDF was needed. No builds or canonical audit mutations were performed.

## Named floor

| Stable item | Exact span | Visible label | Disposition |
|---|---|---|---|
| `assumption_technology` | `.audit_source/paper.tex:35-37` | Supuesto 1 — Tecnología e información (ass:tech) | material_named_claim |
| `assumption_ai_cost` | `.audit_source/paper.tex:38-40` | Supuesto 2 — IA y gasto real (ass:ai) | material_named_claim |
| `assumption_compute` | `.audit_source/paper.tex:41-43` | Supuesto 3 — Cómputo (ass:compute) | material_named_claim |
| `assumption_finite` | `.audit_source/paper.tex:50-52` | Supuesto 4 — Especialización finita (ass:finite) | material_named_claim |
| `proposition_one` | `.audit_source/paper.tex:58-64` | Proposición 1 — FOC y salario de una actividad usada (prop:local) | material_named_claim |
| `proposition_two` | `.audit_source/paper.tex:96-111` | Proposición 2 — Régimen intermedio de tres tipos (prop:middle) | material_named_claim |

Exactly four numbered assumptions and two numbered propositions occur. There are no labelled remark, observation, note, example or definition environments. The ordinary eq: labels (firm, foc, surplus, offers, high, prices3, gain and slack) do not independently create further named results.

Proposition 1 owns the derivative calculations, zero-profit identity and level-versus-slope explanation at 65–82. Proposition 2 owns interpretation/scope at 112–116, construction and activity-profit checks at 118–128, uniqueness at 130, output accounting at 132–137, and the weighted-sum certificate at 220. These are context/support, not additional theorem claims.

## Holistic deep candidates

All unnumbered standalone presentations below retain deep_audit_material disposition.

| Presentation | Exact source span | Source-only reason |
|---|---|---|
| Resultado que se extiende | `.audit_source/paper.tex:24-26` | Attributed baseline threshold, wages and adoption ordering; background, not a new result of this paper. |
| FOC insufficiency and unilateral endpoint conditions | `.audit_source/paper.tex:84` | Standalone unnumbered observation beyond the interior proposition; deep review only. |
| n(z)c(z)=kappa/h and affine worker offer | `.audit_source/paper.tex:86` | Standalone unnumbered algebraic identity and interpretation. |
| Un equilibrio racional que satisface las condiciones | `.audit_source/paper.tex:140-162` | Worked example with exact primitives, inequalities, wages, allocations and output; no numbered Example label. |
| Qué cambia frente al topic: initial Delta^0 comparison | `.audit_source/paper.tex:165` | Assertion about an earlier table not reproduced here; not an equilibrium theorem. |
| Example wage incidence and direct non-adoption | `.audit_source/paper.tex:167` | Unnumbered example-specific wage observation and interpretation. |
| Simulaciones: población uniforme y controles — setup | `.audit_source/paper.tex:170` | Computational population, midpoint grid and primal/dual interpretation; does not govern the named propositions. |
| Eligible-type average constant cost | `.audit_source/paper.tex:172` | Average-cost formula and endogenous-spending qualification. |
| Uniform-grid figure, table and residual claims | `.audit_source/paper.tex:173-184` | Numerical patterns, outputs, tolerance assertions and nonconvergence qualifications; no continuous theorem. |
| Nivel, pendiente y costo de oportunidad | `.audit_source/paper.tex:188` | Initial-price derivative comparison; source says it is insufficient for Proposition 2. |
| Heterogeneous versus matched-average constant-cost output | `.audit_source/paper.tex:190` | Numerical output comparison across technologies with different realized costs. |
| Fronteras del resultado | `.audit_source/paper.tex:193-195` | Zero-cost recovery and model-boundary observations; no general continuous existence, uniqueness or convergence proof. |
| Finite primal nonemptiness, compactness and LP existence | `.audit_source/paper.tex:222` | Additional unnumbered finite program/dual existence argument; does not settle the continuous limit. |

Abstract 14, introduction 19–21, conclusion 198, and collaboration table 233–236 repeat or summarize these presentations. Literature 28–30 describes other authors. No computation or status assertion is adopted as audit evidence.

## Governing prerequisites

Definitions are prerequisite-lane normal_named_theory_definition records, not extra theorem Specs. JSON clauses are exact literal source slices.

| Definition | Exact span | Owning source item |
|---|---|---|
| Observable types, human mass, problem generation, human solver output and assistance time | `.audit_source/paper.tex:36` | `assumption_technology` |
| AI eligibility, fixed capacity, real validation cost and linear parametrization | `.audit_source/paper.tex:39` | `assumption_ai_cost` |
| Compute endowment, demand bound and idle-compute rent | `.audit_source/paper.tex:42` | `assumption_compute` |
| AI worker capacity n(z) and price-taking choice | `.audit_source/paper.tex:44` | `firm_model` |
| AI firm profit objective and eligible optimization domain | `.audit_source/paper.tex:45-47` | `firm_model` |
| Net offer q(z) and initial-wage comparison Delta^0(z) | `.audit_source/paper.tex:48` | `firm_model` |
| Three-type population, masses, inherited primitives, m<a and divisible occupations | `.audit_source/paper.tex:51-53` | `assumption_finite` |
| Independent, AI-user and human-assisted worker activity masses | `.audit_source/paper.tex:55` | `finite_equilibrium` |
| Feasibility, human clearing, no positive profits and zero profits in used activities | `.audit_source/paper.tex:55` | `finite_equilibrium` |
| b_M, v_L, v_M, q_L, q_M and conditionally eligible q_H | `.audit_source/paper.tex:89-94` | `derived_quantities` |
| Ordered finite types, positive masses and assistance coefficients | `.audit_source/paper.tex:206` | `finite_program` |
| Finite activity domain and net-output maximization objective | `.audit_source/paper.tex:207-209` | `finite_program` |
| Human resources, AI eligibility, compute treatment and divisible y units | `.audit_source/paper.tex:210-214` | `finite_program` |
| Wage-bill objective and independent, AI and human hierarchy no-profit inequalities | `.audit_source/paper.tex:216-219` | `finite_certificate` |
| Activity no-profit interpretation and equality in positive-mass activities | `.audit_source/paper.tex:220` | `finite_certificate` |

Output is defined by the objective at 207–209; the particular output expressions at 132–137 support Proposition 2. Eligibility is stated at 39, inherited at 51, included in the firm domain at 46, conditional expert offer at 94, and finite resource constraint at 212. Human solver eligibility appears at 36, 55 and 206–219. Compute is at 42 and 214. The paper has no separate fully expanded continuous equilibrium system.

## Partition and schema choices

The explicit appendix transition at 204 gives a complete disjoint partition: main_text 1–204 and appendix 205–241. Separate finite_program and finite_certificate keys keep appendix prerequisite anchors in their proper region. Every prepared source item, candidate and prose definition has an explicit region assignment. No promotions or approvals are invented.

- The review is a materializer input plan, not a materialized receipt: no invented schema, hashes or byte anchors.
- The six floor environments are ordinary named presentations, not candidate-ledger entries.
- Candidate dispositions permit only material_named_claim/deep_audit_material; prerequisite definitions use normal_named_theory_definition in the separate prose lane.
- Exact literal source clauses include mathematical displays as needed; no extra theorem Specs are proposed.
- source_item_preparation is scratch metadata; root must bind its stable keys or update exact region assignments.
- Appendix definitions remain prerequisites; no appendix named-result promotions or approval records are asserted.
- No equivalence receipts, reviewed hashes, Lean declarations, semantic match or acceptance statuses are supplied.

Unknowns/limits:

- General h_0(G) is referenced at 36 without a general internal definition; 170 gives the uniform-case value only.
- The formalization-status.tex input at 227 was not opened.
- The external figure at 173 and computation claims are unverified by this intake.
- The equilibrium prose at 55 is completed by precise finite resources/no-profit inequalities at 206–220.
- Root must materialize anchors against its canonical-source metadata and bind actual prerequisite routes separately.
