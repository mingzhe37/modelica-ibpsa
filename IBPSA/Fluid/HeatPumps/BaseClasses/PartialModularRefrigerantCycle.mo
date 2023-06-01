within IBPSA.Fluid.HeatPumps.BaseClasses;
partial model PartialModularRefrigerantCycle
  "Partial refrigerant cycle model"

  parameter Boolean use_rev=true
    "True if the refrigerant machine is reversible";

  IBPSA.Fluid.Interfaces.RefrigerantMachineControlBus sigBus
    "Signal bus with data for refrigerant models" annotation (Placement(
        transformation(extent={{-18,86},{18,118}}), iconTransformation(extent={{
            -16,88},{18,118}})));
  Modelica.Blocks.Sources.Constant constZer(final k=0) if not use_rev
    "If no heating is used, the switches may still be connected"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Interfaces.RealOutput QCon_flow(
    final unit="W", final displayUnit="kW")
    "Heat Flow to condenser"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEva_flow(
    final unit="W", final displayUnit="kW")
    "Heat flow from evaporator"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  Modelica.Blocks.Logical.Switch swiQEva(
    u1(final unit="W", final displayUnit="kW"),
    u3(final unit="W", final displayUnit="kW"),
    y(final unit="W", final displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  Modelica.Blocks.Logical.Switch swiQCon(
    y(final unit="W", final displayUnit="kW"),
    u1(final unit="W", final displayUnit="kW"),
    u3(final unit="W", final displayUnit="kW"))
    "If mode is false, Condenser becomes Evaporator and vice versa"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealOutput PEle(final unit="W", final displayUnit="kW")
    "Electrical power consumed by compressor" annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=-90,
        origin={0.5,-110.5})));

  Modelica.Blocks.Logical.Switch swiPEle(
    u1(final unit="W", final displayUnit="kW"),
    u3(final unit="W", final displayUnit="kW"),
    y(final unit="W", final displayUnit="kW"))
    "Whether to use cooling or heating power consumption" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
protected
  Modelica.Blocks.Routing.BooleanPassThrough pasTrhModSet
    "Pass through to enable assertion for non-reversible device";
equation
  assert(
    use_rev or (use_rev == false and pasTrhModSet.y == true),
    "Can't turn to reversible operation mode on 
    irreversible refrigerant machine",
    level=AssertionLevel.error);

  connect(swiQEva.y, QEva_flow)
    annotation (Line(points={{-81,0},{-110,0}}, color={0,0,127}));
  connect(swiPEle.y, PEle) annotation (Line(points={{-1.9984e-15,-81},{-1.9984e-15,
          -95.75},{0.5,-95.75},{0.5,-110.5}}, color={0,0,127}));
  connect(swiQCon.y, QCon_flow)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,88},{22,44}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{-16,82},{20,74}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-18,52},{20,58}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-98,40},{-60,-28}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{60,40},{98,-28}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,40},{-80,68},{-24,68}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{22,66},{80,66},{80,40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{78,-28},{78,-70}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{78,-70},{62,-70},{20,-70}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,-26},{-80,-68},{-20,-68}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-151,147},{149,107}},
          textColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    Adjusted based on the discussion in this issue <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the refrigerant machine
    partial model (see issue <a href=
    \"https://github.com/RWTH-EBC/IBPSA/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/IBPSA/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Partial modular refrigerant cycle models for data and 
  equation based approaches used in the model 
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.BaseClasses.PartialReversibleRefrigerantMachine\">
  IBPSA.Fluid.HeatPumps.BaseClasses.PartialReversibleRefrigerantMachine</a>.
</p>
<p>
  This partial container only adds outputs and switches 
  both relevant for heat pump and chiller applications.
</p>
<p>
  For more information on the approach, please read the 
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversibleUsersGuide\">
  UsersGuide</a>.
</p>
</html>"));
end PartialModularRefrigerantCycle;
