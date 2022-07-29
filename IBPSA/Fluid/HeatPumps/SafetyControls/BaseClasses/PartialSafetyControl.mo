﻿within IBPSA.Fluid.HeatPumps.SafetyControls.BaseClasses;
partial block PartialSafetyControl "Safety control with I/O"
  Modelica.Blocks.Interfaces.RealInput ySet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-152,4},{-120,36}})));
  Modelica.Blocks.Interfaces.RealOutput yOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  Interfaces.VapourCompressionMachineControlBus                sigBusHP
    "Bus-connector for the heat pump"
    annotation (Placement(transformation(extent={{-146,-84},{-112,-54}})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    "Heat pump mode, =true: heating, =false: chilling"
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of heat pump mode"
    annotation (Placement(transformation(extent={{-152,-36},{-120,-4}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}}),      graphics={
        Polygon(
          points={{-42,20},{0,62},{-42,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-26},{48,66}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-14},{36,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-80}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-30},{10,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-40},{16,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,100},{106,76}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name"),
        Rectangle(
          extent={{-120,120},{120,-120}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}),
                                     Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-120},{120,120}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Partial block for a safety control. Based on the signals in the
  sigBusHP either the input signals are equal to the output signals or,
  if an error occurs, set to 0.
</p>
<p>
  The Output ERR informs about the number of errors in the specific
  safety block.
</p>
</html>"));
end PartialSafetyControl;