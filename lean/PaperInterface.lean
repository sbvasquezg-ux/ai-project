import Vasquez26HeterogeneousVerification.ThreeType
/-! Interfaz semántica de las dos proposiciones del manuscrito.
El resultado global corresponde a la especialización finita de tres tipos. -/
noncomputable section
namespace Vasquez26HeterogeneousVerification

def PropositionOneSpec : Prop :=
  (∀ (h a r z wp cp : ℝ) (w c : ℝ → ℝ),
    0 < h → 0 < z → z < a → a < 1 →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ w t) →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ c t) →
    (∀ t ∈ Set.Icc (0 : ℝ) 1, 0 ≤ c t) →
    HasDerivAt w wp z → HasDerivAt c cp z →
    IsLocalMax (profit h a r w c) z →
    wp+cp = (a-w z-c z)/(1-z)) ∧
  (∀ (h a r z wp cp : ℝ) (w c : ℝ → ℝ),
    0 < h → 0 < z → z < a → a < 1 →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ w t) →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ c t) →
    (∀ t ∈ Set.Icc (0 : ℝ) 1, 0 ≤ c t) →
    HasDerivAt w wp z → HasDerivAt c cp z →
    IsLocalMax (profit h a r w c) z → profit h a r w c z = 0 →
    (a-w z-c z)/(1-z) = h*r ∧ wp+cp = h*r) ∧
  (∀ (h a z : ℝ) (w c : ℝ → ℝ),
    0 < h → 0 < z → z < a → a < 1 →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ w t) →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ c t) →
    (∀ t ∈ Set.Icc (0 : ℝ) 1, 0 ≤ c t) →
    profit h a 0 w c z = 0 → w z = a-c z) ∧
  (∀ (h a k z wp : ℝ) (w : ℝ → ℝ),
    0 < h → 0 < z → z < a → a < 1 → 0 ≤ k →
    (∀ᶠ t in nhds z, DifferentiableAt ℝ w t) → HasDerivAt w wp z →
    (∀ᶠ t in nhds z, profit h a 0 w (fun s => k*(1-s)) t = 0) → wp = k)

/-- Proposition 2, with every primitive assumption visible and existence,
allocation and wage uniqueness in both economies, and the strict net gain. -/
def PropositionTwoSpec : Prop :=
  ∀ e : Economy,
    0 < e.h → e.h < 1 → 0 < e.m → e.m < e.H → e.H < 1 →
    0 < e.a → e.m < e.a → e.a < 1 → 0 ≤ e.k →
    0 < e.alpha → 0 < e.beta → 0 < e.gamma →
    e.alpha+e.beta+e.gamma = 1 → e.h < e.mu →
    e.h*e.alpha+bM e*e.beta < e.gamma → e.m < vM e →
    qL e < vL e → vM e < qM e → (e.H ≤ e.a → qH e < e.H) →
    (Equilibrium e false (candidateAllocation e false) (candidatePrices e false) ∧
      ∀ (x : Allocation) (p : Prices), Equilibrium e false x p →
        x = candidateAllocation e false ∧ p = candidatePrices e false) ∧
    (Equilibrium e true (candidateAllocation e true) (candidatePrices e true) ∧
      ∀ (x : Allocation) (p : Prices), Equilibrium e true x p →
        x = candidateAllocation e true ∧ p = candidatePrices e true) ∧
    output e (candidateAllocation e true)-output e (candidateAllocation e false) =
      e.beta*(qM e-vM e) ∧
    0 < output e (candidateAllocation e true)-output e (candidateAllocation e false)

end Vasquez26HeterogeneousVerification
