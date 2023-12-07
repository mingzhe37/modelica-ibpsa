within IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.BaseClasses;
partial model PartialChillerCycle
  "Partial model of refrigerant cycle used for chiller applications"
  extends
    IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialRefrigerantCycle;
  parameter Boolean useInChi
    "=false to indicate that this model is used as a heat pump";
  IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.CalculateCOP
    calEER(PEleMin=PEle_nominal*0.1)  if calEff
                                      "Calculate the EER"
    annotation (Placement(transformation(extent={{-80,-80},{-100,-100}})));
equation
  connect(iceFacCal.iceFac, sigBus.iceFacChiMea) annotation (Line(points={{-81.2,-50},
          {-72,-50},{-72,-30},{-110,-30},{-110,120},{1,120}},      color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(calEER.COP, sigBus.EER) annotation (Line(points={{-101,-90},{-110,-90},{
          -110,120},{1,120}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(calEER.QUse_flow, proRedQEva.y) annotation (Line(points={{-78,-94},{-60,
          -94},{-60,-108},{-30,-108},{-30,-101}},
                                               color={0,0,127}));
  annotation (Documentation(
  info="<html>
<p>
  Partial refrigerant cycle model for chillers.
  It adds the specification for frosting calculation
  and restricts to the intended choices under
  <code>choicesAllMatching</code>.</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    Adapted based on IBPSA implementation (see issue <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
  <li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
</ul>
</html>"));
end PartialChillerCycle;
