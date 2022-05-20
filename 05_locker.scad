include <00_main.scad>;

use <03_first_shell.scad>;
use <04_second_shell.scad>;


module _pill_core_locker(offset=0) {
    rotate([0,90,0])
    cylinder(h=locker_x, r=locker_r+offset, center=true);
}

module 05_pill_locker(offset=0) {    
    _pill_core_locker(offset);
    
    translate([locker_x/2,0,0])
    sphere(r=locker_r+offset);
    
    translate([-locker_x/2,0,0])
    sphere(r=locker_r+offset);
}


module 05_pill_locker_mid_position(with_offset=false) {
    mid_overlay = size_z * (1 - top_overlay + (top_overlay - top_part)/2);
    offset_val = with_offset ? second_shell_offset : 0;
    shift_y = second_shell_offset + size_wall + locker_y;

    translate([
        size_x/2,
        -shift_y,
        mid_overlay])
    05_pill_locker(offset=offset_val);
    
    translate([
        size_x/2,
        size_y + shift_y,
        mid_overlay])
    05_pill_locker(offset=offset_val);
}


// DEVELOPING ################################

module 05_slide_with_locker() {
    size_debug = size_wall * 10;
    alpha_debug = 0.5;

    intersection() {
        04_second_shell();
        01_debug_slice();
    }

    intersection() {
        difference() {
            03_first_shell();
            05_pill_locker_mid_position(with_offset=true);
        }
        01_debug_slice();
    }

    intersection() {
        translate([0,0,0]);
        05_pill_locker();
        01_debug_slice();
    }

    05_pill_locker_mid_position();
}

module 05_developing() {
    debug_shift = 10;
    steps = 4;  // decrease step number for better understanding

    translate([0, - (steps - 0) * (debug_shift * 1.5), 0]) {
        _pill_core_locker();
    }

    translate([0, - (steps - 1) * (debug_shift * 1.5), 0]) {
        05_pill_locker();
    }

    translate([0, - (steps - 2) * (debug_shift * 1.5), 0]) {
        05_pill_locker(offset=0.1);
    }

    translate([0, - (steps - 3) * (debug_shift * 1.5), 0]) {
        tmp = 0.1;
        
        difference() {
            #cube([6,2,2]);
            05_pill_locker(offset=tmp);
        }
        
        intersection() {
            cube([6,2,2]);
            05_pill_locker();
        }
    }

    translate([0, - (steps - 4) * (debug_shift * 1.5), 0]) {
        05_slide_with_locker();
    }

}

// Do not forget put all structures under a comment in 00_main.scad
05_developing();