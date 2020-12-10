﻿within IBPSA.Airflow.Multizone;
model Q_Cdp "Powerlaw Volume Flow"

  extends IBPSA.Airflow.Multizone.BaseClasses.PowerLawResistance(m=0.65, final k=C);
  parameter Real C=0.00015 "flow coeffiënt";

     annotation (Icon(graphics={
        Rectangle(
          extent={{-54,34},{48,-34}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,14},{76,-12}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{10,-68},{94,-106}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C=%C"),
        Text(
          extent={{12,-50},{88,-88}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "m=%m"),
        Rectangle(
          extent={{-100,6},{-64,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{48,8},{100,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,4},{-52,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,6},{-52,-6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,102},{42,42}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="Q=C*dp^m")}),
defaultComponentName="lea",
Documentation(info="<html>
<p>This model describes the one-directional pressure driven air flow through an opening, using the equation </p>
<p align=\"center\"><i>V̇ = k &Delta;p<sup>m</sup>, </i></p>
<p>where <i>V̇</i> is the volume flow rate, <i>k</i> is a flow coefficient and <i>m</i> is the flow exponent. </p>
<p>A similar model is also used in the CONTAM software (Dols and Walton, 2015). Dols and Walton (2002) recommend to use for the flow exponent m=0.6 to m=0.7 if the flow exponent is not reported with the test results. </p>
<h4>References</h4>
<ul>
<li><b>ASHRAE, 1997.</b> <i>ASHRAE Fundamentals</i>, American Society of Heating, Refrigeration and Air-Conditioning Engineers, 1997. </li>
<li><b>Dols and Walton, 2002.</b> W. Stuart Dols and George N. Walton, <i>CONTAMW 2.0 User Manual, Multizone Airflow and Contaminant Transport Analysis Software</i>, Building and Fire Research Laboratory, National Institute of Standards and Technology, Tech. Report NISTIR 6921, November, 2002. </li>
<li><b>W. S. Dols and B. J. Polidoro</b>,<b>2015</b>. <i>CONTAM User Guide and Program Documentation Version 3.2</i>, National Institute of Standards and Technology, NIST TN 1887, Sep. 2015. doi: <a href=\"https://doi.org/10.6028/NIST.TN.1887\">10.6028/NIST.TN.1887</a>. </li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
Jun 26, 2020, by Klaas De Jonge:<br/>
First release. Model expecting direct input of volume flow powerlaw coefficients.
</li>
</ul>
</html>"));
end Q_Cdp;
