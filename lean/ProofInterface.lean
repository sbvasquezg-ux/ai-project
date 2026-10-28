import Vasquez26HeterogeneousVerification.PaperInterface
namespace Vasquez26HeterogeneousVerification

theorem proposition_one : PropositionOneSpec := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro h a r z wp cp w c hh hz hza ha hw hc hm
    exact foc_of_local_max h a r z wp cp w c hh (lt_trans hza ha) hw hc hm
  · intro h a r z wp cp w c hh hz hw hc hm hp
    have hf := foc_of_local_max h a r z wp cp w c hh hz hw hc hm
    have hr := rental_foc h a r z wp cp w c hh hz hw hc hm hp
    exact ⟨hf.symm.trans hr,hr⟩
  · exact wage_of_zero_profit
  · exact active_neighborhood_slope

theorem proposition_two : PropositionTwoSpec := by
  intro e hh hh1 hm hmH hH hma ha hk halpha hbeta hgamma htotal hmu
    hsurplus houtside hlo hmid hhi
  have hr : ThreeTypeRegime e := ⟨hh,hh1,hm,hmH,hH,hma,ha,hk,halpha,hbeta,hgamma,
    htotal,hmu,hsurplus,houtside,hlo,hmid,hhi⟩
  exact ⟨⟨candidate_equilibrium e false hr, equilibrium_unique e false hr⟩,
    ⟨candidate_equilibrium e true hr, equilibrium_unique e true hr⟩,
    candidate_output_gain e, candidate_output_gain_positive e hr⟩

#print axioms proposition_two
#print axioms proposition_one
#print axioms middle_certificate
#print axioms exact_three_type_certificate
end Vasquez26HeterogeneousVerification
