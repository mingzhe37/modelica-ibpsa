within IBPSA.Fluid.HeatPumps.BaseClasses;
model BlackBoxVapourCompressionCycle
  "Blackbox model of refrigerant cycle of a heat pump"
  extends
    IBPSA.Fluid.HeatPumps.BaseClasses.PartialBlackBoxVapourCompressionCycle;
  // Setting all values to zero avoids errors when checking this model.
  // The values are correctly propagated by the heat pump / chiller model anyway
  replaceable model BlackBoxHeatPumpHeating =
      IBPSA.Fluid.HeatPumps.BlackBoxData.BaseClasses.PartialHeatPumpBlackBox (
      QUse_flow_nominal=0,
      QUseBlaBox_flow_nominal=0,
      scaFac=0,
      TCon_nominal=0,
      TEva_nominal=0,
      dTCon_nominal=0,
      dTEva_nominal=0,
      mCon_flow_nominal=1,
      mEva_flow_nominal=1,
      y_nominal=0)
     constrainedby
    IBPSA.Fluid.HeatPumps.BlackBoxData.BaseClasses.PartialHeatPumpBlackBox
    "Replaceable model for black-box data of a heat pump in main operation mode"
    annotation (choicesAllMatching=true);

  replaceable model BlackBoxHeatPumpCooling =
      IBPSA.Fluid.Chillers.BlackBoxData.BaseClasses.NoCooling
      constrainedby
    IBPSA.Fluid.Chillers.BlackBoxData.BaseClasses.PartialChillerBlackBox
    "Replaceable model for black-box data of 
    a heat pump in reversible operation mode"
    annotation (Dialog(enable=use_rev),choicesAllMatching=true);

  BlackBoxHeatPumpHeating blaBoxHeaPumHea
  annotation (Placement(transformation(extent={{60,40},{20,80}},rotation=0)));
  BlackBoxHeatPumpCooling blaBoxHeaPumCoo if use_rev
  annotation (Placement(transformation(extent={{-19,40},{-60,80}}, rotation=0)));
  Modelica.Blocks.Math.Gain gainEva(final k=-1)
    "Negate QEva to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-32,8})));
  Modelica.Blocks.Math.Gain gainCon(final k=-1) if use_rev
    "Negate QCon to match definition of heat flow direction" annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={30,-8})));
protected
  Utilities.IO.Strings.StringPassThrough strPasThr
    "String pass through to enable conditional string data";
  Utilities.IO.Strings.ConstStringSource conStrSou(
    final k=blaBoxHeaPumHea.datSou) if not use_rev
    "Constant String data source";
initial equation
  assert(
    strPasThr.y == blaBoxHeaPumHea.datSou,
    "Data sources for reversible operation are not equal! 
    Only continue if this is intended",
    AssertionLevel.warning);
equation
  connect(conStrSou.y, strPasThr.u);
  connect(blaBoxHeaPumCoo.datSouOut,  strPasThr.u);
  connect(blaBoxHeaPumHea.QCon_flow, swiQCon.u1)
    annotation (Line(points={{56,38},{56,8},{58,8}}, color={0,0,127}));
  connect(blaBoxHeaPumHea.PEle, swiPEle.u1) annotation (Line(points={{40,38},{
          40,30},{86,30},{86,-52},{8,-52},{8,-58}}, color={0,0,127}));
  connect(blaBoxHeaPumCoo.PEle, swiPEle.u3) annotation (Line(
      points={{-39.5,38},{-40,38},{-40,30},{-90,30},{-90,-50},{-8,-50},{-8,-58}},

      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(blaBoxHeaPumCoo.QEva_flow, swiQEva.u3) annotation (Line(
      points={{-55.9,38},{-56,38},{-56,24},{-52,24},{-52,-8},{-58,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constZero.y, swiPEle.u3) annotation (Line(points={{-59,-70},{-40,-70},
          {-40,-50},{-8,-50},{-8,-58}}, color={0,0,127}));
  connect(constZero.y, swiQEva.u3) annotation (Line(
      points={{-59,-70},{-52,-70},{-52,-8},{-58,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constZero.y, swiQCon.u3) annotation (Line(
      points={{-59,-70},{-20,-70},{-20,-20},{50,-20},{50,-8},{58,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gainEva.y, swiQEva.u1)
    annotation (Line(points={{-40.8,8},{-58,8}}, color={0,0,127}));
  connect(swiQCon.u3, gainCon.y) annotation (Line(
      points={{58,-8},{38.8,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(blaBoxHeaPumCoo.QCon_flow, gainCon.u) annotation (Line(
      points={{-23.1,38},{-24,38},{-24,32},{10,32},{10,-8},{20.4,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(blaBoxHeaPumHea.QEva_flow, gainEva.u) annotation (Line(points={{24,38},
          {24,8},{-22.4,8}},                color={0,0,127}));
  connect(sigBus, blaBoxHeaPumCoo.sigBus) annotation (Line(
      points={{0,102},{0,90},{-40,90},{-40,86},{-39.705,86},{-39.705,80.8}},
      color={255,204,51},
      thickness=0.5));
  connect(sigBus, blaBoxHeaPumHea.sigBus) annotation (Line(
      points={{0,102},{0,90},{39.8,90},{39.8,80.8}},
      color={255,204,51},
      thickness=0.5));
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
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">AixLib #715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">AixLib #577</a>)
  </li>
</ul>
</html>", info="<html>
<p>This black-box model represents the refrigerant cycle of a heat pump. </p>
<p>Used in IBPSA.Fluid.HeatPumps.HeatPump, this model serves the simulation of a reversible heat pump. </p>
<p>Thus, data both of chillers and heat pumps can be used to calculate the three relevant values <code>PEle</code>, <code>QCon</code> and <code>QEva</code>. </p>
<p>The <code>mode</code> of the heat pump is used to switch between the black-box data of the chiller and the heat pump. </p>
<p>The user can choose between different types of black-box data or implement a new black-box model by extending from the <a href=\"modelica://IBPSA.Fluid.HeatPumps.BlackBoxData.BaseClasses.PartialBlackBox\">IBPSA.Fluid.HeatPumps.BlackBoxData.BaseClasses.PartialBlackBox</a> model. </p>
</html>"));
end BlackBoxVapourCompressionCycle;