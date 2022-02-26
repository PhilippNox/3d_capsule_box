include <00_vars.scad>;

use <02_first_shell.scad>;
use <03_second_shell.scad>;


module _debug_slice() {
    translate([size_x/2,-size_wall*3,-size_wall*3])
    cube([size_wall, size_y*2.5, size_z*3], center = true);
}

module pill_core_locker(offset=0) {
    rotate([0,90,0])
    cylinder(h=locker_x, r=locker_r+offset, center=true);
}

module 04_pill_locker(offset=0) {    
    pill_core_locker(offset);
    
    translate([locker_x/2,0,0])
    sphere(r=locker_r+offset);
    
    translate([-locker_x/2,0,0])
    sphere(r=locker_r+offset);
}

module 04_pill_locker_mid_position(with_offset=false) {
    mid_overlay = top_overlay + (top_overlay - bot_part)/2;
    offset_val = with_offset ? offset : 0;
    shift_y = offset + size_wall * locker_coff;

    translate([
        size_x/2,
        -shift_y,
        size_z*mid_overlay])
    04_pill_locker(offset=offset_val, $fn=60);
    
    translate([
        size_x/2,
        size_y + shift_y,
        size_z*mid_overlay])
    04_pill_locker(offset=offset_val, $fn=60);
}

debug_shift = 10;
steps = 4;  // decrease step number for better understanding

translate([0, - (steps - 0) * (debug_shift * 1.5), 0]) {
    pill_core_locker($fn=60);
}

translate([0, - (steps - 1) * (debug_shift * 1.5), 0]) {
    04_pill_locker($fn=60);
}

translate([0, - (steps - 2) * (debug_shift * 1.5), 0]) {
    04_pill_locker(offset=0.1,$fn=60);
}

translate([0, - (steps - 3) * (debug_shift * 1.5), 0]) {
    tmp = 0.1;
    
    difference() {
        #cube([6,2,2]);
        04_pill_locker(offset=tmp,$fn=60);
    }
    
    intersection() {
        cube([6,2,2]);
        04_pill_locker($fn=60);
    }
}

translate([0, - (steps - 4) * (debug_shift * 1.5), 0]) {
    size_debug = size_wall * 10;
    alpha_debug = 0.5;
    
    intersection() {
        03_second_shell();
        _debug_slice();
    }
    
    intersection() {
        difference() {
            02_first_shell();
            04_pill_locker_mid_position(with_offset=true);
        }
        _debug_slice();
    }
    
    intersection() {
        translate([0,0,0]);
        04_pill_locker();
        _debug_slice();
    }
    
    04_pill_locker_mid_position();
    
}