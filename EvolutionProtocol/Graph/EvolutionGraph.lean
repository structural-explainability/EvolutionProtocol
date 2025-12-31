import EvolutionProtocol.Core.Base.Ids
import EvolutionProtocol.Graph.TypedGraph

namespace EvolutionProtocol.Graph

/-!
Evolution graph specialization.
-/

abbrev EvolutionId :=
  EvolutionProtocol.Core.Base.EvolutionId

/-- The edge labels we care about for EP proofs. Extend as needed. -/
inductive EvolutionEdgeLabel where
  | dependsOn
  | derivedFrom
  | revises
  deriving Repr, BEq, DecidableEq

/-- An evolution graph is just a typed graph over EvolutionId. -/
abbrev EvolutionGraph :=
  TypedGraph EvolutionId EvolutionEdgeLabel

/-- Convenience predicate. -/
def HasDependency (g : EvolutionGraph) (upstream downstream : EvolutionId) : Prop :=
  TypedGraph.HasEdge g upstream downstream EvolutionEdgeLabel.dependsOn

/-
Reachability (downstream closure) for dependency edges only.
-/
inductive DependsPath (g : EvolutionGraph) : EvolutionId -> EvolutionId -> Prop where
  | step :
      ∀ a b,
        HasDependency g a b ->
        DependsPath g a b
  | trans :
      ∀ a b c,
        DependsPath g a b ->
        DependsPath g b c ->
        DependsPath g a c

/-- Acyclicity is a property, not assumed. -/
def Acyclic (g : EvolutionGraph) : Prop :=
  ∀ x, ¬ DependsPath g x x

end EvolutionProtocol.Graph
