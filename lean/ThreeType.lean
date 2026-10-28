import Vasquez26HeterogeneousVerification.Equilibrium
noncomputable section
namespace Vasquez26HeterogeneousVerification

/-- The original finite primitives and strict inequalities of Proposition 2. -/
structure ThreeTypeRegime (e : Economy) : Prop where
  h_pos : 0 < e.h
  h_lt_one : e.h < 1
  m_pos : 0 < e.m
  m_lt_H : e.m < e.H
  H_lt_one : e.H < 1
  a_pos : 0 < e.a
  m_lt_a : e.m < e.a
  a_lt_one : e.a < 1
  k_nonneg : 0 ≤ e.k
  alpha_pos : 0 < e.alpha
  beta_pos : 0 < e.beta
  gamma_pos : 0 < e.gamma
  total_mass : e.alpha+e.beta+e.gamma = 1
  compute_abundant : e.h < e.mu
  expert_surplus : e.h*e.alpha+bM e*e.beta < e.gamma
  middle_outside : e.m < vM e
  low_offer : qL e < vL e
  middle_offer : vM e < qM e
  high_offer : e.H ≤ e.a → qH e < e.H

def candidateAllocation (e : Economy) (ai : Bool) : Allocation :=
  { dL := 0, dM := 0,
    dH := e.gamma-e.h*e.alpha-(if ai then 0 else bM e*e.beta),
    xL := 0, xM := if ai then e.beta else 0, xH := 0,
    yLM := 0, yLH := e.alpha, yMH := if ai then 0 else e.beta }

def candidatePrices (e : Economy) (ai : Bool) : Prices :=
  { wL := vL e, wM := if ai then qM e else vM e, wH := e.H, r := 0 }

theorem regime_facts (e : Economy) (hr : ThreeTypeRegime e) :
    0 < bM e ∧ 0 < vL e ∧ e.m < qM e ∧
    0 < vL e+e.h*vM e-e.m ∧ 0 < vL e+e.h*qM e-e.m ∧
    0 < e.gamma-e.h*e.alpha ∧ 0 < e.gamma-e.h*e.alpha-bM e*e.beta ∧
    vL e+e.h*e.H-e.H = 0 ∧ vM e+bM e*e.H-e.H = 0 := by
  have hH0 : 0 < e.H := lt_trans hr.m_pos hr.m_lt_H
  have hm1 : e.m < 1 := lt_trans hr.m_lt_H hr.H_lt_one
  have hb : 0 < bM e := mul_pos hr.h_pos (sub_pos.mpr hm1)
  have hvL : 0 < vL e := mul_pos hH0 (sub_pos.mpr hr.h_lt_one)
  have hid : vL e+e.h*vM e-e.m =
      (vM e-e.m)+e.H*e.h*(1-e.h)*(1-e.m) := by
    dsimp [vL,vM,bM,assistanceTime]
    ring
  have hprod : 0 < e.H*e.h*(1-e.h)*(1-e.m) :=
    mul_pos (mul_pos (mul_pos hH0 hr.h_pos) (sub_pos.mpr hr.h_lt_one)) (sub_pos.mpr hm1)
  have hLM : 0 < vL e+e.h*vM e-e.m := by rw [hid]; linarith [hr.middle_outside]
  have hLM' : 0 < vL e+e.h*qM e-e.m := by
    have := mul_pos hr.h_pos (sub_pos.mpr hr.middle_offer)
    nlinarith
  have hmass := mul_pos hb hr.beta_pos
  refine ⟨hb,hvL,lt_trans hr.middle_outside hr.middle_offer,hLM,hLM',by linarith [hr.expert_surplus],
    by linarith [hr.expert_surplus],?_,?_⟩ <;> dsimp [vL,vM] <;> ring

