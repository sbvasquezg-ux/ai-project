# Non-certifying source-to-interface diagnostic

This report is a bounded repair screen, not a semantic receipt, formal evidence, certification, or authorization to change any audit outcome. I did not author or repair the reviewed proofs. No canonical audit, proof, or source file was changed.

**Diagnostic result:** I found no material mathematical omission, non-source strengthening of assumptions, or source-to-implementation mismatch in the two complete numbered propositions after opening their actual definitions and proof bodies. There is a presentation obligation: the short `PaperInterface.lean` alone hides material definitions. A subsequent source-facing review must display their complete Lean-expanded semantics, with explicit source routes for retained prerequisite names. This can be achieved with the existing prerequisite-card architecture; it does not require a large manual inlining refactor or a new proof campaign.

## Inputs and limits

I read canonical `.audit_source/paper.tex` in full, lines 1–241; `work/final/source-intake-report.md` in full; and all six actual paper `.lean` files: `Assumptions`, `MainTheorems`, `Equilibrium`, `ThreeType`, `PaperInterface`, and `ProofInterface`. I also read `skills/econcs-formalizer/SKILL.md`, its complete `references/formalization-architecture.md`, `skills/econcs-prover/SKILL.md`, and `docs/ARCHITECTURE.md`.

Source references below are line spans in `work/final/AppliedModelingLib/papers/Vasquez26HeterogeneousVerification/.audit_source/paper.tex`. Lean references are line spans in the corresponding `.lean` files in that paper folder. They identify the actual inspected bodies, not a match inferred from identifiers.

I independently compared the canonical source bytes to `git show 3fb4aab:paper/paper.tex` in `outputs/ai-project`: equal, SHA-256 `c85ea6817bd1b6ff228ee1156c5dc96fd9a008c0f4858abe36b8f0f4235820b2`. All six actual `.lean` files equal `git show fd89b2a:lean/<filename>` in that project. The local AML base HEAD is different and does not contain that project commit; it was not substituted for the supplied public proof pin.

I did not consult author conversations, prior model verdicts, paper README/status files, old review artifacts, or `formalization-status.tex`. The source's input directive at line 227 was read as part of `paper.tex`, without expanding its status payload. Figures, SciPy/SymPy outputs, CSVs, external literature, publication claims, and numerical convergence assertions were not verified. No repository-wide build, external-model call, publication, or message to another chat was performed.

## Source roles and prerequisite boundaries

There are **two result Specs**, corresponding to the two numbered propositions. The four numbered assumptions and the defining equations have prerequisite roles. They must not become self-equality theorems or additional proof-credit rows. The intake's named-floor inventory preserves their source occurrence; its inventory vocabulary does not change their semantic role.

