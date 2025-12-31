import StructuralExplainability.EvolutionProtocol.Core.Base.Primitives

namespace StructuralExplainability.EvolutionProtocol.Core.Shared

/-!
REQ:
  Shared record envelope used by all record kinds.

OBS:
  Keep shared types upstream and stable; do not grow this file with feature logic.
-/

-- Local aliases for Base primitives are stable and non-ambiguous
abbrev Date := String
abbrev VerifiableId := String

/-- recordKind enum from the schema. -/
inductive RecordKind where
  | entity
  | relationship
  | evolution
  deriving Repr, BEq, DecidableEq

/-- status object from $defs.status. -/
structure RecordStatus where
  statusCode : String
  statusReason : Option String := none
  statusEffectiveDate : Date
  deriving Repr, BEq, DecidableEq

/-- timestamps object from $defs.timestamps. -/
structure RecordTimestamps where
  firstSeenAt : Option StructuralExplainability.EvolutionProtocol.Core.Base.DateTime := none
  lastUpdatedAt : StructuralExplainability.EvolutionProtocol.Core.Base.DateTime
  validFrom : StructuralExplainability.EvolutionProtocol.Core.Base.DateTime
  validTo : Option StructuralExplainability.EvolutionProtocol.Core.Base.DateTime := none
  deriving Repr, BEq, DecidableEq



/-- Shared envelope for all records. -/
structure RecordEnvelope where
  recordKind : RecordKind
  recordSchemaUri : Option StructuralExplainability.EvolutionProtocol.Core.Base.Uri := none
  schemaVersion : String
  revisionNumber : Nat
  verifiableId : VerifiableId
  recordTypeUri : StructuralExplainability.EvolutionProtocol.Core.Base.Uri
  status : RecordStatus
  timestamps : RecordTimestamps
  deriving Repr, BEq, DecidableEq

/-- Structural constraints corresponding to key schema requirements. -/
def RecordEnvelope.WellFormed (env : RecordEnvelope) : Prop :=
  env.revisionNumber >= 1


/--
Canonical constructor for a newly-created envelope.

OBS:
  revisionNumber is forced to be >= 1 (defaults to 1) via Nat.succ.
-/
def RecordEnvelope.mkCreated
  (recordKind : RecordKind)
  (schemaVersion : String)
  (verifiableId : VerifiableId)
  (recordTypeUri : StructuralExplainability.EvolutionProtocol.Core.Base.Uri)
  (status : RecordStatus)
  (timestamps : RecordTimestamps)
  (revisionNumber : Nat := 0)
  (recordSchemaUri : Option StructuralExplainability.EvolutionProtocol.Core.Base.Uri := none)
  : RecordEnvelope :=
  { recordKind := recordKind
    recordSchemaUri := recordSchemaUri
    schemaVersion := schemaVersion
    revisionNumber := revisionNumber.succ
    verifiableId := verifiableId
    recordTypeUri := recordTypeUri
    status := status
    timestamps := timestamps }

end StructuralExplainability.EvolutionProtocol.Core.Shared
