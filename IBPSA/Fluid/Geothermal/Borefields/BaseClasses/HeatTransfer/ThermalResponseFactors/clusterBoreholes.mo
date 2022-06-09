within IBPSA.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors;
function clusterBoreholes
  "Identify clusters of boreholes with similar heat interactions"
  extends Modelica.Icons.Function;

  input Integer nBor "Number of boreholes";
  input Modelica.Units.SI.Position cooBor[nBor, 2] "Coordinates of boreholes";
  input Modelica.Units.SI.Height hBor "Borehole length";
  input Modelica.Units.SI.Height dBor "Borehole buried depth";
  input Modelica.Units.SI.Radius rBor "Borehole radius";
  input Integer n_clusters "Number of clusters to be generated";
  input Real TTol = 0.001 "Absolute tolerance on the borehole wall temperature for the identification of clusters";

  output Integer labels[nBor] "Cluster label associated with each data point";
  output Integer cluster_size[n_clusters] "Size of the clusters";
  output Integer N "Number of unique clusters";

protected
  Real TBor[nBor,1] "Steady-state borehole wall temperatures";
  Real TBor_Unique[nBor] "Unique borehole wall temperatures under tolerance";
  Real dis "Distance between boreholes";

algorithm
  // ---- Evaluate borehole wall temperatures
  for i in 1:nBor loop
    TBor[i,1] := 0;
    for j in 1:nBor loop
      if i <> j then
        dis := sqrt((cooBor[i,1]-cooBor[j,1])^2 + (cooBor[i,2]-cooBor[j,2])^2);
      else
        dis := rBor;
      end if;
      TBor[i,1] := TBor[i,1] + IBPSA.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_SteadyState(dis, hBor, dBor, hBor, dBor);
    end for;
  end for;

  // ---- Find all unique borehole wall temperatures under tolerance
  // The number of clusters is min(N, n_clusters)
  N := 1;
  TBor_Unique[1] := TBor[1,1];
  if n_clusters > 1 and nBor > 1 then
    for i in 2:nBor loop
      for j in 1:N loop
        if abs(TBor[i,1] - TBor_Unique[j]) < TTol then
          break;
        elseif j == N then
          TBor_Unique[N+1] := TBor[i,1];
          N := N + 1;
        end if;
      end for;
    end for;
  end if;
  N := min(N, n_clusters);

  // ---- Identify borehole clusters
  (,labels,cluster_size[1:N]) := IBPSA.Utilities.Clustering.KMeans(
    TBor,
    N,
    nBor,
    1);

annotation (
Inline=true,
Documentation(info="<html>
<p>
This function identifies groups of similarly behaving boreholes using a
<i>k</i>-means clustering algorithm. Boreholes are clustered based on their
steady-state dimensionless borehole wall temperatures obtained from the spatial
superposition of the steady-state finite line source solution (see
<a href=\"modelica://IBPSA.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_SteadyState\">
IBPSA.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_SteadyState</a>).
</p>
<h4>Implementation</h4>
<p>
The implemented method differs from the method presented by Prieto and Cimmino
(2021). They used a hierarchical agglomerative clustering method with complete
linkage to identify the borehole clusters. The <i>optimal</i> number of clusters
was identified by cutting the dendrogram generated during the clustering
process.
</p>
<p>
Here, a <i>k</i>-means algorithm is used instead, using the euclidian distance
between steady-state borehole wall temperatures. The number of clusters is a
parameter in this approach. However, as observed by Prieto and Cimmino (2021),
<code>n_clusters=5</code> clusters should provide acceptable accuracy in most
practical cases. This number can be increased without significant change in the
computational cost.
</p>
<h4>References</h4>
<p>
Prieto, C. and Cimmino, M. 2021. <i>Thermal interactions in large irregular
fields of geothermal boreholes: the method of equivalent boreholes</i>. Journal
of Building Performance Simulation 14(4): 446-460.
</p>
</html>", revisions="<html>
<ul>
<li>
June 9, 2022 by Massimo Cimmino:<br/>
First implementation.
</li>
</ul>
</html>"));
end clusterBoreholes;
