# Dummy Python-driven simulator
def simulator(configuration_file, time, input_names, 
            input_values, output_names, write_results):
    """
    Dummy simulator Python-driven simulator
    which returns the input values.
    This function is only for illustration purposes/
    """
    
    return input_values

# Main Python function to be modified to interface with a simulator which has memory.
def exchange(configuration_file, time, input_names, 
            input_values, output_names, write_results,
            python_object_memory):
    """
    Return  a list of output values from the Python-based Simulator.
    The order of the output values must match the order of the output names.    

    :param configuration_file (String): Path to the Simulator model or configuration file
    :param time (Float): Simulation time
    :param input_names (Strings): Input names 
    :param input_values (Floats): Input values (same length as input_names) 
    :param output_names (Strings): Output names
    :param write_results (Float): Store results to file (1 to store, 0 else)
    :param python_object_memory: Variable that stores the memory of a Python object
        
    Example:
        >>> configuration_file = 'config.json'
        >>> time = 0
        >>> input_names = 'v'
        >>> input_values = 220.0
        >>> output_names = 'i'
        >>> write_results = 0
        >>> output_values = simulator(configuration_file, time, input_names,
                        input_values, output_names, write_results)
    """

    #######################################################################
    # EDIT AND INCLUDE CUSTOM CODE FOR TARGET SIMULATOR
    # Include body of the function used to compute the output values
    # based on the inputs received by the simulator function.
    # This function currently returns dummy output values. 
    # This will need to be adapted so it returns the correct output_values.
    # If the list of output names has only one name, then only a scalar 
    # must be returned.
    # The snippet shows how a Python object should be held in the memory
    # This is done by getting the object from the exchange function, modifying it,
    # and returning it. 
    if python_object_memory == None:
        # Initialize the Python object
        python_object_memory = {'a':input_values}
    else:
        python_object_memory['a'] = python_object_memory['a'] + 1
        
    output_values = simulator(configuration_file, time, input_names,
                        input_values, output_names, write_results)
    # Check if return values are correct
    if(len(output_values)!=len(output_names)):
        raise("...")
    #########################################################################
    return [output_values, python_object_memory]
    
