import EvolutionProtocol.Core.Record.Evolution.EvolutionRecord

namespace EvolutionProtocol.Graph

structure EvolutionStore (Time : Type) where
  evolutions :
    List (EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time)
  deriving Repr

/-- Convenience: the ID of an evolution record is its envelope.verifiableId. -/
def EvolutionStore.evolutionId {Time : Type}
  (e : EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time) :
  EvolutionProtocol.Core.Base.EvolutionId :=
  e.envelope.verifiableId

/-- Find an evolution by id (first match). -/
def EvolutionStore.findEvolution? {Time : Type}
  (g : EvolutionStore Time)
  (id : EvolutionProtocol.Core.Base.EvolutionId) :
  Option (EvolutionProtocol.Core.Record.Evolution.EvolutionRecord Time) :=
  g.evolutions.find? (fun e => EvolutionStore.evolutionId e == id)

end EvolutionProtocol.Graph
