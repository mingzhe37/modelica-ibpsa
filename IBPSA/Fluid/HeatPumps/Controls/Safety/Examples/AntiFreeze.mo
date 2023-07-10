within IBPSA.Fluid.HeatPumps.Controls.Safety.Examples;
model AntiFreeze "Example for usage of anti freeze model"
  extends BaseClasses.PartialSafetyControlExample;
  extends Modelica.Icons.Example;
  IBPSA.Fluid.HeatPumps.Controls.Safety.AntiFreeze antFre
    "Safety control for anti freezing"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Pulse ySetPul(amplitude=1, period=50)
    "Pulse signal for ySet"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Pulse TConInEmu(
    amplitude=-10,
    period=20,
    offset=283.15) "Emulator for condenser inlet temperature"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Pulse TEvaOutEmu(
    amplitude=-10,
    period=15,
    offset=283.15) "Emulator for evaporator outlet temperature"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(antFre.sigBus, sigBus) annotation (Line(
      points={{-2.5,2.9},{-50,2.9},{-50,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ySetPul.y, antFre.ySet) annotation (Line(points={{-79,30},{-8,30},{-8,
          12},{-3.6,12}}, color={0,0,127}));
  connect(TEvaOutEmu.y, sigBus.TEvaOutMea) annotation (Line(points={{-79,-50},{
          -76,-50},{-76,-52},{-50,-52}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TConInEmu.y, sigBus.TConInMea) annotation (Line(points={{-79,-10},{
          -50,-10},{-50,-52}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hys.u, antFre.yOut) annotation (Line(points={{22,-50},{44,-50},{44,12},
          {23,12}}, color={0,0,127}));
  connect(antFre.yOut, yOut) annotation (Line(points={{23,12},{44,12},{44,-40},
          {110,-40}}, color={0,0,127}));
  connect(ySetPul.y, ySet) annotation (Line(points={{-79,30},{-8,30},{-8,40},{
          110,40}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
  This example shows the usage of the model
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.Controls.Safety.AntiFreeze\">
  IBPSA.Fluid.HeatPumps.Controls.Safety.AntiFreeze</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
  <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
  First implementation (see issue <a href=
  \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
</li>
</ul>
</html>"), experiment(
      StopTime=100,
      Interval=1));
end AntiFreeze;
