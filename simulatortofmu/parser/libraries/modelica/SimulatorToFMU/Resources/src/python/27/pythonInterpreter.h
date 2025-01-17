#ifndef _PYTHONINTERPRETER_H_
#define _PYTHONINTERPRETER_H_
/*////////////////////////////////////////////////////////////////////////////*/
/* Function that evaluates a Python function using*/
/* embedded Python.*/
/* The Python function must take as an argument one or more doubles, integers*/
/* and strings, in this order. If there is only one argument of each data type,*/
/* then it must be a scalar. Multiple arguments of the same data type*/
/* must be put in a list.*/
/**/
/* See the User's Guide of the Modelica package for instructions.*/
/**/
/* The PYTHONPATH must point to the directory that contains the function.*/
/* On Linux, run for example*/
/* export PYTHONPATH=xyz*/
/* where xyz is the directory that contains the file that implements the*/
/* function multiply.*/
/**/
/**/
/* First Implementation: Michael Wetter, LBNL, 1/31/2013*/
/* Modified: Thierry S. Nouidui, LBNL, 3/26/2013 to suport cross compilation*/
/* Modified: Thierry S. Nouidui, LBNL, 3/2/2017 for Simulator to FMU*/
/* svn-id=$Id:.simulatorValues.c 2877 2011-09-11 00:46:02Z mwetter $*/
/*////////////////////////////////////////////////////////////////////////////*/
#include <stddef.h>  /* stddef defines size_t */
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#ifdef __unix__
#include<libgen.h>
#endif
#ifdef __APPLE__
#include <Python/Python.h>
#else
#include <Python.h>
#endif

#include "pythonObjectStructure.h"

#ifdef __cplusplus
extern "C" {
#endif
#ifdef _MSC_VER
#ifdef EXTERNAL_FUNCTION_EXPORT
# define LBNLPYTHONINTERPRETER_EXPORT __declspec( dllexport )
#else
# define LBNLPYTHONINTERPRETER_EXPORT __declspec( dllimport )
#endif
#elif __GNUC__ >= 4
/* In gnuc, all symbols are by default exported. It is still often useful,
to not export all symbols but only the needed ones */
# define LBNLPYTHONINTERPRETER_EXPORT __attribute__ ((visibility("default")))
#else
# define LBNLPYTHONINTERPRETER_EXPORT
#endif

/*
 * This function.simulators variables
 * with an external simulator.
 *
 * @param moduleName the module name
 * @param functionName the function name
 * @param configFileName the configuration file
 * @param modTim the simulation time
 * @param nDblWri the number of double variables to write
 * @param strWri the string variables to write
 * @param dblValWri the double values to write
 * @param nDblRea the number of variables to read
 * @param strRea the string variables to read
 * @param dblValRea the double values to read
 * @param nDblParWri the number of parameters to write
 * @param strParWri the string parameters to write
 * @param dblValParWri the double parameters to write
 * @param resWri the result flag
 * @param ModelicaFormatError the pointer
 * to the inModelicaFormatError
 * @param memory a Python object
 * @param have_memory the flag indicating a Python object
 */
LBNLPYTHONINTERPRETER_EXPORT void pythonSimulatorVariables(const char * moduleName,
							const char * functionName,
							const char * configFileName,
							double modTim,
							const size_t nDblWri,
							const char ** strWri,
							double * dblValWri,
							size_t nDblRea,
							const char ** strRea,
							double * dblValRea, size_t nDblParWri,
							const char ** strParWri,
							double * dblValParWri,
							int resWri,
							void(*inModelicaFormatError)(const char *string, ...),
                          	void* object,
                          	int have_memory);

LBNLPYTHONINTERPRETER_EXPORT void* initPythonMemory(char* pytScri);

LBNLPYTHONINTERPRETER_EXPORT void freePythonMemory(void* object);

#ifdef __cplusplus
}
#endif


#endif /* _PYTHONINTERPRETER_H_ */
