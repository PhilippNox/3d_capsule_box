include <00_main.scad>;

use <02_internal_walls.scad>
use <03_first_shell.scad>;
use <04_second_shell.scad>;
use <05_locker.scad>;

module 05_first_final_shell() {
    if (with_locker) {
        difference() {
            03_first_shell();
            05_pill_locker_mid_position(with_offset=true);
        }
    }
    else {
        03_first_shell();
    }
    02_internal_walls();
}

module 05_second_final_shell() {
    04_second_shell();
    if (with_locker) {
        05_pill_locker_mid_position(with_offset=false);
    }
}

module 05_preview() {
    00_initial_forms(); #01_min_vol();

    translate([0, size_y * 1.5, 0])
    if (with_locker) {
        05_slide_with_locker();
    } else {
        04_slide();
    }

    translate([0, size_y * 4.5, 0])
    05_first_final_shell();

    translate([0, size_y * 3, 0])
    intersection(){
        05_second_final_shell();
        cube([size_x,size_y*3,size_z*3], center=true);
    }
}


// DEVELOPING ################################

module 05_developing() {    
    05_first_final_shell();

    mirror([0, 0, 1])
    translate([0,size_y*1.5,-size_z])
    05_second_final_shell();
}

// Do not forget put all structures under a comment in 00_main.scad
05_developing();