| Source item and span | Role | Actual implementation and diagnostic interpretation |
|---|---|---|
| Assumption 1, 35–37; activity description, 55 | Technology/information prerequisite | `Economy`, `Allocation`, `Prices` (`Equilibrium:7–35`), `bM`, `bH` (37–38), resources and activity inequalities (45–82). Three types are observable indexed real quantities. The only human pairs are LM, LH, MH, and `0<m<H<1` makes their solvers strictly more knowledgeable. Unit problem generation and two levels are encoded by output coefficients and time charges. No strategic information choice is added. |
| Assumption 2, 38–40 | AI/cost prerequisite | `profit` (`MainTheorems:10–12`), `qL/qM/qH` (`Equilibrium:39–41`), eligibility and no-profit clauses (52–76). Validation reduces goods output through q; it does not enter human-time resources or success coefficients. `k≥0` and the type bounds ensure nonnegative linear costs on the three types. |
| Assumption 3, 41–43 | Compute/endowment prerequisite | `compute`, `Feasible`, `NoProfit`, `Equilibrium` (`Equilibrium:49–82`); `compute_le_h` (155–173) and `equilibrium_rental_zero` (176–181). Rent is a price variable, with nonnegativity and market complementarity, not fixed by the equilibrium definition. |
| Assumption 4, 50–53 | Finite-population prerequisite | `Economy` (`Equilibrium:26–35`), `ThreeTypeRegime` (`ThreeType:6–24`), and explicit primitive binders (`PaperInterface:26–32`). Positive divisible masses, total mass one, `m<a`, and inherited technology restrictions are present. The continuous-density restriction is expressly replaced by the source's finite specialization. |
| n(z), profit and eligible domain, 44–47 | Local firm-model prerequisite | `span` and `profit` (`MainTheorems:10–12`), with interior `0<z<a<1` in `PropositionOneSpec` (`PaperInterface:8–12`). `span=1/[h(1-z)]` and rent is per AI unit. |
| q and initial comparison, 48 | Net-offer definition; ancillary initial-price comparison | q appears in the actual offer definitions. No Δ⁰ declaration is used by either numbered result; it is not a test for final adoption. Do not manufacture a theorem row for this comparison or substitute it for equilibrium. |
| bM, vL, vM, qL, qM, conditional qH, 89–94 | Derived quantities | `Equilibrium:37–43`. qH is defined algebraically for every input, but its economic AI constraint is conditional on eligibility. This harmless total definition does not create an ineligible activity. |
| Resources and equilibrium, 55; 206–220 | Finite model/certificate prerequisites governing Proposition 2 | `Allocation.Nonnegative`, `Feasible`, `NoProfit`, `Complementary`, `Equilibrium`, `output`, `wageBill`, `gap` (`Equilibrium:45–94`). The source finite LP equations specialize exactly to the three type equations. Weighted-sum duality is proved, rather than supplied as an assumed optimality certificate (97–152, 184–199). |
| Proposed allocations/prices, 103–107, 120, 126, 134–135 | Source construction used by the result | Full records in `candidateAllocation` and `candidatePrices` (`ThreeType:26–33`). Their quantities are stated explicitly below; they cannot be reviewed only by their names. |
| Proposition 1, 58–64 | Result | One transparent `PropositionOneSpec` (`PaperInterface:7–21`) and separate `proposition_one` endpoint (`ProofInterface:4–13`). |
| Proposition 2, 96–111 | Result | One transparent `PropositionTwoSpec` (`PaperInterface:25–41`) and separate `proposition_two` endpoint (`ProofInterface:15–22`). |

The general finite-program prose at 206–220 is used here as the governing specialization of equilibrium and output, not as a claim that a generic N-type LP solver was formalized. Likewise, the continuous compute inequality at 42 is instantiated and derived in the three-type allocation model; the files do not construct a separate measure-theoretic continuous equilibrium.

## Proposition 1: complete clause comparison

| Source clause | Actual Lean content | Diagnostic observation |
|---|---|---|
| `0<z<a<1`, local maximization and differentiability, 59 | `PaperInterface:8–11`; `foc_of_local_max`, `MainTheorems:21–33` | The first Spec conjunct retains interiority. `HasDerivAt` at z suffices, whereas the paper assumes differentiability in a neighborhood. This generalizes a valid calculus lemma; it does not add a non-source hypothesis. |
| FOC `(w′+c′)=(a-w-c)/(1-z)`, 60–62 | `PaperInterface:12`; actual derivative/Fermat proof `MainTheorems:14–33` | The profit is the source expression, including the reciprocal scale and constant rental. Positive denominators are derived from `h>0,z<1`. |
| Additional zero profit gives quotient `hr`, 63, 75–80 | `PaperInterface:13–16`; `rental_foc`, `MainTheorems:49–59`; `ProofInterface:8–11` | Both the quotient identity and `w′+c′=hr` are conclusions, not a hidden supplied equality. |
| With r=0, `w=a-c`, 63, 80, 82 | `PaperInterface:17–18`; `wage_of_zero_profit`, `MainTheorems:35–42` | The level follows directly from zero profit and nonzero scale; no local optimality assumption is needed for this conjunct. |
| Used open interval and linear cost imply slope κ, 63, 80–82 | `PaperInterface:19–21`; `active_neighborhood_slope`, `MainTheorems:68–73`, calling 61–64 | The premise is **eventual zero profit throughout a neighborhood**, not an equality at a single point. The proof derives the local wage identity with `wage_of_zero_profit`, then differentiates it. This preserves the paper's explicit level-versus-slope distinction. |

The source firm optimizes over `[0,a]` (46), while the Spec uses an ordinary `IsLocalMax` (11). At the stated `0<z<a`, these local notions agree: an isolated Lean probe converted `IsLocalMaxOn f (Set.Icc 0 a) z` to `IsLocalMax f z` with `Icc_mem_nhds`. This is not a material strengthening.

