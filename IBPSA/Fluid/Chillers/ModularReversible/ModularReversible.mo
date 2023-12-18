within IBPSA.Fluid.Chillers.ModularReversible;
model ModularReversible
  "Grey-box model for reversible chillers"
  extends
    IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.PartialReversibleRefrigerantMachine(
    safCtr(redeclare
        IBPSA.Fluid.Chillers.ModularReversible.Controls.Safety.OperationalEnvelope
        opeEnv),
    final PEle_nominal=refCyc.refCycChiCoo.PEle_nominal,
    mEva_flow_nominal=QUse_flow_nominal/(dTEva_nominal*cpEva),
    mCon_flow_nominal=(QUse_flow_nominal + PEle_nominal)/(dTCon_nominal*cpCon),
    final scaFac=refCyc.refCycChiCoo.scaFac,
    use_rev=true,
    redeclare IBPSA.Fluid.Chillers.ModularReversible.BaseClasses.RefrigerantCycle refCyc(
        redeclare model RefrigerantCycleChillerCooling =
          RefrigerantCycleChillerCooling, redeclare model
        RefrigerantCycleChillerHeating = RefrigerantCycleChillerHeating));
  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal=refCyc.refCycChiHea.QUseNoSca_flow_nominal*scaFac
    "Nominal heat flow rate for heating"
      annotation(Dialog(group="Nominal condition", enable=use_rev));

  replaceable model RefrigerantCycleChillerCooling =
      IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.BaseClasses.PartialChillerCycle
    constrainedby
    IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.BaseClasses.PartialChillerCycle(
       final useInChi=true,
       final QUse_flow_nominal=QUse_flow_nominal,
       final TCon_nominal=TCon_nominal,
       final TEva_nominal=TEva_nominal,
       final dTCon_nominal=dTCon_nominal,
       final dTEva_nominal=dTEva_nominal,
       final mCon_flow_nominal=mCon_flow_nominal,
       final mEva_flow_nominal=mEva_flow_nominal,
       final y_nominal=y_nominal)
  "Refrigerant cycle module for the cooling mode"
    annotation (choicesAllMatching=true);

  replaceable model RefrigerantCycleChillerHeating =
      IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.NoHeating
       constrainedby
    IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialHeatPumpCycle(
       final useInHeaPum=false,
       final QUse_flow_nominal=QHea_flow_nominal,
       final scaFac=scaFac,
       final PEle_nominal=refCyc.refCycChiCoo.PEle_nominal,
       final TCon_nominal=TCon_nominal,
       final TEva_nominal=TEva_nominal,
       final dTCon_nominal=dTCon_nominal,
       final dTEva_nominal=dTEva_nominal,
       final mCon_flow_nominal=mCon_flow_nominal,
       final mEva_flow_nominal=mEva_flow_nominal,
       final y_nominal=y_nominal)
  "Refrigerant cycle module for the heating mode"
    annotation (Dialog(enable=use_rev),choicesAllMatching=true);

  Modelica.Blocks.Interfaces.BooleanInput coo if not use_busConOnl and use_rev
    "=true for cooling, =false for heating"
    annotation (Placement(transformation(extent={{-172,-86},{-140,-54}}),
        iconTransformation(extent={{-120,-30},{-102,-12}})));
  Modelica.Blocks.Sources.BooleanConstant conCoo(final k=true)
    if not use_busConOnl and not use_rev
    "Locks the device in cooling mode if designated to be not reversible" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-130})));
equation
  connect(conCoo.y, sigBus.coo)
    annotation (Line(points={{-99,-130},{-84,-130},{-84,-40},{-138,-40},{-138,-42},
          {-140,-42},{-140,-41},{-141,-41}},
                                color={255,0,255}));
  connect(coo, sigBus.coo)
    annotation (Line(points={{-156,-70},{-128,-70},{-128,-40},{-134,-40},{-134,
          -41},{-141,-41}},
                       color={255,0,255}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-88,60},{88,60}}, color={28,108,200})}),
    Diagram(coordinateSystem(extent={{-140,-160},{140,160}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019,</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">AixLib #715</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Model of a reversible, modular chiller.
  This models allows combining any of the available modules
  for refrigerant heating or cooling cycles, inertias,
  heat losses, and safety controls.
  All features are optional.
</p>
<p>
  Adding to the partial model (
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.PartialReversibleRefrigerantMachine\">
  IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.PartialReversibleRefrigerantMachine</a>),
  this model has the <code>coo</code> signal to choose
  the operation mode of the chiller.
</p>
<p>
  For more information, see
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.UsersGuide\">
  IBPSA.Fluid.HeatPumps.ModularReversible.UsersGuide</a>.
</p>
</html>"));
end ModularReversible;
