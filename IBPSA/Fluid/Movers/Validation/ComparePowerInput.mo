within IBPSA.Fluid.Movers.Validation;
model ComparePowerInput
  "Compare power estimation with different input signal"
  extends Modelica.Icons.Example;
  extends IBPSA.Fluid.Movers.Validation.BaseClasses.ComparePower(
    redeclare IBPSA.Fluid.Movers.Data.Fans.Greenheck.BIDW15 per(
      etaMotMet=IBPSA.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.Efficiency_VolumeFlowRate,
      motorEfficiency(V_flow={0}, eta={0.7})),
    mov1(per=per),
    redeclare IBPSA.Fluid.Movers.FlowControlled_dp mov2(
      redeclare final package Medium = Medium,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      per=per,
      addPowerToMedium=false,
      use_inputFilter=false,
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal),
    redeclare IBPSA.Fluid.Movers.FlowControlled_m_flow mov3(
      redeclare final package Medium = Medium,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      per=per,
      addPowerToMedium=false,
      use_inputFilter=false,
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal),
    ramDam(height=-0.5));
  Modelica.Blocks.Sources.RealExpression exp_dp(y=mov1.dpMachine)
    "Expression to impose the same pressure rise"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression exp_m_flow(y=mov1.m_flow)
    "Expression to impose the same mass flow rate"
    annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
equation
  connect(exp_dp.y, mov2.dp_in)
    annotation (Line(points={{-39,0},{-30,0},{-30,-8}}, color={0,0,127}));
  connect(exp_m_flow.y, mov3.m_flow_in)
    annotation (Line(points={{-37,-50},{-30,-50},{-30,-58}}, color={0,0,127}));
  annotation(experiment(Tolerance=1e-6, StopTime=200),
    __Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Movers/Validation/ComparePowerInput.mos"
        "Simulate and plot"));
end ComparePowerInput;