The source term “used” carries the free-entry zero-profit law. The Spec exposes its operative local consequence as neighborhood zero profit. An isolated probe also derived that premise from zero profit on any open set containing z and obtained the slope. A subsequent source-facing card should keep the free-entry/used-activity context visible rather than describe the eventual equality as an arbitrary caller-supplied wage certificate. There is no implemented continuous occupation-set object; one should not claim one.

Some valid local lemmas and later Spec conjuncts omit unused economic restrictions (`h<1`, nonnegative c or κ, nonnegative r, and interiority where only `z<1` is needed). They prove broader algebraic facts. No source parameter range is excluded. If exact restricted source presentation is desired, specialization is a presentation bridge, not a mathematical repair. The original source endpoint remains unchanged.

## Proposition 2: primitives, equilibrium and all nine activities

`PaperInterface:27–32` exposes every regime primitive: `0<h<1`, `0<m<H<1`, `m<a<1`, `κ≥0`, three positive masses summing to one, `μ>h`, expert surplus, `vM>m`, `qL<vL`, `qM>vM`, and the conditional expert offer restriction. `a>0`, `H>0`, `μ>0`, and positive assistance coefficients follow from these binders. `ThreeTypeRegime` contains those same assumptions (`ThreeType:6–24`); its constructor is made from the visible premises in `ProofInterface:16–19`. It contains no assumed equilibrium, adoption support, optimizer, uniqueness result, or gain formula.

The nine allocation coordinates are real divisible masses. The resource equations (`Equilibrium:54–56`) are exactly

```
dL+xL+yLM+yLH                 = alpha
dM+xM+h*yLM+yMH               = beta
dH+xH+h*yLH+h*(1-m)*yMH       = gamma
```

Thus an LM worker uses one L worker and h units of M solver time; LH uses one L and h units of H; MH uses one M and `bM=h(1-m)` units of H. Validation consumes goods via q, with no extra human-time charge. Compute is `h*xL+bM*xM+bH*xH` (49), with `bH=h(1-H)`. These equations permit a type's divisible mass to occupy several roles, as required by source 53.

The following table opens every activity's net output and dual slack. Each receives a nonnegative mass (45–47), a no-profit inequality when technologically available (61–66), and a mass-times-slack zero equation (69–76). Under nonnegative masses and slack, the latter is equality of profit when mass is strictly positive.

| Activity | Net output/unit | Dual slack | Baseline candidate mass | Validation candidate mass |
|---|---:|---|---:|---:|
| L independent | 0 | wL | 0 | 0 |
| M independent | m | wM−m | 0 | 0 |
| H independent | H | wH−H | γ−hα−bMβ | γ−hα |
| L with AI | qL | wL+hr−qL | 0; AI unavailable | 0 |
| M with AI | qM | wM+bMr−qM | 0; AI unavailable | β |
| H with AI | qH | wH+bHr−qH | 0; AI unavailable | 0; eligible constraint only if H≤a |
| LM | m | wL+h wM−m | 0 | 0 |
| LH | H | wL+h wH−H | α | α |
| MH | H | wM+bM wH−H | β | 0 |

All no-profit inequalities are per worker. Because `b_i>0`, `q_i≤w_i+b_i r` is equivalent to the AI-unit condition `n_i(q_i-w_i)−r≤0`. Likewise positive worker mass is equivalent to positive activity use after scaling by positive b. Human-pair output is the solver's type; there are no reversed, same-type, third-level or autonomous-AI activities in the source model.

At candidate baseline prices `(vL,vM,H,0)`, strict unused slacks are vL, vM−m, and `vL+h*vM−m`; used H-independent, LH and MH slacks vanish. At validation prices `(vL,qM,H,0)`, unused slacks are vL, qM−m, vL−qL, H−qH when H is eligible, `vL+h*qM−m`, and qM−vM; used H-independent, LH and M-AI slacks vanish. These inequalities are derived in `regime_facts` (`ThreeType:35–54`) and used by `candidate_noProfit` (86–95), not merely stated in an illustrative certificate.

### Eligibility and baseline branch probes

`Feasible:57` forces `xL=xM=xH=0` when `ai=false`. `NoProfit:63–64` places the AI inequalities behind `ai=true`; they disappear entirely in the baseline. The unguarded AI product equations in `Complementary` are harmless because those masses are zero. An isolated Lean probe checked the reduced baseline definition, without any constraint on the unused q values.

