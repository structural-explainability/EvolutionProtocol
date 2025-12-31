import EvolutionProtocol.Spec.IdentifierMap

namespace EvolutionProtocol.Conformance

/-!
# EP Conformance Predicate (v1)

This file provides a proof-carrying conformance interface for EP using the
stable requirement identifiers defined in IdentifierMap.lean.

Each identifier appears exactly once as:
- a ConformanceEvidence field
- an element in `requirements`
Ordering is alphabetical to remove editorial discretion.
-/

/-- Conjunction of a list of propositions. -/
def AndList : List Prop -> Prop
| [] => True
| p :: ps => p ∧ AndList ps

/-
EP conformance is treated as a structural predicate over evidence.
Domain/legal semantics remain external.
-/
structure ConformanceEvidence where
  EP_CONFORMANCE_AE_REQUIRED : Prop
  EP_CONFORMANCE_SE_REQUIRED : Prop
  EP_DEFINITION_CORE : Prop
  EP_GRAPH_DEFINITION : Prop
  EP_GRAPH_DELTA : Prop
  EP_GRAPH_EVOLUTION : Prop
  EP_GRAPH_STATE : Prop
  EP_SCOPE_EXCLUSIONS : Prop

/-- Alphabetized requirements list for EP v1. -/
def requirements (e : ConformanceEvidence) : List Prop :=
  [ e.EP_CONFORMANCE_AE_REQUIRED
  , e.EP_CONFORMANCE_SE_REQUIRED
  , e.EP_DEFINITION_CORE
  , e.EP_GRAPH_DEFINITION
  , e.EP_GRAPH_DELTA
  , e.EP_GRAPH_EVOLUTION
  , e.EP_GRAPH_STATE
  , e.EP_SCOPE_EXCLUSIONS
  ]

/-- EP conformance predicate: all EP requirements hold. -/
def Conforms (e : ConformanceEvidence) : Prop :=
  AndList (requirements e)

/-- If `AndList ps` holds, then every member of `ps` holds. -/
theorem andList_of_mem {ps : List Prop} {p : Prop} :
    p ∈ ps -> AndList ps -> p := by
  intro hmem hand
  induction ps with
  | nil =>
      cases hmem
  | cons a as ih =>
      have hand' : a ∧ AndList as := by
        simpa [AndList] using hand
      have ha : a := hand'.1
      have hrest : AndList as := hand'.2
      have hmem' : p = a ∨ p ∈ as := by
        simpa using hmem
      cases hmem' with
      | inl hpa =>
          subst hpa
          exact ha
      | inr htail =>
          exact ih htail hrest

/-- Generic extractor: if `p` is listed and `Conforms` holds, then `p` holds. -/
theorem conforms_of_mem (e : ConformanceEvidence) (p : Prop) :
    p ∈ requirements e -> Conforms e -> p := by
  intro hmem hconf
  unfold Conforms at hconf
  exact andList_of_mem (ps := requirements e) (p := p) hmem hconf

end EvolutionProtocol.Conformance
