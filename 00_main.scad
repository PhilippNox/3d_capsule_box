use <01_shared.scad>;
use <06_assembling.scad>;


// PART_0 ################################

module 00_initial_forms() {
translate([0,0,0]) 
cube([64,5,30]);

translate([0,6,0])
cube([48,10,30]);

translate([0,17,0])
cube([31,5,30]);

translate([31 + 2,17,0])
cube([31,5,30]);
    
translate([56,11,0])
cylinder(30, r=5);
}


//00_initial_forms();


// PART_1 ################################

size_x = 64;
size_y = 22; 
size_z = 30;


//00_initial_forms(); #01_min_vol();


// PART_2 ################################

size_wall = 1;
second_shell_offset = 0.125;

top_part = 0.3;
top_overlay = 0.6;
second_shell_cutted_top = true;

with_locker = true;
locker_x = 10;
locker_r = 0.6;
locker_y = 0.1;


05_preview();


// PART_3 ################################

//$fn=60; 05_first_final_shell();
//$fn=60; 05_second_final_shell();
