# Final bounded Lean diagnostic

**Diagnostic verdict:** No material source-to-Lean mismatch, missing clause of either numbered proposition, or new non-source premise was found in the stopped Sol surface. The final source-facing restrictions specialize previously more general valid lemmas to the paper's stated domain. Full competitive equilibrium existence, allocation uniqueness, wage uniqueness, and the strict net gain remain proved. No proof repair is indicated by this screen.

This is a diagnostic comparison, not a formal semantic receipt, audit-graph judgment, or claim of institutional or human approval. I did not author or modify these proofs.

## Exact scope checked

I compared all six `.lean` files in `work/final/sol-public-aml/papers/Vasquez26HeterogeneousVerification/` against the previously reviewed `fd89b2a` bytes in `work/final/AppliedModelingLib/papers/Vasquez26HeterogeneousVerification/`. I inspected the complete file differences and reread the final source Specs, proof endpoints, equilibrium model, candidate construction and uniqueness bodies. `Assumptions.lean` is unchanged; the other five files have the bounded changes below. The canonical `.audit_source/paper.tex` bytes in the two paper folders are identical; the original source review read all 241 lines and verified the public `3fb4aab` paper pin.

All source line references below are to that unchanged `paper.tex`; code line references are to the **Sol folder**. The earlier detailed activity and source-role screen is `work/final/precert-review.md`. This follow-up concerns theorem truth/correspondence and the final delta, not audit metadata or a continuous-theory extension.

## Delta and source correspondence

| Actual change | Source | Final code | Diagnostic consequence |
|---|---|---|---|
| Introduces `assistanceTime=h(1-z)`, `validationCost=κ(1-z)`, `netOffer=a-validationCost` | 36, 39, 44, 48, 91–94 | `MainTheorems:10–15`; `Equilibrium:37–43` | Same mathematical functions as before. bM, bH, qL, qM, qH and span now call these transparent definitions. No time charge, output coefficient or cost term changes. |
| Adds neighborhood differentiability of w and c to the first three local clauses | 59: differentiable in a neighborhood of z | `PaperInterface:10–11,18–19,26–27` | Explicit source condition. `∀ᶠ t in nhds z, DifferentiableAt ℝ f t` expresses a neighborhood on which f is differentiable. Point derivative binders identify the derivatives appearing in the formulas. |
| Adds nonnegative c on `[0,1]` | 36: type domain `[0,1]`; 39: `c(z)≥0` | `PaperInterface:12,20,28` | Source restriction, not an added economic assumption. The calculus proof does not need it, but the paper does state it. |
| Restores `0<z<a<1` to the subsequent level/rental clauses; adds interiority, κ≥0 and neighborhood differentiability to the slope clause | 39 and the common opening domain/differentiability assumptions at 59; 63 | `PaperInterface:17,25,31–33` | Preserves the complete source proposition in its stated domain. It restricts earlier algebraic generalizations without excluding a case claimed by the paper. |
| Adds explicit `a>0` to the finite regime | 39: `a∈(0,1)`; 51: `m<a` and `m>0` | `PaperInterface:40`; `ThreeType:12`; constructor at `ProofInterface:19–22` | Already implied by `0<m<a`; no non-source strengthening or loss of parameter range. |
| Updates unfolding steps and tactic layout | Same formulas as above | `MainTheorems:22–26,38,54–55,65`; `Equilibrium:171`; `ThreeType:45–48,74–79` | Proof engineering only. Candidate quantities, equilibrium predicates, gap argument, uniqueness conclusions and gain formula do not change. |

The actual final files **do not generalize eligibility guards to all types**, despite that being mentioned in the handoff. `Feasible` still explicitly tests only H's eligibility, and `NoProfit` still guards only H's AI inequality (`Equilibrium:52–66`). This is correct for the numbered finite theorem because `0<a` and `m<a` make L and M eligible. The predicates should continue to be described as the three-type model in that domain, not as a general arbitrary-type eligibility model. This discrepancy in the handoff description is not a theorem blocker.

## Complete numbered-result coverage

