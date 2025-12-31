import EvolutionProtocol.Core.Base.Ids
import EvolutionProtocol.Core.Model.Retention
import EvolutionProtocol.Core.Shared.RecordEnvelope
import EvolutionProtocol.Core.Record.Shared.EntityRef

namespace EvolutionProtocol.Core.Record.Relationship

structure RelationshipPayload where
  relationshipId : EvolutionProtocol.Core.Base.RelationshipId

  subjectEntity : EvolutionProtocol.Core.Record.Shared.EntityRef
  objectEntity  : EvolutionProtocol.Core.Record.Shared.EntityRef

  relationshipTypeUri : EvolutionProtocol.Core.Base.Uri
  sourceReferences : Option (List EvolutionProtocol.Core.Base.Uri) := none

  deriving Repr, BEq, DecidableEq


structure RelationshipRecord (TimePoint : Type) where
  envelope :
    EvolutionProtocol.Core.Shared.RecordEnvelope
  payload :
    RelationshipPayload
  retention :
    Option (EvolutionProtocol.Core.Model.RetentionPolicy TimePoint) := none
  deriving Repr, BEq, DecidableEq


def RelationshipRecord.WellFormed {TimePoint : Type} (x : RelationshipRecord TimePoint) : Prop :=
  EvolutionProtocol.Core.Shared.RecordEnvelope.WellFormed x.envelope ∧
  x.envelope.recordKind =
    EvolutionProtocol.Core.Shared.RecordKind.relationship

end EvolutionProtocol.Core.Record.Relationship
