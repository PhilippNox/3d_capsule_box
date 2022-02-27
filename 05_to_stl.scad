include <00_vars.scad>;

use <01_internal_walls.scad>
use <02_first_shell.scad>;
use <03_second_shell.scad>;
use <04_locker.scad>;

module first_final_shell() {
    difference() {
        02_first_shell();
        04_pill_locker_mid_position(with_offset=true);
    }
    01_internal_walls();
}

module second_final_shell() {
    03_second_shell();
    04_pill_locker_mid_position(with_offset=false);
}

module sample() {
    first_final_shell();

    mirror([0, 0, 1])
    translate([0,size_y*1.5,-size_z])
    second_final_shell();
}


//first_final_shell();
//second_final_shell();
sample();