theorem candidate_feasible (e : Economy) (ai : Bool) (hr : ThreeTypeRegime e) :
    Feasible e ai (candidateAllocation e ai) := by
  have hf := regime_facts e hr
  have hn : (candidateAllocation e ai).Nonnegative := by
    cases ai <;> dsimp [candidateAllocation, Allocation.Nonnegative]
    · exact ⟨le_refl _,le_refl _,le_of_lt hf.2.2.2.2.2.2.1,le_refl _,le_refl _,
        le_refl _,le_refl _,le_of_lt hr.alpha_pos,le_of_lt hr.beta_pos⟩
    · exact ⟨le_refl _,le_refl _,by linarith [hf.2.2.2.2.2.1],le_refl _,le_of_lt hr.beta_pos,
        le_refl _,le_refl _,le_of_lt hr.alpha_pos,le_refl _⟩
  have hresL : (candidateAllocation e ai).dL+(candidateAllocation e ai).xL+
      (candidateAllocation e ai).yLM+(candidateAllocation e ai).yLH = e.alpha := by
    simp [candidateAllocation]
  have hresM : (candidateAllocation e ai).dM+(candidateAllocation e ai).xM+
      e.h*(candidateAllocation e ai).yLM+(candidateAllocation e ai).yMH = e.beta := by
    cases ai <;> simp [candidateAllocation]
  have hresH : (candidateAllocation e ai).dH+(candidateAllocation e ai).xH+
      e.h*(candidateAllocation e ai).yLH+bM e*(candidateAllocation e ai).yMH = e.gamma := by
    cases ai
    · simp [candidateAllocation]
      ring
    · simp [candidateAllocation]
  have hno : ai = false → (candidateAllocation e ai).xL = 0 ∧
      (candidateAllocation e ai).xM = 0 ∧ (candidateAllocation e ai).xH = 0 := by
    intro ha; subst ai; simp [candidateAllocation]
  have hel : e.a < e.H → (candidateAllocation e ai).xH = 0 := by simp [candidateAllocation]
  have hc : compute e (candidateAllocation e ai) ≤ e.mu := by
    have htemp : Feasible {e with mu := compute e (candidateAllocation e ai)} ai
        (candidateAllocation e ai) := ⟨hn,hresL,hresM,hresH,hno,hel,le_refl _⟩
    have hb := compute_le_h {e with mu := compute e (candidateAllocation e ai)} ai
      (candidateAllocation e ai) hr.h_pos hr.m_pos hr.m_lt_H hr.H_lt_one hr.total_mass htemp
    exact le_trans hb (le_of_lt hr.compute_abundant)
  exact ⟨hn,hresL,hresM,hresH,hno,hel,hc⟩

theorem candidate_noProfit (e : Economy) (ai : Bool) (hr : ThreeTypeRegime e) :
    NoProfit e ai (candidatePrices e ai) := by
  rcases regime_facts e hr with ⟨hb,hvL,hqM,hLM,hLM',hD,hD',hLH,hMH⟩
  cases ai <;> simp only [NoProfit,candidatePrices,Bool.false_eq_true,↓reduceIte,
    mul_zero,add_zero,false_implies,true_implies] <;>
    first | exact ⟨le_refl _,le_of_lt hvL,le_of_lt hr.middle_outside,le_refl _,trivial,
      by linarith,by linarith,by linarith⟩
          | exact ⟨le_refl _,le_of_lt hvL,le_of_lt hqM,le_refl _,
              ⟨le_of_lt hr.low_offer,le_refl _,fun hh => le_of_lt (hr.high_offer hh)⟩,
              by linarith,by linarith,by linarith [hr.middle_offer]⟩

theorem candidate_complementary (e : Economy) (ai : Bool) :
    Complementary e (candidateAllocation e ai) (candidatePrices e ai) := by
  cases ai <;> dsimp [Complementary,candidateAllocation,candidatePrices,vL,vM]
  all_goals refine ⟨?_,?_,?_,?_,?_,?_,?_,?_,?_⟩ <;> ring

theorem candidate_equilibrium (e : Economy) (ai : Bool) (hr : ThreeTypeRegime e) :
    Equilibrium e ai (candidateAllocation e ai) (candidatePrices e ai) := by
  exact ⟨candidate_feasible e ai hr,candidate_noProfit e ai hr,
    candidate_complementary e ai,by simp [candidatePrices]⟩

/-- Strict candidate slacks exclude every other baseline activity in any equilibrium. -/
theorem baseline_allocation_unique (e : Economy) (hr : ThreeTypeRegime e)
    (x : Allocation) (p : Prices) (he : Equilibrium e false x p) :
    x = candidateAllocation e false := by
  have hp := equilibrium_rental_zero e false x p hr.h_pos hr.m_pos hr.m_lt_H
    hr.H_lt_one hr.total_mass hr.compute_abundant he
  have hg := equilibrium_cross_gap e false x (candidateAllocation e false) p
    (candidatePrices e false) he (candidate_equilibrium e false hr) hp rfl
  have hc := gap_zero_complementary e false x (candidatePrices e false) he.1
    (candidate_noProfit e false hr) hg
  rcases hc with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩
  simp only [candidatePrices, Bool.false_eq_true, ↓reduceIte, mul_zero, add_zero] at *
  rcases regime_facts e hr with ⟨hb,hvL,hqM,hLM,hLM',hD,hD',hLH,hMH⟩
  have hdL : x.dL = 0 := (mul_eq_zero.mp h1).resolve_right (ne_of_gt hvL)
  have hdM : x.dM = 0 := (mul_eq_zero.mp h2).resolve_right
    (ne_of_gt (sub_pos.mpr hr.middle_outside))
  have hyLM : x.yLM = 0 := (mul_eq_zero.mp h7).resolve_right (ne_of_gt hLM)
  rcases he.1 with ⟨hn,hL,hM,hH,hno,hel,hcomp⟩
  rcases hno rfl with ⟨hxL,hxM,hxH⟩
  simp only [hdL,hdM,hxL,hxM,hxH,hyLM,mul_zero,zero_add,add_zero] at hL hM hH
  rw [hL,hM] at hH
  apply Allocation.ext <;> dsimp [candidateAllocation] <;> linarith

