import EvolutionProtocol.Graph.EvolutionStore

namespace EvolutionProtocol.Graph.Dependency

open EvolutionProtocol.Graph

def dependsOn {Time : Type}
  (g : EvolutionStore Time)
  (a b : EvolutionProtocol.Core.Base.EvolutionId) : Prop :=
  ∃ e : EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time,
    e ∈ g.evolutions ∧
    EvolutionStore.evolutionId e = a ∧
    match e.payload.dependsOnEvolutionIds with
    | none => False
    | some deps => b ∈ deps

-- etc...

end EvolutionProtocol.Graph.Dependency
