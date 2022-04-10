within IBPSA.Utilities.IO.Files.BaseClasses;
class WeeklyScheduleObject "Class that loads a weekly schedule"
extends ExternalObject;
  impure function constructor
    "Verify whether a file writer with  the same path exists and cache variable keys"
    extends Modelica.Icons.Function;
    input Boolean tableOnFile "Table is on file";
    input String sourceName "Data source";
    input Real t_offset "";
    input String data "Data, when tableOnFile=false";
    output WeeklyScheduleObject weeklySchedule "Pointer to the weekly schedule";
    external"C" weeklySchedule = weeklyScheduleInit(tableOnFile, sourceName, t_offset, data)
    annotation (
      Include="#include <WeeklySchedule.c>",
      IncludeDirectory="modelica://IBPSA/Resources/C-Sources");

    annotation(Documentation(info="<html>
<p>
Object for storing weekly schedules.
</p>
</html>", revisions="<html>
<ul>
 <li>
 March 9 2022, by Filip Jorissen:<br/>
 First implementation.
 </li>
 </ul>
</html>"));
  end constructor;

  pure function destructor "Release storage and close the external object, write data if needed"
    input WeeklyScheduleObject weeklySchedule "Pointer to file writer object";
    external "C" weeklyScheduleFree(weeklySchedule)
    annotation(Include=" #include <WeeklySchedule.c>",
    IncludeDirectory="modelica://IBPSA/Resources/C-Sources");
  annotation(Documentation(info="<html>
</html>"));
  end destructor;

annotation(Documentation(info="<html>
</html>",
revisions="<html>
<ul>
<li>
April 10 2022, by Filip Jorissen:<br/>
Added parameter source implementation.
</li>
<li>
March 9 2022, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeeklyScheduleObject;
