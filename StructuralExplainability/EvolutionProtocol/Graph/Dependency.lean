import StructuralExplainability.EvolutionProtocol.Graph.EvolutionStore

namespace StructuralExplainability.EvolutionProtocol.Graph.Dependency

open StructuralExplainability.EvolutionProtocol.Graph

def dependsOn {Time : Type}
  (g : EvolutionStore Time)
  (a b : StructuralExplainability.EvolutionProtocol.Core.Base.EvolutionId) : Prop :=
  ∃ e : StructuralExplainability.EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time,
    e ∈ g.evolutions ∧
    EvolutionStore.evolutionId e = a ∧
    match e.payload.dependsOnEvolutionIds with
    | none => False
    | some deps => b ∈ deps

-- etc...

end StructuralExplainability.EvolutionProtocol.Graph.Dependency
