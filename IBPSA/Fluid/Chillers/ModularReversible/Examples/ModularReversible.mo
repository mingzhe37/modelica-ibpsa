within IBPSA.Fluid.Chillers.ModularReversible.Examples;
model ModularReversible
  "Test model for chiller based on ModularReversible approach"
  extends Modelica.Icons.Example;
  package MediumCon = IBPSA.Media.Water "Medium model";
  package MediumEva = IBPSA.Media.Water "Medium model";

  IBPSA.Fluid.Chillers.ModularReversible.ModularReversible modRevChi(
    redeclare package MediumCon = MediumCon,
    redeclare package MediumEva = MediumEva,
    QUse_flow_nominal=30000,
    y_nominal=1,
    redeclare model RefrigerantCycleInertia =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.VariableOrder
        (
        refIneFreConst=1/300,
        nthOrd=1,
        initType=Modelica.Blocks.Types.Init.InitialState),
    redeclare IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar(
        minLocTime=100,
        use_opeEnv=false),
    TCon_nominal=313.15,
    dpCon_nominal(displayUnit="Pa") = 6000,
    use_conCap=false,
    CCon=0,
    GConOut=0,
    GConIns=0,
    cpCon=4184,
    TEva_nominal=278.15,
    dTEva_nominal=5,
    dTCon_nominal=5,
    dpEva_nominal(displayUnit="Pa") = 6000,
    use_evaCap=false,
    CEva=0,
    GEvaOut=0,
    GEvaIns=0,
    cpEva=4184,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    show_T=true,
    redeclare model RefrigerantCycleChillerCooling =
        IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.ConstantQualityGrade
        (
        datSou="Override to avoid warnings during simulation for CI",
        useAirForCon=modRevChi.cpCon < 1500,
        useAirForEva=modRevChi.cpEva < 1500,
        quaGra=0.35),
    redeclare model RefrigerantCycleChillerHeating =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.EuropeanNorm2D (redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal, datTab=
            IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255.Vitocal350BWH110(
             devIde="Override to avoid warnings during simulation for CI")))
                 "Modular reversible chiller instance"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  IBPSA.Fluid.Sources.MassFlowSource_T souCon(
    nPorts=1,
    redeclare package Medium = MediumCon,
    use_T_in=true,
    m_flow=modRevChi.mCon_flow_nominal,
    T=298.15) "Condenser source"
    annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
  IBPSA.Fluid.Sources.MassFlowSource_T souEva(
    nPorts=1,
    redeclare package Medium = MediumEva,
    use_T_in=true,
    m_flow=modRevChi.mEva_flow_nominal,
    T=291.15) "Evaporator source"
    annotation (Placement(transformation(extent={{60,-6},{40,14}})));
  IBPSA.Fluid.Sources.Boundary_pT sinCon(nPorts=1, redeclare package Medium =
        MediumCon) "Condenser sink" annotation (Placement(transformation(extent={{
            10,-10},{-10,10}}, origin={70,40})));
  IBPSA.Fluid.Sources.Boundary_pT sinEva(nPorts=1, redeclare package Medium =
        MediumEva) "Evaporator sink" annotation (Placement(transformation(extent={
            {-10,-10},{10,10}}, origin={-50,-20})));
  Modelica.Blocks.Sources.SawTooth ySet(
    amplitude=-1,
    period=500,
    offset=1,
    startTime=500)  "Compressor control signal"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Ramp TConIn(
    height=10,
    duration=60,
    offset=273.15 + 30,
    startTime=60) "Condenser inlet temperature"
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Blocks.Sources.Ramp TEvaIn(
    height=10,
    duration=60,
    startTime=900,
    offset=273.15 + 15) "Evaporator inlet temperature"
    annotation (Placement(transformation(extent={{54,-40},{74,-20}})));
  Modelica.Blocks.Sources.BooleanStep chi(startTime=2100, startValue=true)
    "Chilling mode on"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(souCon.ports[1], modRevChi.port_a1) annotation (Line(
      points={{-40,16},{-20,16},{-20,15},{-5.55112e-16,15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(souEva.ports[1], modRevChi.port_a2) annotation (Line(
      points={{40,4},{30,4},{30,5},{20,5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(modRevChi.port_b1, sinCon.ports[1]) annotation (Line(
      points={{20,15},{30,15},{30,40},{60,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinEva.ports[1], modRevChi.port_b2) annotation (Line(
      points={{-40,-20},{-10,-20},{-10,5},{-5.55112e-16,5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TConIn.y, souCon.T_in) annotation (Line(
      points={{-69,20},{-62,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvaIn.y, souEva.T_in) annotation (Line(
      points={{75,-30},{80,-30},{80,8},{62,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ySet.y, modRevChi.ySet) annotation (Line(points={{-39,60},{-16,60},{
          -16,11.6667},{-1.6,11.6667}},
                                    color={0,0,127}));
  connect(chi.y, modRevChi.coo) annotation (Line(points={{-39,-50},{-22,-50},{-22,
          2.5},{-1.6,2.5}}, color={255,0,255}));
  annotation (experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Chillers/ModularReversible/Examples/ModularReversible.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
  <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
  First implementation (see issue <a href=
  \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
</li>
</ul>
</html>", info="<html>
<p>
  Example that simulates a chiller based on the modular reversible approach
  The chiller control signal is the compressor speed 
  <code>ySet</code> and the mode <code>coo</code>.
</p>
<p>  
  As the model contains internal safety controls, the 
  compressor set speed <code>ySet</code> and actually applied
  speed <code>yOut</code> are plotted to show the influence of 
  the safety control.
</p>
<p>
  The example further demonstrates how to redeclare the replaceable options 
  in the model approach
  <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.ModularReversible\">
  IBPSA.Fluid.Chillers.ModularReversible.ModularReversible</a>.
</p>
</html>"));
end ModularReversible;
