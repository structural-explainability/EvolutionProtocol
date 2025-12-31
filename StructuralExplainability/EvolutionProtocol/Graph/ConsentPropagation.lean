import StructuralExplainability.EvolutionProtocol.Graph.EvolutionGraph
import StructuralExplainability.EvolutionProtocol.Core.Model.Consent

namespace StructuralExplainability.EvolutionProtocol.Graph

/-!
OBS:
  This file uses EvolutionId as the node identifier for all nodes in EvolutionGraph,
  including consent nodes. A future refinement may introduce Vertex := Sum EvolutionId ConsentId.
-/

abbrev Invalid :=
  EvolutionId -> Prop

abbrev ConsentStateOf :=
  EvolutionId -> StructuralExplainability.EvolutionProtocol.Core.Model.ConsentState

axiom invalid_of_direct_withdrawn_dependency
  (g : EvolutionGraph)
  (consentStateOf : ConsentStateOf)
  (Invalid : Invalid)
  :
  ∀ (e c : EvolutionId),
    HasDependency g e c ->
    consentStateOf c =
      StructuralExplainability.EvolutionProtocol.Core.Model.ConsentState.Withdrawn ->
    Invalid e

axiom invalid_propagates_upstream
  (g : EvolutionGraph)
  (Invalid : Invalid)
  :
  ∀ (x y : EvolutionId),
    HasDependency g x y ->
    Invalid y ->
    Invalid x

theorem invalid_of_withdrawn_dependency_closure
  (g : EvolutionGraph)
  (consentStateOf : ConsentStateOf)
  (Invalid : Invalid)
  :
  ∀ (e c : EvolutionId),
    DependsPath g e c ->
    consentStateOf c =
      StructuralExplainability.EvolutionProtocol.Core.Model.ConsentState.Withdrawn ->
    Invalid e := by
  intro e c hp hwithdrawn
  induction hp with
  | step a b hdep =>
      exact
        invalid_of_direct_withdrawn_dependency
          g consentStateOf Invalid a b hdep hwithdrawn
  | trans a b c hab hbc ih_ab ih_bc =>
      have hinv_b : Invalid b := ih_bc hwithdrawn
      have helper :
        ∀ (x y : EvolutionId), DependsPath g x y -> Invalid y -> Invalid x := by
          intro x y hxy hyinv
          induction hxy with
          | step u v huv =>
              exact invalid_propagates_upstream g Invalid u v huv hyinv
          | trans u v w huv hvw ih1 ih2 =>
              have inv_v : Invalid v := ih2 hyinv
              exact ih1 inv_v
      exact helper a b hab hinv_b

end StructuralExplainability.EvolutionProtocol.Graph
