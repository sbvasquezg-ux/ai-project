import Vasquez26HeterogeneousVerification.MainTheorems

noncomputable section
namespace Vasquez26HeterogeneousVerification

/-- Divisible masses: independents, AI users, then every ordered human pair. -/
@[ext] structure Allocation where
  dL : ℝ
  dM : ℝ
  dH : ℝ
  xL : ℝ
  xM : ℝ
  xH : ℝ
  yLM : ℝ
  yLH : ℝ
  yMH : ℝ
  deriving DecidableEq

@[ext] structure Prices where
  wL : ℝ
  wM : ℝ
  wH : ℝ
  r : ℝ
  deriving DecidableEq

structure Economy where
  h : ℝ
  m : ℝ
  H : ℝ
  a : ℝ
  k : ℝ
  alpha : ℝ
  beta : ℝ
  gamma : ℝ
  mu : ℝ

def bM (e : Economy) := assistanceTime e.h e.m
def bH (e : Economy) := assistanceTime e.h e.H
def qL (e : Economy) := netOffer e.a e.k 0
def qM (e : Economy) := netOffer e.a e.k e.m
def qH (e : Economy) := netOffer e.a e.k e.H
def vL (e : Economy) := e.H*(1-e.h)
def vM (e : Economy) := e.H*(1-bM e)

def Allocation.Nonnegative (x : Allocation) : Prop :=
  0 ≤ x.dL ∧ 0 ≤ x.dM ∧ 0 ≤ x.dH ∧ 0 ≤ x.xL ∧ 0 ≤ x.xM ∧
  0 ≤ x.xH ∧ 0 ≤ x.yLM ∧ 0 ≤ x.yLH ∧ 0 ≤ x.yMH

def compute (e : Economy) (x : Allocation) := e.h*x.xL+bM e*x.xM+bH e*x.xH

/-- Human clearing counts solver time, and ineligible/absent AI has zero mass. -/
def Feasible (e : Economy) (ai : Bool) (x : Allocation) : Prop :=
  x.Nonnegative ∧
  x.dL+x.xL+x.yLM+x.yLH = e.alpha ∧
  x.dM+x.xM+e.h*x.yLM+x.yMH = e.beta ∧
  x.dH+x.xH+e.h*x.yLH+bM e*x.yMH = e.gamma ∧
  (ai = false → x.xL = 0 ∧ x.xM = 0 ∧ x.xH = 0) ∧
  (e.a < e.H → x.xH = 0) ∧ compute e x ≤ e.mu

/-- Every independent activity, eligible AI activity and human pair has no profit. -/
def NoProfit (e : Economy) (ai : Bool) (p : Prices) : Prop :=
  0 ≤ p.r ∧ 0 ≤ p.wL ∧ e.m ≤ p.wM ∧ e.H ≤ p.wH ∧
  (ai = true → qL e ≤ p.wL+e.h*p.r ∧ qM e ≤ p.wM+bM e*p.r ∧
    (e.H ≤ e.a → qH e ≤ p.wH+bH e*p.r)) ∧
  e.m ≤ p.wL+e.h*p.wM ∧ e.H ≤ p.wL+e.h*p.wH ∧
  e.H ≤ p.wM+bM e*p.wH

/-- Zero profit for all used activities, including all three AI possibilities. -/
def Complementary (e : Economy) (x : Allocation) (p : Prices) : Prop :=
  x.dL*p.wL = 0 ∧ x.dM*(p.wM-e.m) = 0 ∧ x.dH*(p.wH-e.H) = 0 ∧
  x.xL*(p.wL+e.h*p.r-qL e) = 0 ∧
  x.xM*(p.wM+bM e*p.r-qM e) = 0 ∧
  x.xH*(p.wH+bH e*p.r-qH e) = 0 ∧
  x.yLM*(p.wL+e.h*p.wM-e.m) = 0 ∧
  x.yLH*(p.wL+e.h*p.wH-e.H) = 0 ∧
  x.yMH*(p.wM+bM e*p.wH-e.H) = 0

