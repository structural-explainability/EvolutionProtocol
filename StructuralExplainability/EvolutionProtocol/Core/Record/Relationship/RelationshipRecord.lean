import StructuralExplainability.EvolutionProtocol.Core.Base.Ids
import StructuralExplainability.EvolutionProtocol.Core.Model.Retention
import StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope
import StructuralExplainability.EvolutionProtocol.Core.Record.Shared.EntityRef

namespace StructuralExplainability.EvolutionProtocol.Core.Record.Relationship

structure RelationshipPayload where
  relationshipId : StructuralExplainability.EvolutionProtocol.Core.Base.RelationshipId

  subjectEntity : StructuralExplainability.EvolutionProtocol.Core.Record.Shared.EntityRef
  objectEntity  : StructuralExplainability.EvolutionProtocol.Core.Record.Shared.EntityRef

  relationshipTypeUri : StructuralExplainability.EvolutionProtocol.Core.Base.Uri
  sourceReferences : Option (List StructuralExplainability.EvolutionProtocol.Core.Base.Uri) := none

  deriving Repr, BEq, DecidableEq


structure RelationshipRecord (TimePoint : Type) where
  envelope :
    StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope
  payload :
    RelationshipPayload
  retention :
    Option (StructuralExplainability.EvolutionProtocol.Core.Model.RetentionPolicy TimePoint) := none
  deriving Repr, BEq, DecidableEq


def RelationshipRecord.WellFormed {TimePoint : Type} (x : RelationshipRecord TimePoint) : Prop :=
  StructuralExplainability.EvolutionProtocol.Core.Shared.RecordEnvelope.WellFormed x.envelope ∧
  x.envelope.recordKind =
    StructuralExplainability.EvolutionProtocol.Core.Shared.RecordKind.relationship

end StructuralExplainability.EvolutionProtocol.Core.Record.Relationship
