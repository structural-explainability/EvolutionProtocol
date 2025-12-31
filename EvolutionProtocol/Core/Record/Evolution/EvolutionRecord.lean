import EvolutionProtocol.Core.Base.Ids
import EvolutionProtocol.Core.Model.Retention
import EvolutionProtocol.Core.Shared.RecordEnvelope

namespace EvolutionProtocol.Core.Record.Evolution

/-!
REQ:
  Schema mirror for: schemas/core/cep.evolution.schema.json

OBS:
  Structural only; no validation or resolution logic.
-/


abbrev Uri := EvolutionProtocol.Core.Base.Uri
abbrev DateTime := EvolutionProtocol.Core.Base.DateTime
abbrev Sha256 := EvolutionProtocol.Core.Base.Sha256

abbrev RelationshipId := EvolutionProtocol.Core.Base.RelationshipId
abbrev EvolutionId := EvolutionProtocol.Core.Base.EvolutionId
abbrev ConsentId := EvolutionProtocol.Core.Base.ConsentId


inductive EvolutionStatusCode where
  | PENDING
  | COMPLETED
  | REVERSED
  | CANCELED
  | DISPUTED
  deriving Repr, BEq, DecidableEq


structure EvolutionStatus where
  statusCode : EvolutionStatusCode
  statusEffectiveTimestamp : DateTime
  deriving Repr, BEq, DecidableEq


structure EvolutionValue where
  amount : Float
  currencyCode : Option String := none
  valueTypeUri : Option Uri := none
  inKindDescription : Option String := none
  deriving Repr, BEq


structure IntermediaryEntity where
  entityId : String
  roleUri : Option Uri := none
  deriving Repr, BEq, DecidableEq


structure ProvenanceChain where
  fundingChainTag : Option String := none
  ultimateSourceEntityId : Option String := none
  intermediaryEntities : Option (List IntermediaryEntity) := none
  parentEvolutionId : Option String := none
  deriving Repr, BEq, DecidableEq


structure Categorization where
  cfdaNumber : Option String := none
  naicsCode : Option String := none
  gtasAccountCode : Option String := none
  localCategoryCode : Option String := none
  localCategoryLabel : Option String := none
  deriving Repr, BEq, DecidableEq


structure SourceReference where
  sourceSystemUri : Uri
  sourceRecordId : String
  sourceUrl : Option Uri := none
  deriving Repr, BEq, DecidableEq


structure EvolutionPayload where
  relationshipId : RelationshipId
  evolutionTypeUri : Uri

  sourceEntity : String
  recipientEntity : String

  value : EvolutionValue
  occurredTimestamp : DateTime
  evolutionStatus : EvolutionStatus

  provenanceChain : Option ProvenanceChain := none
  categorization : Option Categorization := none
  sourceReferences : Option (List SourceReference) := none
  previousRecordHash : Option Sha256 := none

  dependsOnEvolutionIds : Option (List EvolutionId) := none
  requiresConsentIds : Option (List ConsentId) := none
  deriving Repr, BEq


structure EvolutionRecord (Time : Type) where
  envelope : EvolutionProtocol.Core.Shared.RecordEnvelope
  payload : EvolutionPayload
  retention :
    Option (EvolutionProtocol.Core.Model.RetentionPolicy Time) := none
  deriving Repr, BEq


def EvolutionRecord.WellFormed {Time : Type} (x : EvolutionRecord Time) : Prop :=
  EvolutionProtocol.Core.Shared.RecordEnvelope.WellFormed x.envelope ∧
  x.envelope.recordKind =
    EvolutionProtocol.Core.Shared.RecordKind.evolution

end EvolutionProtocol.Core.Record.Evolution
