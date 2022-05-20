include <00_main.scad>;
use <01_shared.scad>;
use <02_internal_walls.scad>;


module 03_first_solid_shell(second_shell_offset=0) {
    minkowski() {
        01_min_bottom_vol();
        cube(size_wall, center = true);
        sphere(d=size_wall+second_shell_offset*2);
    }
}

module 03_first_shell() {
    difference(){
        03_first_solid_shell();
        01_min_vol();
    }
}


// DEVELOPING ################################

module 03_developing() {
    steps = 5;  // decrease step number for better understanding

    translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
        #01_min_vol();
    }

    translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
        #01_min_vol();
        01_min_bottom_vol();
    }

    translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
        03_first_solid_shell();
    }

    translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
        03_first_shell();
    }

    translate([0, - (steps - 4) * (size_y * 1.5), 0]) {
        02_internal_walls();
    }

    translate([0, - (steps - 5) * (size_y * 1.5), 0]) {
        union() {
            03_first_shell();
            02_internal_walls();
        }
    }
}

// Do not forget put all structures under a comment in 00_main.scad
03_developing();