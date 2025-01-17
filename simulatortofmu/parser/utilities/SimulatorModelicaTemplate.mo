model {{model_name}}
  "Block that.simulators a vector of real values with Simulator"
  extends Modelica.Blocks.Icons.Block;

///////////// THE CODE BELOW HAS BEEN AUTOGENERATED //////////////
  {%- for dict_item in scalar_variables %}
  {%- if (dict_item["causality"]== "parameter" and dict_item["vartype"]== "Real") %}
  parameter {{dict_item["vartype"]}} {{dict_item["name"]}}(unit="{{dict_item["unit"]}}") = {{dict_item["start"]}}
    "{{dict_item["description"]}}";
  {%- elif (dict_item["causality"]== "parameter" and dict_item["vartype"]== "String") %}
  parameter {{dict_item["vartype"]}} {{dict_item["name"]}} = "{{dict_item["start"]}}"
    "{{dict_item["description"]}}";
  {%- elif (dict_item["causality"]== "input" and dict_item["vartype"]== "Real") %}
  Modelica.Blocks.Interfaces.RealInput {{dict_item["name"]}}(start={{dict_item["start"]}}, unit="{{dict_item["unit"]}}")
    "{{dict_item["description"]}}"{{dict_item["annotation"]}};
  {%- elif (dict_item["causality"]== "output" and dict_item["vartype"]== "Real") %}
  Modelica.Blocks.Interfaces.RealOutput {{dict_item["name"]}} (unit="{{dict_item["unit"]}}")
    "{{dict_item["description"]}}"{{dict_item["annotation"]}};
  {%- endif -%}
  {% endfor %}
  // Configuration specific parameters coming from
  // the inputs of the Python export tool (SimulatorToFMU.py)
  parameter String patResScri = Modelica.Utilities.Files.loadResource("{{res_path}}")
    "Path to the script in resource folder";
  // used to generate the FMU
  {%- if exec_target=="python" %}
  //{%- if con_path=="" %}
  // parameter String _configurationFileName = "dummy.csv"
  //  "Path to the configuration or input file";
  //{%- else  %}
  //parameter String _configurationFileName = Modelica.Utilities.Files.loadResource("{{con_path}}")
  //  "Path to the configuration or input file";
  //{%- endif %}
   //{%- endif %}
  parameter Boolean _saveToFile (fixed=true) = false "Flag for writing results";

