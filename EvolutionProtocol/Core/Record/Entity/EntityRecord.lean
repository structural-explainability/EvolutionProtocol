import EvolutionProtocol.Core.Base.Ids
import EvolutionProtocol.Core.Model.Retention
import EvolutionProtocol.Core.Shared.RecordEnvelope
import EvolutionProtocol.Core.Record.Shared.EntityRef

namespace EvolutionProtocol.Core.Record.Entity

/-!
REQ:
  Schema mirror for: schemas/core/cep.entity.schema.json

OBS:
  This module defines the entity record (envelope + payload + optional retention).
-/

structure EntityPayload where
  entityId : EvolutionProtocol.Core.Base.EntityId
  deriving Repr, BEq, DecidableEq

structure EntityRecord (TimePoint : Type) where
  envelope :
    EvolutionProtocol.Core.Shared.RecordEnvelope
  payload :
    EntityPayload
  retention :
    Option (EvolutionProtocol.Core.Model.RetentionPolicy TimePoint) := none
  deriving Repr, BEq, DecidableEq

def EntityRecord.WellFormed {Time : Type} (x : EntityRecord Time) : Prop :=
  EvolutionProtocol.Core.Shared.RecordEnvelope.WellFormed
      x.envelope ∧
  x.envelope.recordKind =
    EvolutionProtocol.Core.Shared.RecordKind.entity

end EvolutionProtocol.Core.Record.Entity
