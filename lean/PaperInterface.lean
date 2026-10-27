import Vasquez26HeterogeneousVerification.MainTheorems
/-! Interfaz parcial del manuscrito propio. Esta especificación reúne las
cláusulas locales de la Proposición 1; no es una formalización del equilibrio
continuo ni de la unicidad de la Proposición 2. -/
noncomputable section
namespace Vasquez26HeterogeneousVerification

def PropositionOneSpec : Prop :=
  (∀ (h a r z wp cp : ℝ) (w c : ℝ → ℝ),
    0 < h → 0 < z → z < a → a < 1 →
    HasDerivAt w wp z → HasDerivAt c cp z →
    IsLocalMax (profit h a r w c) z →
    wp+cp = (a-w z-c z)/(1-z)) ∧
  (∀ (h a r z wp cp : ℝ) (w c : ℝ → ℝ),
    0 < h → z < 1 → HasDerivAt w wp z → HasDerivAt c cp z →
    IsLocalMax (profit h a r w c) z → profit h a r w c z = 0 → wp+cp = h*r) ∧
  (∀ (h a z : ℝ) (w c : ℝ → ℝ),
    0 < h → z < 1 → profit h a 0 w c z = 0 → w z = a-c z) ∧
  (∀ (a k z wp : ℝ) (w : ℝ → ℝ),
    HasDerivAt w wp z →
    w =ᶠ[nhds z] (fun t : ℝ => a-k*(1-t)) → wp = k)

end Vasquez26HeterogeneousVerification