protected

  {%- if exec_target=="python" %}
  SimulatorToFMU.Python{{python_vers}}.Functions.BaseClasses.PythonObject obj=
  SimulatorToFMU.Python{{python_vers}}.Functions.BaseClasses.PythonObject(patResScri=patResScri);
  {%- if has_memory=="false" %}
  parameter Boolean passMemoryObject = false
    "Set to true if the Python function returns and receives an object, see User's Guide";
  {%- else  %}
  parameter Boolean passMemoryObject = true
    "Set to true if the Python function returns and receives an object, see User's Guide";
  {%- endif %}
  {%- elif exec_target=="server" %}
   parameter String runServer = Modelica.Utilities.Files.loadResource("{{run_ser}}")
    "Path to the script to run the server";
  SimulatorToFMU.Server.Functions.BaseClasses.ServerObject obj=
  SimulatorToFMU.Server.Functions.BaseClasses.ServerObject(patResScri=patResScri,
    nStrPar=nStrPar,
    nDblPar=nDblPar,
    strParNam=strParNam,
    strParVal=strParVal,
    dblParNam=dblParNam,
    dblParVal=dblParVal);
  {%- endif %}

   parameter Integer nDblPar={{real_parameter_variable_names|length}}
    "Number of double parameter values to sent to Simulator";
   parameter Integer nStrPar={{string_parameter_variable_names|length}}
    "Number of string parameter values to sent to Simulator";
  parameter Integer nDblInp(min=1)={{real_input_variable_names|length}}
    "Number of double input values to sent to Simulator";
  parameter Integer nDblOut(min=1)={{real_output_variable_names|length}}
    "Number of double output values to receive from Simulator";

  Real dblInpVal[nDblInp] "Value to be sent to Simulator";

  {% if (real_input_variable_names|length==0) -%}
  Real uR[nDblInp]
    "Variables used to collect values to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  Real uR[nDblInp]={
  {%- for row in modelica_real_input_variable_names -%}
  {{comma()}}
  {{row}}
  {%- endfor %}
  }"Variables used to collect values to be sent to Simulator";
  {%- endif %}
  {% if (real_output_variable_names|length==0) -%}
  Real yR[nDblOut]
    "Variables used to collect values received from Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  Real yR[nDblOut]={
  {%- for row in modelica_real_output_variable_names -%}
  {{comma()}}
  {{row}}
  {%- endfor %}
  }"Variables used to collect values received from Simulator";
  {%- endif %}
  {% if (real_input_variable_names|length==0) -%}
  parameter String dblInpNam[nDblInp]
    "Input variable names to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter String dblInpNam[nDblInp]={
  {%- for row in real_input_variable_names -%}
  {{comma()}}
  "{{row}}"
  {%- endfor %}
  }"Input variable name to be sent to Simulator";
  {%- endif %}
  {% if (real_output_variable_names|length==0) -%}
  parameter String dblOutNam[nDblOut]
    "Output variable names to be received from Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter String dblOutNam[nDblOut]={
  {%- for row in real_output_variable_names -%}
  {{comma()}}
  "{{row}}"
  {%- endfor %}
  }"Output variable names to be received from Simulator";
  {%- endif %}
  {% if (real_parameter_variable_names|length==0) -%}
  parameter String dblParNam[nDblPar]
    "Double parameter variable names to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter String dblParNam[nDblPar]={
  {%- for row in real_parameter_variable_names -%}
  {{comma()}}
  "{{row}}"
  {%- endfor %}
  }"Double parameter variable names to be sent to Simulator";
  {%- endif %}
  {% if (real_parameter_variable_names|length==0) -%}
  parameter Real dblParVal[nDblPar]=zeros(nDblPar)
    "Double parameter variable values to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter Real dblParVal[nDblPar]={
  {%- for row in real_parameter_variable_names -%}
  {{comma()}}
  {{row}}
  {%- endfor %}
  }"Double parameter variable values to be sent to Simulator";
  {%- endif %}

  {% if (string_parameter_variable_names|length==0) -%}
  parameter String strParNam[nStrPar]
    "String parameter variable names to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter String strParNam[nStrPar]={
  {%- for row in string_parameter_variable_names -%}
  {{comma()}}
  "{{row}}"
  {%- endfor %}
  }"String parameter variable names to be sent to Simulator";
  {%- endif %}

  {% if (string_parameter_variable_names|length==0) -%}
  parameter String strParVal[nStrPar]
    "String parameter variable values to be sent to Simulator";
  {%- else %}
  {% set comma = joiner(",") -%}
  parameter String strParVal[nStrPar]={
  {%- for row in string_parameter_variable_names -%}
  {{comma()}}
  {{row}}
  {%- endfor %}
  }"String parameter variable values to be sent to Simulator";
  {%- endif %}


///////////// THE CODE ABOVE HAS BEEN AUTOGENERATED //////////////
  protected
  {%- if exec_target=="python" %}
    parameter String moduleName="{{module_name}}"
      "Name of the Python module that contains the function";
    parameter String functionName="exchange"
      "Name of the Python function";
   {%- endif %}

  equation
	// Compute values that will be sent to Simulator
	for _cnt in 1:nDblInp loop
	  dblInpVal[_cnt] = uR[_cnt];
	end for;

	// Simulator data
	{%- if exec_target=="python" %}
	yR = SimulatorToFMU.Python{{python_vers}}.Functions.simulator(
	  moduleName=moduleName,
	  functionName=functionName,
	  //conFilNam=_configurationFileName,
    {% if (string_parameter_variable_names|length==0) -%}
	  conFilNam="",
    {%- else %}
    conFilNam=strParVal[1],
    {%- endif %}
    modTim=time,
    nDblInp=nDblInp,
    dblInpNam=dblInpNam,
    dblInpVal=dblInpVal,
    nDblOut=nDblOut,
    dblOutNam=dblOutNam,
    nDblPar=nDblPar,
    dblParNam=dblParNam,
    dblParVal=dblParVal,
    resWri=_saveToFile,
    obj=obj,
    passMemoryObject=passMemoryObject);
	{%- elif exec_target=="server" %}
	yR = SimulatorToFMU.Server.Functions.simulator(
	  modTim=time,
	  nDblInp=nDblInp,
	  dblInpNam=dblInpNam,
	  dblInpVal=dblInpVal,
	  nDblOut=nDblOut,
	  dblOutNam=dblOutNam,
	  resWri=_saveToFile,
	  obj=obj);
	 {%- endif %}
end {{model_name}};
