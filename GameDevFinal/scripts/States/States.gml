// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_state(modules) {
    return {
        modules: modules, // Array of modules for this state

        init: function (owner) {
            for (var i = 0; i < array_length(modules); i++) {
                modules[i].init(owner);
            }
        },

        update: function (owner) {
            for (var i = 0; i < array_length(modules); i++) {
                modules[i].update(owner);
            }
        },

        _exit: function (owner) {
            for (var i = 0; i < array_length(modules); i++) {
                modules[i]._exit(owner);
            }
        }
    };
}