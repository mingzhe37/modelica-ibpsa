within IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record WAMAK_WaterToWater_150kW "150 kW water to water with R134a"
  extends
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericHeatPump(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[268.15,355.15; 318.15,355.15],
    mEva_flow_nominal=24.17/3600*997,
    mCon_flow_nominal=13.60/3600*997,
    tabPEle=[0,278.15, 279.15, 280.15, 281.15, 282.15, 283.15, 284.15, 285.15,
        286.15, 287.15, 288.15, 289.15, 290.15, 291.15, 292.15, 293.15, 294.15,
        295.15, 296.15, 297.15, 298.15, 299.15, 300.15, 301.15, 302.15, 303.15,
        304.15, 305.15, 306.15, 307.15, 308.15, 309.15, 310.15, 311.15, 312.15, 313.15;
      333.15,20150,20230,20300,20370,20430,20500,20560,20620,20670,20730,20780,
        20830,20880,20940,20990,21040,21090,21140,21190,21250,21300,21360,21410,
        21470,21530,21600,21660,21730,21810,21880,21960,22050,
        22130,22230,22320,22420;
      343.15,24450,24570,24670,24770,24870,24960,25050,25130,25210,25290,25360,
        25430,25500,25560,25620,25680,25730,25790,25840,25890,
        25940,25990,26040,26090,26140,26190,26240,26290,26340,26400,26450,26510,26560,
        26620,26690,26750;
      353.15,29460,29620,29780,29940,30080,30220,30350,30470,
        30590,30700,30810,30910,31010,31100,31190,31270,31350,31420,31490,31560,31620,
        31680,31740,31790,31850,31900,31950,32000,32040,32090,32130,32180,32220,32270,
        32310,32360],
    tabQCon_flow=[0,278.15, 279.15, 280.15, 281.15, 282.15, 283.15, 284.15, 285.15,
        286.15, 287.15, 288.15, 289.15, 290.15, 291.15, 292.15, 293.15, 294.15,
        295.15, 296.15, 297.15, 298.15, 299.15, 300.15, 301.15, 302.15, 303.15,
        304.15, 305.15, 306.15, 307.15, 308.15, 309.15, 310.15, 311.15, 312.15, 313.15;
      333.15,58030,59710,61440,63220,65040,66920,
        68860,70850,72900,75020,77190,79440,81750,84120,86570,89100,91700,94380,97130,
        99970,102890,105900,109000,112190,115470,118840,122310,125880,129550,133320,
        137200,141180,145270,149480,153790,158220;
      343.15,56420,57930,59470,61060,62680,
        64350,66060,67820,69640,71500,73410,75390,77420,79500,81660,83870,86150,88500,
        90920,93410,95980,98620,101350,104150,107030,110000,113060,116200,119430,122760,
        126190,129710,133330,137050,140870,144800;
      353.15,55020,56370,57740,59130,60570,
        62030,63530,65070,66650,68270,69930,71640,73400,75210,77070,78990,80960,82990,
        85080,87230,89450,91740,94090,96520,99010,101590,104240,106970,109780,112670,
        115650,118710,121870,125110,128450,131890],
    devIde="WAMAK_WaterToWaterr_150kW",
    use_TConOutForTab=true,
    use_TEvaOutForTab=false);
  annotation (Documentation(info="<html>
<p>Data for large scale (150 kW) water-to-water heat pump from WAMAK with </p>
</html>", revisions="<html>
<ul><li>
  <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
  First implementation (see issue <a href=
  \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
</li></ul>
</html>"));
end WAMAK_WaterToWater_150kW;
