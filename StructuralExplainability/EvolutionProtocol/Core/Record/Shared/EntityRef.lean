import StructuralExplainability.EvolutionProtocol.Core.Base.Primitives
import StructuralExplainability.EvolutionProtocol.Core.Base.Ids

namespace StructuralExplainability.EvolutionProtocol.Core.Record.Shared

/-!
REQ:
  Minimal entity reference used by record payloads.

WHY:
  Evolution, relationship, and other records reference entities
  without importing the full entity model.

OBS:
  Structural only; no validation or resolution logic lives here.
-/


/-- Lightweight reference to an entity. -/
structure EntityRef where
  entityId : StructuralExplainability.EvolutionProtocol.Core.Base.EntityId
  roleUri : Option StructuralExplainability.EvolutionProtocol.Core.Base.Uri := none
  accountIdentifier : Option String := none
  deriving Repr, BEq, DecidableEq

end StructuralExplainability.EvolutionProtocol.Core.Record.Shared
