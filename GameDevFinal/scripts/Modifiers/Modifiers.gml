function calc_add(base, modifier_value) {
    return base + modifier_value;
}

function calc_add_high_prio(base, modifier_value) {
    return base + modifier_value;
}

function calc_multiply(base, modifier_value) {
    return base * modifier_value;
}

function create_modifier(name, attribute, value, calculation) {
    return {
        name: name,
        attribute: attribute,  // Attribute to modify
        value: value,          // Modification value
        calculation: calculation, // Calculation function
    };
}

function sort_modifiers(modifiers) {
    array_sort(modifiers, function(a, b) {
        var priority_a = (a.calculation == calc_add_high_prio) ? 0 : ((a.calculation == calc_multiply) ? 1 : 2);
        var priority_b = (b.calculation == calc_add_high_prio) ? 0 : ((b.calculation == calc_multiply) ? 1 : 2);

        return priority_a - priority_b;
    });
}


function apply_collision_modifier(target, name, modifier, condition) {
    if (condition) {
        var exists = false;
        for (var i = 0; i < array_length(target.modifiers); i++) {
            if (target.modifiers[i].name == modifier.name) {
                exists = true;
                break;
            }
        }
        if (!exists) {
            var current_value = variable_instance_get(target, modifier.attribute);

            var new_value = modifier.calculation(current_value, modifier.value);

            variable_instance_set(target, modifier.attribute, new_value);
            array_push(target.modifiers, modifier);

            sort_modifiers(target.modifiers);
        }
    } else {
        for (var i = array_length(target.modifiers) - 1; i >= 0; i--) {
            var _mod = target.modifiers[i];
            if (_mod.name == modifier.name) {
                if (_mod.calculation == calc_add || _mod.calculation == calc_add_high_prio) {
                    var current_value = variable_instance_get(target, modifier.attribute);
                    var new_value = current_value - _mod.value;
                    variable_instance_set(target, modifier.attribute, new_value);
                } else if (_mod.calculation == calc_multiply) {
                    var current_value = variable_instance_get(target, modifier.attribute);
                    var new_value = current_value / _mod.value;
                    variable_instance_set(target, modifier.attribute, new_value);
                }
                array_delete(target.modifiers, i, 1);

                sort_modifiers(target.modifiers);
            }
        }
    }
}

function handle_collision_modifier(target, name, attribute, value, calculation, condition) {
    var modifier = create_modifier(name, attribute, value, calculation);
    apply_collision_modifier(target, name, modifier, condition);
}