within IBPSA.Fluid.HeatPumps;
model ReversibleAirToWaterEuropeanNorm2D
  "Reversibel air to water heat pump based on 2D manufacturer data in europe"
  extends ModularReversible(
    dTEva_nominal=0,
    mEva_flow_nominal=datTabHea.mEva_flow_nominal*vapComCyc.blaBoxHeaPumHea.scaFac,
    mCon_flow_nominal=datTabHea.mCon_flow_nominal*vapComCyc.blaBoxHeaPumHea.scaFac,
    dTCon_nominal=QUse_flow_nominal/cpCon/mCon_flow_nominal,
    final GEvaIns=0,
    final GEvaOut=0,
    final CEva=0,
    final use_evaCap=false,
    final GConIns=0,
    final GConOut=0,
    final CCon=0,
    final use_conCap=false,
    redeclare model BlackBoxHeatPumpCooling =
        IBPSA.Fluid.Chillers.BlackBoxData.EuropeanNorm2D (redeclare
          IBPSA.Fluid.HeatPumps.BlackBoxData.Frosting.NoFrosting iceFacCal,
          final datTab=datTabCoo),
    final use_TSet=false,
    redeclare model BlackBoxHeatPumpHeating =
        IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNorm2D (redeclare
          IBPSA.Fluid.HeatPumps.BlackBoxData.Frosting.NoFrosting iceFacCal,
          final datTab=datTabHea),
    final use_rev=true,
    redeclare model VapourCompressionCycleInertia =
        IBPSA.Fluid.HeatPumps.BlackBoxData.VapourCompressionInertias.NoInertia);

  replaceable parameter IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNorm2DData.HeatPumpBaseDataDefinition
    datTabHea constrainedby IBPSA.Fluid.HeatPumps.BlackBoxData.EuropeanNorm2DData.HeatPumpBaseDataDefinition
         "Data Table of HP" annotation(choicesAllMatching=true);
  replaceable parameter IBPSA.Fluid.Chillers.BlackBoxData.EuropeanNorm2DData.ChillerBaseDataDefinition
    datTabCoo constrainedby IBPSA.Fluid.Chillers.BlackBoxData.EuropeanNorm2DData.ChillerBaseDataDefinition
     "Data Table of Chiller" annotation(choicesAllMatching=true);
end ReversibleAirToWaterEuropeanNorm2D;