For `H>a`, `Feasible:58` forces xH=0 and `NoProfit:64` does not require an H-AI inequality. `nonnegative_products:123–128` explicitly splits eligibility and uses that zero-mass branch. `validation_allocation_unique`, `ThreeType:148–151`, likewise handles both cases. Isolated probes checked the actual off-eligibility mass rule and the full reduced no-profit predicate.

There is a useful redundancy in the full regime: its strict low/middle offers already force **H<a**. Indeed

```
qM = m*a+(1-m)*qL
vM = m*H+(1-m)*vL.
```

Since `0<m<1`, qL<vL and qM>vM imply `m*(a-H)>0`. A Lean probe derived H<a from `ThreeTypeRegime`. Therefore a full-regime `H>a` numerical witness cannot exist. This is a mathematical property of the source assumptions, not vacuity of the whole proposition and not an implementation omission. The conditional H-AI clause should remain source-faithful; no change is necessary. The source's rational example, with μ=1, was separately instantiated as a full regime and as both full equilibria in the temporary overlay, demonstrating a nonempty regime without relying on `MiddleCertificate`.

`Feasible`/`NoProfit` only test H's eligibility because their intended owner is the three-type regime where `0<m<a` already guarantees L/M eligibility. These predicates should not be presented as a generic finite-economy model for arbitrary `Economy` values lacking `m<a`. If future work reuses them outside this domain, the smallest extension is to guard every AI type or attach the domain invariant at that new boundary. This is not needed for Proposition 2.

## Proposition 2: complete conclusion and proof route

| Source clause | Actual Lean target and body | Diagnostic observation |
|---|---|---|
| Baseline existence, complete assignment and wages, 103; 120–124 | First conclusion conjunct `PaperInterface:33–35`; full candidate records `ThreeType:26–33`; feasibility/no-profit/complementarity and construction 56–105 | The exact candidate has `yLH=α,yMH=β,dH=γ−hα−bMβ`, all other masses zero, wages `(vL,vM,H)`, rent zero. This is a constructed competitive equilibrium, not a certificate supplied as a premise. |
| Baseline allocation uniqueness, 103, 130 | `baseline_allocation_unique`, `ThreeType:108–128` | Quantifies over every x,p satisfying the full baseline equilibrium. Cross-gap comparison excludes L/M independents and LM; baseline feasibility excludes every AI quantity; resources determine all remaining masses. |
| Baseline wage uniqueness, 103, 130 | `equilibrium_unique`, `ThreeType:161–182` | Positive independent-H, LH and MH quantities fix wH, wL, wM. Rent is also uniquely zero. Allocation uniqueness alone is not substituted for wage uniqueness. |
| Validation existence and prices, 103–106; 126–128 | Second conclusion conjunct `PaperInterface:36–38`; `ThreeType:26–33,56–105` | Candidate has `(wL,wM,wH)=(vL,qM,H)`, with full resources and every permissible deviation checked. |
| Only M adopts; all listed masses and all others zero, 107 | Complete candidate allocation, `ThreeType:26–30`; `validation_allocation_unique`, 132–158 | `xM=β,xL=xH=0,yLH=α,dH=γ−hα`, and `dL=dM=yLM=yMH=0`. These are conclusions. Arbitrary equilibria are not assumed to have that support. |
| Validation allocation uniqueness, 103, 130 | `ThreeType:132–158` | Strict candidate slacks exclude all other activities, including eligible H-AI; the ineligible branch uses its feasibility restriction. Resources determine the surviving masses. |
| Validation wage uniqueness, 103, 130 | `ThreeType:161–175,183–191` | Positive H independent mass gives wH=H, positive LH gives wL=vL, and positive M-AI plus derived r=0 gives wM=qM. Prices include r and are compared by full record equality. |
| Compute constraint, slackness and rental derivation, 42, 124, 126, 214 | `Equilibrium:49,58,62,80–82,155–181` | Compute≤h follows from nonnegative resource use and total mass one. μ>h makes the compute slack strictly positive, so `r*(μ−compute)=0` forces r=0 for **any** equilibrium. Setting the candidate price r=0 alone is not the uniqueness argument. |
| Net output difference and strict positivity, 107–109; 132–137 | `output`, `Equilibrium:84–86`; `candidate_output_gain`, `ThreeType:193–197`; positivity 199–202; `PaperInterface:39–41` | Output uses q for AI, so it is net of real validation spending. Baseline AI terms vanish. The difference is exactly β(qM−vM), strictly positive by β>0 and qM>vM. Full equilibrium uniqueness ties this candidate difference to the economy's equilibria. |

