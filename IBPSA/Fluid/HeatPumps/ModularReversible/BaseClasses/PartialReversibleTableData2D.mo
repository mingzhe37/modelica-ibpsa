within IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses;
partial model PartialReversibleTableData2D
  "Reversible heat pump based on 2D manufacturer data"
  extends IBPSA.Fluid.HeatPumps.ModularReversible.ModularReversible(
    final use_rev=true,
    QCoo_flow_nominal=refCyc.refCycHeaPumCoo.QCooNoSca_flow_nominal*scaFacHea,
    dpEva_nominal=datTabHea.dpEva_nominal*scaFacHea^2,
    dpCon_nominal=datTabHea.dpCon_nominal*scaFacHea^2,
    redeclare replaceable
      IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar constrainedby
      IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Generic(
      final tabUppHea=datTabHea.tabUppBou,
      final tabLowCoo=datTabCoo.tabLowBou,
      final use_TConOutHea=datTabHea.use_TConOutForOpeEnv,
      final use_TEvaOutHea=datTabHea.use_TEvaOutForOpeEnv,
      final use_TConOutCoo=datTabCoo.use_TConOutForOpeEnv,
      final use_TEvaOutCoo=datTabCoo.use_TEvaOutForOpeEnv),
    dTEva_nominal=(QHea_flow_nominal - PEle_nominal)/cpEva/mEva_flow_nominal,
    mEva_flow_nominal=datTabHea.mEva_flow_nominal*scaFacHea,
    mCon_flow_nominal=datTabHea.mCon_flow_nominal*scaFacHea,
    dTCon_nominal=QHea_flow_nominal/cpCon/mCon_flow_nominal,
    GEvaIns=0,
    GEvaOut=0,
    CEva=0,
    use_evaCap=false,
    GConIns=0,
    GConOut=0,
    CCon=0,
    use_conCap=false,
    redeclare model RefrigerantCycleHeatPumpCooling =
        IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D (
        redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal,
        final mCon_flow_nominal=mCon_flow_nominal,
        final mEva_flow_nominal=mEva_flow_nominal,
        final smoothness=smoothness,
        final extrapolation=extrapolation,
        final datTab=datTabCoo),
    redeclare model RefrigerantCycleHeatPumpHeating =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData2D (
        redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal,
        final mCon_flow_nominal=mCon_flow_nominal,
        final mEva_flow_nominal=mEva_flow_nominal,
        final smoothness=smoothness,
        final extrapolation=extrapolation,
        final datTab=datTabHea),
    redeclare model RefrigerantCycleInertia =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.NoInertia);
  final parameter Real scaFacHea=refCyc.refCycHeaPumHea.scaFac
    "Scaling factor of heat pump";
  final parameter Real scaFacCoo=refCyc.refCycHeaPumCoo.scaFac
    "Scaling factor for cooling mode";

  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericHeatPump datTabHea
    constrainedby
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericHeatPump
    "Data table of heat pump"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{82,-18},{98,-2}})));
  replaceable parameter IBPSA.Fluid.Chillers.ModularReversible.Data.TableData2D.Generic datTabCoo(
      use_TEvaOutForTab=true, use_TConOutForTab=true)
    constrainedby
    IBPSA.Fluid.Chillers.ModularReversible.Data.TableData2D.Generic
    "Data table of chiller"    annotation (choicesAllMatching=true,
    Placement(transformation(extent={{114,-18},{130,-2}})));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation" annotation (Dialog(tab="Advanced"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation of data outside the definition range"
    annotation (Dialog(tab="Advanced"));
initial algorithm
  assert(use_rev and ((scaFacHea - scaFacCoo) / scaFacHea * 100 < limWarDifSca),
    "In " + getInstanceName() + ": Scaling factors for heating and cooling 
    operation differ by " + String((scaFacHea - scaFacCoo) / scaFacHea * 100) +
    " %. The simulated nominal heating and cooling 
    capacities may not be realistic for a single device",
    AssertionLevel.warning);

  annotation (Documentation(info="<html>
<p>
  Heat pump based on
  two-dimensional data from manufacturer data, (e.g. based on EN 14511),
  using the
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.ModularReversible\">
  IBPSA.Fluid.HeatPumps.ModularReversible.ModularReversible</a> approach.
</p>
<p>
  For more information on the approach, see
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.UsersGuide\">
  IBPSA.Fluid.HeatPumps.ModularReversible.UsersGuide</a>.
</p>
<p>
  Internal inertias and heat losses are typically neglected,
  as these are implicitly obtained in measured
  data from manufacturers.
  Also, icing is disabled as the performance degradation
  is already contained in the data.
</p>
<p>
Please read the documentation of the model for heating at
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData2D\">
  IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData2D</a>.
</p>
<p>
For cooling, the assumptions are similar, and described at
  <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D\">
  IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D</a>
</p>
<h4>References</h4>
<p>
EN 14511-2018: Air conditioners, liquid chilling packages and heat pumps for space
heating and cooling and process chillers, with electrically driven compressors
<a href=\"https://www.beuth.de/de/norm/din-en-14511-1/298537524\">
https://www.beuth.de/de/norm/din-en-14511-1/298537524</a>
</p>

</html>"));
end PartialReversibleTableData2D;
