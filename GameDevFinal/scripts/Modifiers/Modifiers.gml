// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function calc_add(base, modifier_value) {
    return base + modifier_value;
}

// Multiplicative calculation
function calc_multiply(base, modifier_value) {
    return base * modifier_value;
}

function create_modifier(name, attribute, value, calculation) {
    return {
		name: name,
        attribute: attribute,  // Attribute to modify (e.g., "attack")
        value: value,          // Modification value (can be positive or negative)
        calculation: calculation, // Calculation function (e.g., add, multiply)
    };
}

function apply_collision_modifier(target, name, modifier, condition) {
    // Check if the target is colliding with the specified object
    if (condition) {
        // Apply the modifier only if it's not already active
		
		var exists = false;
		for (var i = 0; i < array_length(target.modifiers); i++) {
		    if (target.modifiers[i].name == modifier.name) {
		        exists = true;
		        break;
		    }
		}
        if (!exists) {
           // Get the current value dynamically
			var current_value = variable_instance_get(target, modifier.attribute);

			// Calculate the new value using the modifier's calculation method
			var new_value = modifier.calculation(current_value, modifier.value);

			// Set the new value dynamically
			variable_instance_set(target, modifier.attribute, new_value);
            array_push(target.modifiers, modifier);
        }
    } else {
        // Remove the modifier if it's no longer touching
        for (var i = array_length(target.modifiers) - 1; i >= 0; i--) {
            var _mod = target.modifiers[i];
            if (_mod.name == modifier.name) {
                // Reverse the effect
                if (_mod.calculation == calc_add) {
					var current_value = variable_instance_get(target, modifier.attribute);
					var new_value = current_value - _mod.value;
					variable_instance_set(target, modifier.attribute, new_value);
                } else if (_mod.calculation == calc_multiply) {
					var current_value = variable_instance_get(target, modifier.attribute);
					var new_value = current_value/_mod.value;
					variable_instance_set(target, modifier.attribute, new_value);
                }
                array_delete(target.modifiers, i, 1);
            }
        }
    }
}

function handle_collision_modifier(target,name, attribute, value, calculation, condition) {
    var modifier = create_modifier(name, attribute, value, calculation);
    apply_collision_modifier(target, name, modifier, condition);
}