/-- Strict candidate slacks exclude every other validation activity, including
eligible H-AI; ineligible H-AI is excluded by its technology restriction. -/
theorem validation_allocation_unique (e : Economy) (hr : ThreeTypeRegime e)
    (x : Allocation) (p : Prices) (he : Equilibrium e true x p) :
    x = candidateAllocation e true := by
  have hp := equilibrium_rental_zero e true x p hr.h_pos hr.m_pos hr.m_lt_H
    hr.H_lt_one hr.total_mass hr.compute_abundant he
  have hg := equilibrium_cross_gap e true x (candidateAllocation e true) p
    (candidatePrices e true) he (candidate_equilibrium e true hr) hp rfl
  have hc := gap_zero_complementary e true x (candidatePrices e true) he.1
    (candidate_noProfit e true hr) hg
  rcases hc with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩
  simp only [candidatePrices, ↓reduceIte, mul_zero, add_zero] at *
  rcases regime_facts e hr with ⟨hb,hvL,hqM,hLM,hLM',hD,hD',hLH,hMH⟩
  have hdL : x.dL = 0 := (mul_eq_zero.mp h1).resolve_right (ne_of_gt hvL)
  have hdM : x.dM = 0 := (mul_eq_zero.mp h2).resolve_right (ne_of_gt (sub_pos.mpr hqM))
  have hxL : x.xL = 0 := (mul_eq_zero.mp h4).resolve_right
    (ne_of_gt (sub_pos.mpr hr.low_offer))
  have hxH : x.xH = 0 := by
    by_cases hh : e.H ≤ e.a
    · exact (mul_eq_zero.mp h6).resolve_right (ne_of_gt (sub_pos.mpr (hr.high_offer hh)))
    · exact he.1.2.2.2.2.2.1 (lt_of_not_ge hh)
  have hyLM : x.yLM = 0 := (mul_eq_zero.mp h7).resolve_right (ne_of_gt hLM')
  have hyMH : x.yMH = 0 := (mul_eq_zero.mp h9).resolve_right
    (ne_of_gt (by linarith [hr.middle_offer]))
  rcases he.1 with ⟨hn,hL,hM,hH,hno,hel,hcomp⟩
  simp only [hdL,hdM,hxL,hxH,hyLM,hyMH,mul_zero,zero_add,add_zero] at hL hM hH
  rw [hL] at hH
  apply Allocation.ext <;> dsimp [candidateAllocation] <;> linarith

/-- Positive masses in the unique allocation pin all wages; rental is derived zero. -/
theorem equilibrium_unique (e : Economy) (ai : Bool) (hr : ThreeTypeRegime e)
    (x : Allocation) (p : Prices) (he : Equilibrium e ai x p) :
    x = candidateAllocation e ai ∧ p = candidatePrices e ai := by
  have hx : x = candidateAllocation e ai := by
    cases ai
    · exact baseline_allocation_unique e hr x p he
    · exact validation_allocation_unique e hr x p he
  refine ⟨hx,?_⟩
  have hp := equilibrium_rental_zero e ai x p hr.h_pos hr.m_pos hr.m_lt_H
    hr.H_lt_one hr.total_mass hr.compute_abundant he
  have hc := he.2.2.1
  rw [hx] at hc
  rcases regime_facts e hr with ⟨hb,hvL,hqM,hLM,hLM',hD,hD',hLH,hMH⟩
  cases ai <;> rcases hc with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ <;>
    dsimp [candidateAllocation] at h3 h5 h8 h9
  · have hwH : p.wH = e.H := by
      have hz := (mul_eq_zero.mp h3).resolve_left (ne_of_gt hD')
      linarith
    have hwL := (mul_eq_zero.mp h8).resolve_left (ne_of_gt hr.alpha_pos)
    have hwM := (mul_eq_zero.mp h9).resolve_left (ne_of_gt hr.beta_pos)
    rw [hwH] at hwL hwM
    apply Prices.ext <;> dsimp [candidatePrices] <;> linarith
  · have hwH : p.wH = e.H := by
      have hz := (mul_eq_zero.mp h3).resolve_left (ne_of_gt (by linarith :
        0 < e.gamma-e.h*e.alpha-0))
      linarith
    have hwL := (mul_eq_zero.mp h8).resolve_left (ne_of_gt hr.alpha_pos)
    have hwM := (mul_eq_zero.mp h5).resolve_left (ne_of_gt hr.beta_pos)
    rw [hp] at hwM
    rw [hwH] at hwL
    apply Prices.ext <;> dsimp [candidatePrices] <;> linarith

theorem candidate_output_gain (e : Economy) :
    output e (candidateAllocation e true)-output e (candidateAllocation e false) =
      e.beta*(qM e-vM e) := by
  dsimp [output,candidateAllocation,vM]
  ring

theorem candidate_output_gain_positive (e : Economy) (hr : ThreeTypeRegime e) :
    0 < output e (candidateAllocation e true)-output e (candidateAllocation e false) := by
  rw [candidate_output_gain]
  exact mul_pos hr.beta_pos (sub_pos.mpr hr.middle_offer)

end Vasquez26HeterogeneousVerification
