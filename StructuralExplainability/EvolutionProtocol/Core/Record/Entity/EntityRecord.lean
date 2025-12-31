import StructuralExplainability.EvolutionProtocol.Core.Base.Ids
import StructuralExplainability.EvolutionProtocol.Core.Model.Retention
import StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope
import StructuralExplainability.EvolutionProtocol.Core.Record.Shared.EntityRef

namespace StructuralExplainability.EvolutionProtocol.Core.Record.Entity

/-!
REQ:
  Schema mirror for: schemas/core/cep.entity.schema.json

OBS:
  This module defines the entity record (envelope + payload + optional retention).
-/

structure EntityPayload where
  entityId : StructuralExplainability.EvolutionProtocol.Core.Base.EntityId
  deriving Repr, BEq, DecidableEq

structure EntityRecord (TimePoint : Type) where
  envelope :
    StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope
  payload :
    EntityPayload
  retention :
    Option (StructuralExplainability.EvolutionProtocol.Core.Model.RetentionPolicy TimePoint) := none
  deriving Repr, BEq, DecidableEq

def EntityRecord.WellFormed {Time : Type} (x : EntityRecord Time) : Prop :=
  StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope.WellFormed
      x.envelope ∧
  x.envelope.recordKind =
    StructuralExplainability.EvolutionProtocol.Core.Shared.RecordKind.entity

end StructuralExplainability.EvolutionProtocol.Core.Record.Entity
