within IBPSA.Fluid.HeatPumps.BlackBoxData.BaseClasses;
partial model PartialHeatPumpBlackBox
  extends PartialBlackBox;
equation
  connect(iceFacCalc.iceFac, sigBus.icefacHPMea) annotation (Line(points={{-79,
          -42},{-72,-42},{-72,-28},{-102,-28},{-102,104},{1,104}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end PartialHeatPumpBlackBox;