/-- Competitive equilibrium has human clearing, all deviations, zero profits,
and the compute market with nonnegative rental and complementarity. -/
def Equilibrium (e : Economy) (ai : Bool) (x : Allocation) (p : Prices) : Prop :=
  Feasible e ai x ∧ NoProfit e ai p ∧ Complementary e x p ∧
  p.r*(e.mu-compute e x) = 0

def output (e : Economy) (x : Allocation) :=
  e.m*x.dM+e.H*x.dH+qL e*x.xL+qM e*x.xM+qH e*x.xH+
  e.m*x.yLM+e.H*x.yLH+e.H*x.yMH

def wageBill (e : Economy) (p : Prices) := e.alpha*p.wL+e.beta*p.wM+e.gamma*p.wH

def gap (e : Economy) (x : Allocation) (p : Prices) :=
  x.dL*p.wL+x.dM*(p.wM-e.m)+x.dH*(p.wH-e.H)+
  x.xL*(p.wL+e.h*p.r-qL e)+x.xM*(p.wM+bM e*p.r-qM e)+
  x.xH*(p.wH+bH e*p.r-qH e)+x.yLM*(p.wL+e.h*p.wM-e.m)+
  x.yLH*(p.wL+e.h*p.wH-e.H)+x.yMH*(p.wM+bM e*p.wH-e.H)

/-- Exact resource accounting, without an optimization assumption. -/
theorem gap_identity (e : Economy) (ai : Bool) (x : Allocation) (p : Prices)
    (hf : Feasible e ai x) :
    gap e x p = wageBill e p+p.r*compute e x-output e x := by
  rcases hf with ⟨_, hL, hM, hH, _⟩
  dsimp [gap, wageBill, compute, output]
  rw [← hL, ← hM, ← hH]
  ring

theorem nonnegative_products (e : Economy) (ai : Bool) (x : Allocation) (p : Prices)
    (hf : Feasible e ai x) (hp : NoProfit e ai p) : Allocation.Nonnegative
    { dL := x.dL*p.wL, dM := x.dM*(p.wM-e.m),
      dH := x.dH*(p.wH-e.H), xL := x.xL*(p.wL+e.h*p.r-qL e),
      xM := x.xM*(p.wM+bM e*p.r-qM e), xH := x.xH*(p.wH+bH e*p.r-qH e),
      yLM := x.yLM*(p.wL+e.h*p.wM-e.m), yLH := x.yLH*(p.wL+e.h*p.wH-e.H),
      yMH := x.yMH*(p.wM+bM e*p.wH-e.H) } := by
  rcases hf with ⟨hn, _, _, _, hno, hel, _⟩
  rcases hn with ⟨hdL, hdM, hdH, hxL, hxM, hxH, hyLM, hyLH, hyMH⟩
  rcases hp with ⟨_, hwL, hwM, hwH, hai, hwLM, hwLH, hwMH⟩
  have hL : 0 ≤ x.xL*(p.wL+e.h*p.r-qL e) := by
    cases ai with
    | false => rw [(hno rfl).1]; simp
    | true => exact mul_nonneg hxL (sub_nonneg.mpr (hai rfl).1)
  have hM : 0 ≤ x.xM*(p.wM+bM e*p.r-qM e) := by
    cases ai with
    | false => rw [(hno rfl).2.1]; simp
    | true => exact mul_nonneg hxM (sub_nonneg.mpr (hai rfl).2.1)
  have hH : 0 ≤ x.xH*(p.wH+bH e*p.r-qH e) := by
    by_cases he : e.H ≤ e.a
    · cases ai with
      | false => rw [(hno rfl).2.2]; simp
      | true => exact mul_nonneg hxH (sub_nonneg.mpr ((hai rfl).2.2 he))
    · rw [hel (lt_of_not_ge he)]; simp
  exact ⟨mul_nonneg hdL hwL, mul_nonneg hdM (sub_nonneg.mpr hwM),
    mul_nonneg hdH (sub_nonneg.mpr hwH), hL, hM, hH,
    mul_nonneg hyLM (sub_nonneg.mpr hwLM), mul_nonneg hyLH (sub_nonneg.mpr hwLH),
    mul_nonneg hyMH (sub_nonneg.mpr hwMH)⟩

