include <00_main.scad>;
use <01_shared.scad>;


module _min_vol_n_half_wall() {
    minkowski() {
        union() {
            01_min_bottom_vol();
            translate([0,0,size_wall/2])
            01_min_bottom_vol();
        }
        cube(size_wall, center = true);
    }
}

module 02_internal_walls() {
    difference() {
        _min_vol_n_half_wall();
        00_initial_forms();
    }
}


// DEVELOPING ################################

module 02_developing() {
    steps = 3;  // decrease step number for better understanding

    translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
        00_initial_forms();
        #01_min_vol();
    }

    translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
        01_min_bottom_vol();
    }

    translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
        _min_vol_n_half_wall();
    }

    translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
        02_internal_walls();
    }
}

// Do not forget put all structures under a comment in 00_main.scad
02_developing();