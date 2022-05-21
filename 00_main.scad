use <01_shared.scad>;
use <06_assembling.scad>;


// STEP_0 ################################

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

// step_0
// 0. uncomment the last line of this comment block.
// 1. define the forms for which you want to make a shell in 00_initial_forms.
// 2. after that comment the last line back and go to step_1.
// 👇
//00_initial_forms();


// STEP_1 ################################

size_x = 64;
size_y = 22; 
size_z = 30;

// step_1
// 0. uncomment the last line of this comment block.
// 1. dimensions should be such that the 00_initial_forms fits into red cube (01_min_vol).
// 2. after that comment the last line back and go to step_2.
// 👇
//00_initial_forms(); #01_min_vol();


// STEP_2 ################################

size_wall = 1;
second_shell_offset = 0.125;

top_part = 0.3;
top_overlay = 0.6;
second_shell_cutted_top = true;

with_locker = true;
locker_x = 10;
locker_r = 0.6;
locker_y = 0.1;

// step_2
// 0. uncomment the last line of this comment block.
// 1. try different options here.
// 2. after that comment the last line back and go to step_3.
// 👇
//05_preview();


// STEP_3 ################################

// step_3
// 0. Do export separately for each part of the shell. Try difference "fn" value.
// 👇
//$fn=60; 05_first_final_shell();
//$fn=60; 05_second_final_shell();
