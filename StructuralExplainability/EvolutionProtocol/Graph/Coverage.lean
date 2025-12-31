import StructuralExplainability.EvolutionProtocol.Graph.EvolutionGraph
import StructuralExplainability.EvolutionProtocol.Graph.TypedGraph

namespace StructuralExplainability.EvolutionProtocol.Graph

/-
Coverage lemmas for EvolutionGraph.

Goal: provide small, reusable facts that downstream theorems can rely on:
- if graph is WellFormed and an edge exists, endpoints are in vertices
- if DependsPath holds, endpoints are in vertices (under WellFormed)
-/

theorem edge_src_in_vertices
  (g : EvolutionGraph)
  (hWf : TypedGraph.WellFormed g)
  (e : Edge EvolutionId EvolutionEdgeLabel)
  (he : e ∈ g.edges)
  : e.src ∈ g.vertices := by
  exact hWf.left e he

theorem edge_dst_in_vertices
  (g : EvolutionGraph)
  (hWf : TypedGraph.WellFormed g)
  (e : Edge EvolutionId EvolutionEdgeLabel)
  (he : e ∈ g.edges)
  : e.dst ∈ g.vertices := by
  exact hWf.right e he

theorem dependency_endpoints_in_vertices
  (g : EvolutionGraph)
  (hWf : TypedGraph.WellFormed g)
  (a b : EvolutionId)
  (hDep : HasDependency g a b)
  : a ∈ g.vertices ∧ b ∈ g.vertices := by
  unfold HasDependency at hDep
  unfold TypedGraph.HasEdge at hDep
  have he : Edge.mk a b EvolutionEdgeLabel.dependsOn ∈ g.edges := hDep
  constructor
  · exact edge_src_in_vertices g hWf (Edge.mk a b EvolutionEdgeLabel.dependsOn) he
  · exact edge_dst_in_vertices g hWf (Edge.mk a b EvolutionEdgeLabel.dependsOn) he

theorem dependsPath_endpoints_in_vertices
  (g : EvolutionGraph)
  (hWf : TypedGraph.WellFormed g)
  (a b : EvolutionId)
  (hp : DependsPath g a b)
  : a ∈ g.vertices ∧ b ∈ g.vertices := by
  induction hp with
  | step a b hDep =>
      exact dependency_endpoints_in_vertices g hWf a b hDep
  | trans a b c hab hbc ih1 ih2 =>
      exact And.intro ih1.left ih2.right

end StructuralExplainability.EvolutionProtocol.Graph
