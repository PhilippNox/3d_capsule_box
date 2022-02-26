include <00_vars.scad>;


module internal_core_wall() {
    scale([1,1,bot_part])
    00_min_vol();
}

module min_vol_n_half_wall() {
    minkowski() {
        union() {
            internal_core_wall();
            translate([0,0,size_wall/2])
            internal_core_wall();
        }
        cube(size_wall, center = true);
    }
}

module 01_internal_walls() {
    difference() {
        min_vol_n_half_wall();
        00_initial_forms();
    }
}


steps = 3;  // decrease step number for better understanding

translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
    00_initial_forms();
    #00_min_vol();
}

translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
    internal_core_wall();
}

translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
    min_vol_n_half_wall();
}

translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
    01_internal_walls();
}