theorem gap_nonnegative (e : Economy) (ai : Bool) (x : Allocation) (p : Prices)
    (hf : Feasible e ai x) (hp : NoProfit e ai p) : 0 ≤ gap e x p := by
  rcases nonnegative_products e ai x p hf hp with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩
  dsimp [gap]
  linarith

theorem gap_zero_complementary (e : Economy) (ai : Bool) (x : Allocation) (p : Prices)
    (hf : Feasible e ai x) (hp : NoProfit e ai p) (hg : gap e x p = 0) :
    Complementary e x p := by
  rcases nonnegative_products e ai x p hf hp with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩
  dsimp [gap] at hg
  dsimp [Complementary]
  exact ⟨by linarith, by linarith, by linarith, by linarith, by linarith,
    by linarith, by linarith, by linarith, by linarith⟩

theorem complementary_gap (e : Economy) (x : Allocation) (p : Prices)
    (hc : Complementary e x p) : gap e x p = 0 := by
  rcases hc with ⟨h1,h2,h3,h4,h5,h6,h7,h8,h9⟩
  dsimp [gap]; rw [h1,h2,h3,h4,h5,h6,h7,h8,h9]; ring

/-- Compute is bounded by h times the total human mass. -/
theorem compute_le_h (e : Economy) (ai : Bool) (x : Allocation)
    (hh : 0 < e.h) (hm : 0 < e.m) (hmH : e.m < e.H) (hH : e.H < 1)
    (htotal : e.alpha+e.beta+e.gamma = 1) (hf : Feasible e ai x) :
    compute e x ≤ e.h := by
  rcases hf with ⟨hn,hL,hM,hR,_⟩
  rcases hn with ⟨hdL,hdM,hdH,hxL,hxM,hxH,hyLM,hyLH,hyMH⟩
  have hb : 0 < bM e := mul_pos hh (sub_pos.mpr (lt_trans hmH hH))
  have hH0 : 0 < e.H := lt_trans hm hmH
  have hsum : x.xL+x.xM+x.xH ≤ 1 := by
    have := mul_nonneg (le_of_lt hh) hyLM
    have := mul_nonneg (le_of_lt hh) hyLH
    have := mul_nonneg (le_of_lt hb) hyMH
    linarith
  have hmprod := mul_nonneg (le_of_lt hm) hxM
  have hHprod := mul_nonneg (le_of_lt hH0) hxH
  have hd : compute e x ≤ e.h*(x.xL+x.xM+x.xH) := by
    dsimp [compute,bM,bH,assistanceTime]
    nlinarith
  nlinarith

/-- The rental is derived, rather than fixed in the equilibrium definition. -/
theorem equilibrium_rental_zero (e : Economy) (ai : Bool) (x : Allocation) (p : Prices)
    (hh : 0 < e.h) (hm : 0 < e.m) (hmH : e.m < e.H) (hH : e.H < 1)
    (htotal : e.alpha+e.beta+e.gamma = 1) (hmu : e.h < e.mu)
    (he : Equilibrium e ai x p) : p.r = 0 := by
  have hc := compute_le_h e ai x hh hm hmH hH htotal he.1
  exact (mul_eq_zero.mp he.2.2.2).resolve_right (ne_of_gt (by linarith))

/-- Two equilibria with zero rental attain equal output, by both dual inequalities. -/
theorem equilibrium_cross_gap (e : Economy) (ai : Bool)
    (x y : Allocation) (p q : Prices)
    (hx : Equilibrium e ai x p) (hy : Equilibrium e ai y q)
    (hp : p.r = 0) (hq : q.r = 0) : gap e x q = 0 := by
  have hxx := gap_identity e ai x p hx.1
  have hyy := gap_identity e ai y q hy.1
  have hxy := gap_identity e ai x q hx.1
  have hyx := gap_identity e ai y p hy.1
  have hpx := complementary_gap e x p hx.2.2.1
  have hqy := complementary_gap e y q hy.2.2.1
  have hnp := gap_nonnegative e ai y p hy.1 hx.2.1
  have hnq := gap_nonnegative e ai x q hx.1 hy.2.1
  rw [hp] at hxx hyx
  rw [hq] at hyy hxy
  simp only [zero_mul, add_zero] at hxx hyy hxy hyx
  linarith

end Vasquez26HeterogeneousVerification
