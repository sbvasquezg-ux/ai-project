import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.LocalExtr.Basic
import Mathlib.Tactic

/-! Proposición 1 y certificado general de la Proposición 2.
La unicidad global de la Proposición 2 queda fuera de la cobertura Lean. -/
noncomputable section
namespace Vasquez26HeterogeneousVerification

def span (h z : ℝ) : ℝ := 1 / (h * (1-z))
def profit (h a r : ℝ) (w c : ℝ → ℝ) (z : ℝ) : ℝ :=
  span h z * (a-w z-c z)-r

theorem span_derivative (h z : ℝ) (hh : 0 < h) (hz : z < 1) :
    HasDerivAt (span h) (1 / (h*(1-z)^2)) z := by
  have hden : h*(1-z) ≠ 0 := ne_of_gt (mul_pos hh (sub_pos.mpr hz))
  have hd := ((hasDerivAt_const z (1:ℝ)).div
    ((hasDerivAt_const z h).mul ((hasDerivAt_const z (1:ℝ)).sub (hasDerivAt_id z))) hden)
  convert hd using 1 <;> dsimp [span] <;> field_simp <;> ring

theorem foc_of_local_max (h a r z wp cp : ℝ) (w c : ℝ → ℝ)
    (hh : 0 < h) (hz : z < 1)
    (hw : HasDerivAt w wp z) (hc : HasDerivAt c cp z)
    (hm : IsLocalMax (profit h a r w c) z) :
    wp+cp = (a-w z-c z)/(1-z) := by
  have hd := ((span_derivative h z hh hz).mul
    (((hasDerivAt_const z a).sub hw).sub hc)).sub_const r
  have he := hm.hasDerivAt_eq_zero hd
  have hn : h ≠ 0 := ne_of_gt hh
  have hz0 : 1-z ≠ 0 := ne_of_gt (sub_pos.mpr hz)
  dsimp [span] at he
  field_simp at he ⊢
  nlinarith

theorem wage_of_zero_profit (h a z : ℝ) (w c : ℝ → ℝ)
    (hh : 0 < h) (hz : z < 1) (hp : profit h a 0 w c z = 0) :
    w z = a-c z := by
  have hn : span h z ≠ 0 := one_div_ne_zero (mul_ne_zero (ne_of_gt hh)
    (ne_of_gt (sub_pos.mpr hz)))
  dsimp [profit] at hp
  have hm : a-w z-c z = 0 := (mul_eq_zero.mp (by simpa using hp)).resolve_left hn
  linarith

theorem linear_offer_derivative (a k z : ℝ) :
    HasDerivAt (fun t : ℝ => a-k*(1-t)) k z := by
  convert (hasDerivAt_const z a).sub
    ((hasDerivAt_const z k).mul ((hasDerivAt_const z (1:ℝ)).sub (hasDerivAt_id z))) using 1 <;> ring

theorem rental_foc (h a r z wp cp : ℝ) (w c : ℝ → ℝ)
    (hh : 0 < h) (hz : z < 1)
    (hw : HasDerivAt w wp z) (hc : HasDerivAt c cp z)
    (hm : IsLocalMax (profit h a r w c) z)
    (hp : profit h a r w c z = 0) : wp+cp = h*r := by
  have hf := foc_of_local_max h a r z wp cp w c hh hz hw hc hm
  have hn : h ≠ 0 := ne_of_gt hh
  have hz0 : 1-z ≠ 0 := ne_of_gt (sub_pos.mpr hz)
  dsimp [profit, span] at hp
  field_simp at hp hf
  nlinarith

theorem active_interval_slope (a k z wp : ℝ) (w : ℝ → ℝ)
    (hw : HasDerivAt w wp z)
    (he : w =ᶠ[nhds z] (fun t : ℝ => a-k*(1-t))) : wp = k := by
  exact hw.unique ((linear_offer_derivative a k z).congr_of_eventuallyEq he)

/-- Candidate certificate: positive independent H, strict unused-activity slacks,
zero profit in LH, and all three resource identities. AI of M pays qM by definition. -/
def MiddleCertificate (h m H a k alpha beta gamma : ℝ) : Prop :=
  let vL := H*(1-h)
  let qL := a-k
  let qM := a-k*(1-m)
  let qH := a-k*(1-H)
  0 < gamma-h*alpha ∧
  vL > 0 ∧ qM > m ∧ vL > qL ∧ (H ≤ a → H > qH) ∧
  vL+h*qM > m ∧ qM+h*(1-m)*H > H ∧
  vL+h*H = H ∧
  (0:ℝ)+0+0+alpha = alpha ∧
  (0:ℝ)+beta+h*0+0 = beta ∧
  gamma-h*alpha+0+h*alpha+h*(1-m)*0 = gamma

theorem middle_certificate (h m H a k alpha beta gamma : ℝ)
    (hh : 0 < h) (hh1 : h < 1) (hm : 0 < m) (hmH : m < H) (hH : H < 1)
    (ha : 0 < alpha) (hb : 0 < beta)
    (hs : gamma > h*alpha+h*(1-m)*beta)
    (houtside : H*(1-h*(1-m)) > m)
    (hlo : a-k < H*(1-h))
    (hmid : a-k*(1-m) > H*(1-h*(1-m)))
    (hhi : H ≤ a → a-k*(1-H) < H) :
    MiddleCertificate h m H a k alpha beta gamma := by
  have hH0 : 0 < H := lt_trans hm hmH
  have hm1 : m < 1 := lt_trans hmH hH
  have hbpos : 0 < h*(1-m)*beta := mul_pos (mul_pos hh (sub_pos.mpr hm1)) hb
  have hLpos : 0 < H*(1-h) := mul_pos hH0 (sub_pos.mpr hh1)
  have hid : H*(1-h)+h*(H*(1-h*(1-m)))-m =
      (H*(1-h*(1-m))-m)+H*h*(1-h)*(1-m) := by ring
  have hextra : 0 < H*h*(1-h)*(1-m) :=
    mul_pos (mul_pos (mul_pos hH0 hh) (sub_pos.mpr hh1)) (sub_pos.mpr hm1)
  have hslack : H*(1-h)+h*(a-k*(1-m)) > m := by nlinarith
  dsimp [MiddleCertificate]
  refine ⟨by linarith, hLpos, by linarith, hlo, hhi, hslack, ?_, ?_, ?_, ?_, ?_⟩
  · nlinarith
  · ring
  · ring
  · ring
  · ring

theorem net_output_gain (h m H qM alpha beta gamma : ℝ) :
    (alpha*H+beta*qM+(gamma-h*alpha)*H) -
      ((alpha+beta)*H+(gamma-h*alpha-h*(1-m)*beta)*H) =
      beta*(qM-H*(1-h*(1-m))) := by ring

theorem net_output_gain_positive (h m H qM alpha beta gamma : ℝ)
    (hb : 0 < beta) (hq : H*(1-h*(1-m)) < qM) :
    0 < (alpha*H+beta*qM+(gamma-h*alpha)*H) -
      ((alpha+beta)*H+(gamma-h*alpha-h*(1-m)*beta)*H) := by
  rw [net_output_gain]
  exact mul_pos hb (sub_pos.mpr hq)

theorem exact_three_type_certificate :
    MiddleCertificate (1/2) (1/4) (19/25) (22/25) (53/100) (1/4) (2/5) (7/20) := by
  norm_num [MiddleCertificate]

end Vasquez26HeterogeneousVerification