The weighted-sum proof is genuine. `gap_identity` (`Equilibrium:97–103`) derives the resource accounting identity; nonnegativity and zero-gap/complementarity are proved in 105–152. `equilibrium_cross_gap` (184–199) uses both full equilibria's no-profit bounds and attained wage bills with zero rents. Its input “other equilibrium” is the object universally quantified for uniqueness, not an assumed optimizer or uniqueness certificate. Candidate existence is independently constructed first. This realizes the source's two-sided comparison at line 130 without assuming an optimum beforehand.

`MiddleCertificate`, `middle_certificate`, and `exact_three_type_certificate` (`MainTheorems:75–114,128–130`) are limited candidate algebra/illustration facts. They do not define equilibrium, include every market condition, or prove the two uniqueness claims. They are not used as replacements for Proposition 2 by `ProofInterface:15–22`; the endpoint calls the actual equilibrium and uniqueness results. They must not acquire a second named-source-result row.

## Smallest presentation repairs and unchanged result

1. In the subsequent source-facing material, keep exactly two result Specs and their separate exact-type endpoints. Route the four assumptions and material definitions to actual prerequisite declarations; do not issue fake theorem rows for them.
2. `PaperInterface:11,15,18,21` retains `profit`; `PaperInterface:26–41` retains the economy carrier, coefficient functions, `Equilibrium`, candidate records, and `output`. Show their complete bodies before/during the comparison. Retained names may use independently source-routed prerequisite cards; non-routed implementation definitions should be Lean-reduced into the containing target. Show structure fields/constructors, not only `Type` signatures. In particular, show the full candidate quantities and all resource/no-profit/complementarity clauses rather than asking a reviewer to infer them from names.
3. Preserve the source interpretation behind Proposition 1's neighborhood-zero-profit premise, including source 63, 75–82 and the free-entry model context. A source-facing explanatory specialization may state the constrained-domain and open-used-set bridges already tested here. No change to the actual calculus or equilibrium proofs is indicated.
4. Keep the three-type scope visible wherever the finite predicates are displayed. Do not advertise them as an unrestricted N-type or continuous equilibrium formalization.

These are presentation/routing disciplines, not mathematical corrections to the two source propositions. I found no non-source condition requiring an author decision and no proof repair to recommend. General continuous existence, uniqueness, adoption ordering for all distributions or all κ>0, convergence of grids, and the cited baseline paper's Proposition 6 remain outside this result. The source explicitly says so at 53, 116, 184, 193 and 200. Their absence does not weaken the unchanged finite theorem or the local derivative result.

## Lean diagnostic execution

All compiler probes were confined to one directory outside AML: `/private/tmp/vasquez26-precert.0f1rtu/`. `Diagnostic.lean` imports the already built `ProofInterface`; `Diagnostic.out` contains the `#print` displays and axiom diagnostics. The final command was:

```
LEAN_NUM_THREADS=1 /Users/belenvasquez/.elan/bin/lake env lean \
  /private/tmp/vasquez26-precert.0f1rtu/Diagnostic.lean
```

The final diagnostic run exited 0, with no warnings, errors, panic or internal-error output. It printed the full Spec bodies, structures with constructors, equilibrium predicates, objective, candidate records and endpoint proof terms. Both endpoint axiom reports listed only `propext`, `Classical.choice`, and `Quot.sound`; no `sorryAx` or paper-specific axiom appeared. The probes also checked the constrained-local-max bridge, the open-set zero-profit slope bridge, H<a under the regime, off-eligibility H-AI exclusion, both reduced no-profit branches, and the rational full-regime/full-equilibrium instances.

Early temporary runs encountered only overlay setup issues (a noncomputable real-valued definition and an unsupported pretty-print option); those were corrected solely in the temporary file before the successful final run. Original modules and build artifacts were not rebuilt or edited. This is diagnostic compiler information, not a canonical graph, receipt, semantic judgment ledger, or new formal evidence artifact.
