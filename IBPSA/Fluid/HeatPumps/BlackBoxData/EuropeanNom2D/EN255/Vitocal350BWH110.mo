within IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNom2D.EN255;
record Vitocal350BWH110 "Vitocal 350 BWH 110"
  extends
    IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNom2D.HeatPumpBaseDataDefinition(
    tablePel=[0,-5.0,0.0,5.0,10.0,15.0; 35,2478,2522,2609,2696,2783; 45,3608,
        3652,3696,3739,3783; 55,4217,4261,4304,4348,4391; 65,5087,5130,5174,
        5217,5261],
    tableQCon_flow=[0,-5.0,0.0,5.0,10.0,15.0; 35,9522,11000,12520,14000,15520;
        45,11610,12740,13910,15090,16220; 55,11610,12740,13910,15090,16220; 65,
        11610,12740,13910,15090,16220],
    mCon_flow_nominal=11000/4180/10,
    mEva_flow_nominal=8400/3600/3,
    tableUppBou=[-5,55; 25,55]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  Data from manufacturer's data sheet (Viessmann). These exact curves
  are given in the data sheet for measurement procedure according to EN
  255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to IBPSA.
  </li>
</ul>
</html>"));
end Vitocal350BWH110;
