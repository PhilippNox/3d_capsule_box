include <00_vars.scad>;

use <02_internal_walls.scad>
use <03_first_shell.scad>;
use <04_second_shell.scad>;
use <05_locker.scad>;


00_initial_forms(); #01_min_vol();

translate([0, size_y * 1.5, 0])
04_slide_with_locker();

translate([0, size_y * 3, 0])
intersection(){
    05_first_final_shell();
    cube([size_x,size_y*3,size_z*3], center=true);
}

translate([0, size_y * 4.5, 0])
intersection(){
    05_second_final_shell();
    cube([size_x,size_y*3,size_z*3], center=true);
}