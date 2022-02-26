include <00_vars.scad>;
use <01_internal_walls.scad>;


module 02_first_core_shell() {
    scale([1,1,bot_part])
    00_min_vol();
}

module 02_first_solid_shell(offset=0) {
    minkowski() {
        02_first_core_shell();
        cube(size_wall, center = true);
        sphere(d=size_wall+offset*2, $fn=60);
    }
}

module 02_first_shell() {
    difference(){
        02_first_solid_shell();
        00_min_vol();
    }
}


steps = 5;  // decrease step number for better understanding

translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
    #00_min_vol();
}

translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
    #00_min_vol();
    02_first_core_shell();
}

translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
    02_first_solid_shell();
}

translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
    02_first_shell();
}

translate([0, - (steps - 4) * (size_y * 1.5), 0]) {
    01_internal_walls();
}

translate([0, - (steps - 5) * (size_y * 1.5), 0]) {
    union() {
        02_first_shell();
        01_internal_walls();
    }
}