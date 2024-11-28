// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_state_machine(states) {
    return {
        states: states,                 // Array of states
        current_state: -1,           // Current active state
        transitions: [],                // Array of transitions between states

        // Initialize the state machine
        init: function (start_state, owner) {
            current_state = start_state;
            states[start_state].init(owner);
        },

        // Add a transition
        add_transition: function (from_state, to_state, condition) {
            array_push(transitions, {from: from_state, to: to_state, condition: condition});
        },

        // Update the current state and check transitions
        update: function (owner) {
            // Run the current state's update logic
            if (current_state != -1) {
                states[current_state].update(owner);
            }

            for (var i = 0; i < array_length(transitions); i++) {
                var transition = transitions[i];
                if (transition.from == current_state && transition.condition.check(owner)) {
                    // Transition to the next states
                    states[current_state]._exit(owner); // Exit current state
                    current_state = transition.to;          // Change state
					states[current_state].init(owner); // Enter new state
                    break;
                }
            }
        }
    };
}