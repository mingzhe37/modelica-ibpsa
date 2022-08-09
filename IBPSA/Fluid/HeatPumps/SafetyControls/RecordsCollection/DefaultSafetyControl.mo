﻿within IBPSA.Fluid.HeatPumps.SafetyControls.RecordsCollection;
record DefaultSafetyControl
  "Apply the default values according to the conference publication by Wüllhorst et. al."
  extends HeatPumpSafetyControlBaseDataDefinition(
    m_flowConMinPer=0.1,
    m_flowEvaMinPer=0.1,
    use_minFlowCtrl=true,
    use_deFro=false,
    use_runPerHou=true,
    use_minLocTime=true,
    use_minRunTime=true,
    TantFre=273.15,
    use_antFre=false,
    calcPel_deFro=0,
    use_chiller=true,
    deltaIceFac=0.1,
    minIceFac=0.5,
    dTHystOperEnv=5,
    dataTable=
        IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNom2D.EN14511.Vitocal200AWO201(),
    use_opeEnvFroRec=false,
    use_opeEnv=true,
    tableUpp=[-40,70; 40,70],
    maxRunPerHou=3,
    minLocTime=1200,
    minRunTime=600);
  annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Default&nbsp;values&nbsp;according&nbsp;to&nbsp;the&nbsp;conference&nbsp;publication&nbsp;by&nbsp;W&uuml;llhorst&nbsp;et.&nbsp;al.</span></p>
</html>"));
end DefaultSafetyControl;
