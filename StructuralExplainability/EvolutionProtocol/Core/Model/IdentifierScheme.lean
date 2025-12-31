import StructuralExplainability.EvolutionProtocol.Core.Base.Primitives

namespace StructuralExplainability.EvolutionProtocol.Core.Model

/-!
REQ:
  Identifier scheme tags and typed identifiers.

WHY:
  Enables stable reference across systems without embedding validation logic.

OBS:
  Structural only; parsing/validation belongs outside the core layer.
-/

inductive IdentifierScheme where
  | uri
  | lei
  | uei
  | ocd
  | internal
  deriving Repr, BEq, DecidableEq

structure Identifier where
  scheme : IdentifierScheme
  value : String
  deriving Repr, BEq, DecidableEq

def Identifier.toString (i : Identifier) : String :=
  s!"{repr i.scheme}:{i.value}"

end StructuralExplainability.EvolutionProtocol.Core.Model
