import Vasquez26HeterogeneousVerification.PaperInterface
namespace Vasquez26HeterogeneousVerification

theorem proposition_one : PropositionOneSpec := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro h a r z wp cp w c hh hz hza ha hw hc hm
    exact foc_of_local_max h a r z wp cp w c hh (lt_trans hza ha) hw hc hm
  · exact rental_foc
  · exact wage_of_zero_profit
  · exact active_interval_slope

#print axioms proposition_one
#print axioms middle_certificate
#print axioms exact_three_type_certificate
end Vasquez26HeterogeneousVerification
