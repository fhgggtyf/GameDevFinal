// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_module(init_func, update_func, exit_func) {
    return {
        init: init_func,     // Function called when entering a state
        update: update_func, // Function called during the state's logic
        _exit: exit_func      // Function called when leaving a state
    };
}