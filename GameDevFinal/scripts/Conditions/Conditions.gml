// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_condition(check_func) {
    return {
        check: check_func // Function that evaluates a condition
    };
}