| Source clause | Final implementation inspected | Diagnostic finding |
|---|---|---|
| Proposition 1: FOC, 59–62 | `PaperInterface:8–15`; `MainTheorems:17–40`; `ProofInterface:6–7` | Exact profit and reciprocal scale; actual derivative and Fermat proof. The source's constrained local maximum on `[0,a]` agrees with the implemented ordinary local maximum at the stated interior point; that bridge was checked in the original diagnostic overlay. |
| Zero-profit quotient equals hr and derivative sum equals hr, 63, 75–80 | `PaperInterface:16–23`; `MainTheorems:57–67`; `ProofInterface:8–12` | Both identities remain conclusions derived from zero profit and the FOC. |
| With r=0, wage level `w=a-c`, 63, 80–82 | `PaperInterface:24–29`; `MainTheorems:42–49`; `ProofInterface:13–14` | Level is derived from zero profit; no local-optimality or wage-identity certificate replaces the proof. |
| Used open interval and linear cost imply slope κ, 63, 80–82 | `PaperInterface:30–33`; `MainTheorems:69–81`; `ProofInterface:15–16` | Still requires **zero profit throughout a neighborhood**, derives the local wage identity and differentiates it. It does not infer a derivative from a one-point equality. Source free entry supplies the zero-profit meaning of “used.” |
| Proposition 2: every primitive and strict regime inequality, 35–43, 50–53, 97–101 | `PaperInterface:38–44`; `ThreeType:6–25` | Types, ordered knowledge, positive divisible masses summing to one, h and a bounds, κ≥0, μ>h, expert surplus, outside option, low/middle offers and conditional high offer all remain visible. |
| Baseline existence, assignments and wages, 103, 120–124 | `PaperInterface:45–47`; `ThreeType:27–34,59–111` | Constructs `yLH=α,yMH=β,dH=γ−hα−bMβ`, all other masses zero, prices `(vL,vM,H,0)`, and proves full equilibrium. |
| Validation existence, assignments and wages, 103–107, 126–128 | `PaperInterface:48–50`; `ThreeType:27–34,59–111` | Constructs `xM=β,yLH=α,dH=γ−hα`, all other masses zero, prices `(vL,qM,H,0)`, and proves full equilibrium. Adoption support is a conclusion. |
| All activities, resources, free entry and used-activity zero profit, 36, 39, 55, 206–220 | `Equilibrium:7–24,45–86`; candidate checks `ThreeType:59–111` | All nine activities remain: dL,dM,dH,xL,xM,xH,yLM,yLH,yMH. All are nonnegative; the three human resources count worker mass and solver time; all available activities receive no-profit constraints; all used activities receive mass-times-slack complementarity. Goods validation cost enters q, not time resources. |
| Compute constraint and rental derivation, 42, 124, 126, 214 | `Equilibrium:49,58,62,80–82,155–181` | Compute bound ≤h is derived from resources and total mass. With μ>h, compute complementarity forces **any equilibrium's** rent to zero. Rent is not assumed zero in the equilibrium definition. |
| Baseline allocation uniqueness, 103, 130 | `ThreeType:114–134` | Universal over arbitrary full baseline equilibria. All AI quantities vanish by the baseline switch; strict slacks exclude other unused activities; resources determine the remaining masses. |
| Validation allocation uniqueness, 103, 130 | `ThreeType:138–164` | Universal over arbitrary full validation equilibria. Strict slacks exclude all other activities; H-AI has both eligibility branches; resources determine all surviving masses. |
| Both economies' wage uniqueness, 103, 130 | `ThreeType:167–197`; full `Prices` equality in `PaperInterface:47,50` | Positive independent H, LH and either MH or M-AI pin all three wages. Rent is separately derived zero. This is not only allocation uniqueness. |
| Net gain identity and positivity, 107–109, 132–137 | `PaperInterface:51–53`; `Equilibrium:84–86`; `ThreeType:199–208` | Exact net output difference β(qM−vM), positive under β>0 and qM>vM. Full uniqueness relates the candidate quantities to every equilibrium. |

The weighted-sum proof remains the original actual proof: `gap_identity` (`Equilibrium:97–103`), nonnegative/zero-gap lemmas (105–152), and the two-equilibrium cross-gap argument (184–199). These derive the comparison used for uniqueness. No assumed optimizer, adoption certificate or theorem-shaped record field is substituted. `MiddleCertificate` and its rational illustration remain auxiliary algebraic results and are not the Proposition 2 equilibrium proof (`ProofInterface:18–25`).

The baseline `ai=false` branch removes all three AI masses and all AI no-profit requirements (`Equilibrium:57,63–64`). For H>a, xH=0 is a technology restriction (58) and H-AI is omitted from no-profit constraints (64); both nonnegativity and validation uniqueness explicitly use that branch (123–128; `ThreeType:154–157`). The prior diagnostic also established that the full strict-offer regime itself forces H<a, so an H>a witness to all of Proposition 2's assumptions cannot exist. No general-eligibility change is needed to prove the paper's result.

The four source assumptions and the technology, cost, firm and equilibrium definitions remain semantic prerequisites, not extra theorem rows. There are exactly two source result Specs, with separately typed theorem endpoints. No continuous existence/uniqueness or grid convergence theorem was silently added or required; the source expressly leaves those open (53, 116, 184, 193, 200).

## Independent endpoint check

I ran exactly one forced Lean source check in the stopped public Sol clone, with no repository-wide build:

```
LEAN_NUM_THREADS=1 /Users/belenvasquez/.elan/bin/lake env lean \
  papers/Vasquez26HeterogeneousVerification/ProofInterface.lean
```

It exited **0**, with no warnings, errors, panic or internal-error diagnostics. It checked both final source-typed endpoint proofs against the imported final modules. Each endpoint's printed axiom closure was only `[propext, Classical.choice, Quot.sound]`; no `sorryAx` or paper-specific axiom appeared. The imported MainTheorems, Equilibrium, ThreeType and PaperInterface `.olean` modification times are later than their respective final source files. I did not rely on the supplied build-log claim; the named `.review_traces/source-route-refactor-build.log` path was absent in this clone.

Final file identities (SHA-256):

| File | SHA-256 |
|---|---|
| Assumptions.lean | `07665e64be1e86d81306dabef2f720b17a97ee67a28c89e6ac1299abb1f84e7c` |
| Equilibrium.lean | `04db3afeb44d0515066c345ad73c06f74f7d2ad29352d43eec9a6b538f4992fa` |
| MainTheorems.lean | `86b82c9e5ad326c6a49efddc64efde7820641958f84735eac22a61b42d6eda8b` |
| PaperInterface.lean | `e94637f22040240b2d1ebe0e5106a1d9fa27aeaa4dd41167d7167697a4a29f00` |
| ProofInterface.lean | `b5783e5f6973ba631a9e2eb96cf7ab197c66f1705047e9362e35370ceff12e1f` |
| ThreeType.lean | `23aec8bd8ac0d927f026c63425e498356f15b2b93868de6e43486e2b385c3de5` |

No source or proof edit was made. This screen neither runs nor substitutes for the course's separate `--fast` check, and it makes no claim about a canonical AML receipt or audit graph.
