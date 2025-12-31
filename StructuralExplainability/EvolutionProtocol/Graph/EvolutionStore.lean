import StructuralExplainability.EvolutionProtocol.Core.Record.Evolution.EvolutionRecord

namespace StructuralExplainability.EvolutionProtocol.Graph

structure EvolutionStore (Time : Type) where
  evolutions :
    List (StructuralExplainability.EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time)
  deriving Repr

/-- Convenience: the ID of an evolution record is its envelope.verifiableId. -/
def EvolutionStore.evolutionId {Time : Type}
  (e : StructuralExplainability.EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time) :
  StructuralExplainability.EvolutionProtocol.Core.Base.EvolutionId :=
  e.envelope.verifiableId

/-- Find an evolution by id (first match). -/
def EvolutionStore.findEvolution? {Time : Type}
  (g : EvolutionStore Time)
  (id : StructuralExplainability.EvolutionProtocol.Core.Base.EvolutionId) :
  Option (StructuralExplainability.EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time) :=
  g.evolutions.find? (fun e => EvolutionStore.evolutionId e == id)

end StructuralExplainability.EvolutionProtocol.Graph
