namespace EvolutionProtocol.Spec

/-!
# EP Identifier Map

This file defines the stable EP requirement identifiers and provides a
traceability mapping to Lean anchors (module + declaration).

Identifiers are the sole normative reference mechanism. Ordering here is
alphabetical to remove editorial discretion.

Each identifier in this list should appear exactly once across:
- SPEC.md
- CONFORMANCE.md
- ConformanceEvidence fields
- requirements list
- this IdentifierMap
-/

/-- Stable requirement identifier type. -/
abbrev ReqId := String

/-- A traceability entry connecting a requirement id to a Lean anchor. -/
structure Entry where
  id : ReqId
  description : String
  leanModule : String
  leanDecl : String
  deriving Repr, BEq, DecidableEq

namespace Req

-- Canonical Identifier List (Alphabetical)

def EP_CONFORMANCE_AE_REQUIRED : ReqId := "EP.CONFORMANCE.AE.REQUIRED"
def EP_CONFORMANCE_SE_REQUIRED : ReqId := "EP.CONFORMANCE.SE.REQUIRED"
def EP_DEFINITION_CORE         : ReqId := "EP.DEFINITION.CORE"
def EP_GRAPH_DEFINITION        : ReqId := "EP.GRAPH.DEFINITION"
def EP_GRAPH_DELTA             : ReqId := "EP.GRAPH.DELTA"
def EP_GRAPH_EVOLUTION          : ReqId := "EP.GRAPH.EVOLUTION"
def EP_GRAPH_STATE             : ReqId := "EP.GRAPH.STATE"
def EP_SCOPE_EXCLUSIONS        : ReqId := "EP.SCOPE.EXCLUSIONS"

end Req

/--
Canonical traceability entries (alphabetical by id).

OBS:
- `leanModule`/`leanDecl` are anchors. They may evolve as files move,
  but the identifiers must not be renamed or repurposed.
- Keep the list in strict alphabetical order by `id`.
-/
def entries : List Entry :=
  [
    { id := Req.EP_CONFORMANCE_AE_REQUIRED
      description := "EP operates over Accountable Entities (AE) and their identity regimes."
      leanModule := "EvolutionProtocol"
      leanDecl := "EP_Conformance_AE_Required" },

    { id := Req.EP_CONFORMANCE_SE_REQUIRED
      description := "EP conforms to Structural Explainability (SE) neutrality constraints."
      leanModule := "EvolutionProtocol"
      leanDecl := "EP_Conformance_SE_Required" },

    { id := Req.EP_DEFINITION_CORE
      description := "Core definition of EP as structural graph evolution without causal/interpretive commitment."
      leanModule := "EvolutionProtocol"
      leanDecl := "EP_Definition_Core" },

    { id := Req.EP_GRAPH_DEFINITION
      description := "Structural form of graphs in EP."
      leanModule := "EvolutionProtocol.Graph"
      leanDecl := "GraphDefinition" },

    { id := Req.EP_GRAPH_DELTA
      description := "Structured, non-causal graph change records (deltas)."
      leanModule := "EvolutionProtocol.Graph.Dependency"
      leanDecl := "Delta" },

    { id := Req.EP_GRAPH_EVOLUTION
      description := "Ordered graph histories connecting states via deltas."
      leanModule := "EvolutionProtocol.Graph.ExchangeGraph"
      leanDecl := "Evolution" },

    { id := Req.EP_GRAPH_STATE
      description := "Immutable graph snapshots in an ordered history."
      leanModule := "EvolutionProtocol.Graph.ExchangeGraph"
      leanDecl := "State" },

    { id := Req.EP_SCOPE_EXCLUSIONS
      description := "Explicit exclusions: EP does not specify explanation/interpretation/causal/normative content."
      leanModule := "EvolutionProtocol"
      leanDecl := "EP_Scope_Exclusions" }
  ]

/-- Lookup a traceability entry by identifier. -/
def lookup (rid : ReqId) : Option Entry :=
  entries.find? (fun e => e.id = rid)

end EvolutionProtocol.Spec
