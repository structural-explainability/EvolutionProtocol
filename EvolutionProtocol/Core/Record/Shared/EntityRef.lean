import EvolutionProtocol.Core.Base.Primitives
import EvolutionProtocol.Core.Base.Ids

namespace EvolutionProtocol.Core.Record.Shared

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
  entityId : EvolutionProtocol.Core.Base.EntityId
  roleUri : Option EvolutionProtocol.Core.Base.Uri := none
  accountIdentifier : Option String := none
  deriving Repr, BEq, DecidableEq

end EvolutionProtocol.Core.Record.Shared
