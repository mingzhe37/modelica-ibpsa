within IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNom2D.EN14511;
record Ochsner_GMLW_19 "Ochsner GMLW 19"
  extends
    IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNom2D.HeatPumpBaseDataDefinition(
    tablePel=[0,-10,2,7; 35,4300,4400,4600; 50,6300,6400,6600],
    tableQCon_flow=[0,-10,2,7; 35,11600,17000,20200; 50,10200,15600,18800],
    mCon_flow_nominal=20200/4180/5,
    mEva_flow_nominal=1,
    tableUppBou=[-15,55; 40,55]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(revisions="<html><ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to IBPSA.
  </li>
</ul>
</html>", info="<html>
<p>
  According to data from Ochsner data sheets; EN14511
</p>
</html>"));
end Ochsner_GMLW_19;