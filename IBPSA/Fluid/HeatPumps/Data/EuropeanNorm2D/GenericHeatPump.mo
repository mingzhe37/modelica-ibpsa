within IBPSA.Fluid.HeatPumps.Data.EuropeanNorm2D;
record GenericHeatPump "Basic heat pump data"
  extends IBPSA.Fluid.HeatPumps.Data.EuropeanNorm2D.Generic;
  parameter Real tabQCon_flow[:,:]
    "Heating power table, T in degC, Q_flow in W";
  parameter Real tabUppBou[:,2]
    "Points to define upper boundary for sink temperature";
  parameter Boolean use_TEvaOutForOpeEnv=false
    "=true to use evaporator outlet temperature for operational envelope, false for inlet";
  parameter Boolean use_TConOutForOpeEnv=true
    "=true to use condenser outlet temperature for operational envelope, false for inlet";
  annotation (Documentation(info="<html>
<h4>Overview</h4>
<p>
  Base data definition used in the heat pump model.
</p>
<p>
  Extends <a href=\"modelica://IBPSA.Fluid.HeatPumps.Data.EuropeanNorm2D.Generic\">
  IBPSA.Fluid.HeatPumps.RefrigerantCycle.EuropeanNorm2DData.RefrigerantCycle2DBaseDataDefinition</a> 
  to enable correct selection.</p>
<p>
  Adds the table data for upper temperature limitations to 
  the partial record, which is the operational envelope of the compressor.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    Adjusted based on IPBSA guidelines <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
  <li>
    <i>May 7, 2020</i> by Philipp Mehrfeld:<br/>
    Add description of how to calculate m_flows
  </li>
  <li>
    <i>December 10, 2013</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>
"),Icon);
end GenericHeatPump;
