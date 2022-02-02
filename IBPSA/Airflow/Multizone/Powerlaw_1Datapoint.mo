within IBPSA.Airflow.Multizone;
model Powerlaw_1Datapoint
  "Powerlaw with flow coeffient fitted based on flow exponent and 1 datapoint"
  extends IBPSA.Airflow.Multizone.BaseClasses.PartialPowerLawResistance_m_flow(
    final k=C*sqrt(rho_default)); //mass flow form of orifice equation
  parameter Modelica.Units.SI.PressureDifference dP1
      "Pressure difference of test point"
    annotation (Dialog(group="Test data"));
  parameter Modelica.Units.SI.MassFlowRate  m1_flow
      "Mass flow rate of test point"
    annotation (Dialog(group="Test data"));

protected
  parameter Real C = m1_flow/(sqrt(rho_default)*(dP1^m)) "Flow coeffient";

     annotation (
    Icon(graphics={
        Rectangle(
          extent={{-52,34},{50,-34}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,14},{78,-12}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,6},{-62,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,8},{102,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,4},{-50,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-86,6},{-50,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid)}),
    defaultComponentName="powlaw_1dat",
    Documentation(info="<html>
<p>Model that fits the flow coefficient of the massflow version of the
orifice equation based on 1 measured datapoint and given flow exponent.
</p>
<p>
A similar model is also used in the CONTAM software (Dols and Walton, 2015).
</p>
<p>
<b>References</b>
</p>
<ul>
<li>
<b>W. S. Dols and B. J. Polidoro</b>,<b>2015</b>. <i>CONTAM User Guide and Program Documentation Version 3.2</i>,
National Institute of Standards and Technology, NIST TN 1887, Sep. 2015. doi: <a href=\"https://doi.org/10.6028/NIST.TN.1887\">10.6028/NIST.TN.1887</a>.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>Apr 6, 2021, 2020, by Klaas De Jonge (UGent):<br/>
First implementation</li>
</ul>
</html>
"));
end Powerlaw_1Datapoint;
