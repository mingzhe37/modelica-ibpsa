within IBPSA.Fluid.HeatPumps.SafetyControls.BaseClasses;
block BoundaryMap
"Block which returns false if the input parameters 
  are out of the given charasteristic map"
  extends IBPSA.Fluid.HeatPumps.SafetyControls.BaseClasses.BoundaryMapIcon(
      final icoMin=-70, final icoMax=70);
parameter Real dx
"Delta value used for both upper and lower hysteresis. 
  Used to avoid state events when used as a safety control"
  annotation (Dialog(tab="Safety Control", group="Operational Envelope"));
Modelica.Blocks.Interfaces.BooleanOutput noErr
  "If an error occurs, this will be false"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));
Modelica.Blocks.Interfaces.RealInput x "Current value of x-Axis"
  annotation (Placement(transformation(extent={{-128,46},{-100,74}})));
Modelica.Blocks.Interfaces.RealInput y "Current value on y-Axis"
  annotation (Placement(transformation(extent={{-128,-74},{-100,-46}})));

  Modelica.Blocks.Tables.CombiTable1Ds uppTab(
    final table=tabUpp_internal,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final tableOnFile=false)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
Modelica.Blocks.MathBoolean.Nor
                           nor1(
                               nu=3)
  annotation (Placement(transformation(extent={{60,-10},{80,10}})));
IBPSA.Utilities.Logical.DynamicHysteresis lesUpp(final pre_y_start=false)
  annotation (Placement(transformation(extent={{20,60},{40,80}})));
Modelica.Blocks.Logical.Hysteresis
                             hysLef(
    final uLow=-0.05,
    final uHigh=0,
    pre_y_start=false) "Hysteresis for left side of envelope"
  annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
Modelica.Blocks.Logical.Hysteresis hysRig(
    final uLow=-0.05,
    final uHigh=0,
    pre_y_start=false) "Hysteresis for right side of envelope"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
Modelica.Blocks.Sources.Constant conXMin(k=xMin)
  annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
Modelica.Blocks.Sources.Constant conXMax(k=xMax)
  annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));

Modelica.Blocks.Math.Add addUpp(final k1=+1,
                                final k2=-1) "Bounday minus dx"
  annotation (Placement(transformation(extent={{-20,40},{0,60}})));
Modelica.Blocks.Sources.Constant constDx(final k=dx)
  annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  Modelica.Blocks.Math.Add addMax(final k1=+1, final k2=-1) "x minus xMax"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Math.Add addMin(final k1=-1, final k2=+1) "xMin minus x"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
connect(x, uppTab.u) annotation (Line(points={{-114,60},{-70,60},{-70,70},
        {-62, 70}}, color={0,0,127}));
connect(nor1.y, noErr)
  annotation (Line(points={{81.5,0},{110,0}}, color={255,0,255}));
connect(lesUpp.y, nor1.u[1]) annotation (Line(points={{41,70},{50,70},
      {50,-2.33333}, {60,-2.33333}}, color={255,0,255}));
connect(hysLef.y, nor1.u[2]) annotation (Line(points={{41,-30},{50,-30},
      {50,0}, {60,0}}, color={255,0,255}));
  connect(hysRig.y, nor1.u[3]) annotation (Line(points={{41,-70},{50,-70},{50,
          2.33333},{60,2.33333}}, color={255,0,255}));
connect(y, lesUpp.u) annotation (Line(points={{-114,-60},{-90,-60},{-90,94},
      {12, 94},{12,70},{18,70}}, color={0,0,127}));
connect(uppTab.y[1], lesUpp.uHigh) annotation (Line(points={{-39,70},{8,70},
      {8,52},{33,52},{33,58}}, color={0,0,127}));
connect(lesUpp.uLow, addUpp.y) annotation (Line(points={{25,58},{24,58},
      {24,50}, {1,50}}, color={0,0,127}));
connect(uppTab.y[1], addUpp.u1) annotation (Line(points={{-39,70},{-34,70},
      {-34, 56},{-22,56}}, color={0,0,127}));
connect(addUpp.u2, constDx.y) annotation (Line(points={{-22,44},{-34,44},{
        -34,30},{-39,30}}, color={0,0,127}));
  connect(addMax.u2, conXMax.y) annotation (Line(points={{-22,-76},{-32,-76},{
          -32,-90},{-39,-90}}, color={0,0,127}));
  connect(addMin.u2, conXMin.y) annotation (Line(points={{-22,-36},{-32,-36},{
          -32,-50},{-39,-50}}, color={0,0,127}));
  connect(addMax.y, hysRig.u)
    annotation (Line(points={{1,-70},{18,-70}}, color={0,0,127}));
  connect(addMin.y, hysLef.u)
    annotation (Line(points={{1,-30},{18,-30}}, color={0,0,127}));
  connect(x, addMin.u1) annotation (Line(points={{-114,60},{-70,60},{-70,-24},{
          -22,-24}}, color={0,0,127}));
  connect(x, addMax.u1) annotation (Line(points={{-114,60},{-70,60},{-70,-70},{
          -32,-70},{-32,-64},{-22,-64}}, color={0,0,127}));
annotation (Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
  Documentation(info="<html>
    <p>Given an input of the x and y-Axis, the block returns true if the given 
    point is outside of the given envelope. </p>
    <p>The maximal and minmal y-value depend on the x-Value and are defined 
    by the upper and lower boundaries in form of 1Ds-Tables. 
    The maximal and minimal x-values are obtained trough the 
    table and are constant. </p>
    <p>For the boundaries of the y-input value, a dynamic hysteresis is used 
    to ensure a used device will stay off a certain time after shutdown.</p>
</html>",
        revisions="<html>
<ul>
  <li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    Adjusted based on IPBSA guidelines <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
  <li>
    <i>November 26, 2018;</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue 
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">AixLib #577</a>) 
  </li>
</ul>
</html>"));
end BoundaryMap;
