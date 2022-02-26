size_x = 64;
size_y = 22; 
size_z = 30;
size_wall = 1;

top_part = 0.3;
bot_part = 1 - top_part;
top_overlay = 0.6;

offset = 0.2;   // TODO rename
cutted_top_second_shell = true;

locker_x = 10;
locker_r = 0.6;
locker_coff = 1.15;


module 00_initial_forms() {
translate([0,0,0]) 
cube([64,5,30]);

translate([0,6,0])
cube([48,10,30]);

translate([0,17,0])
cube([31,5,30]);

translate([31 + 2,17,0])
cube([31,5,30]);
}

module 00_min_vol() {
    cube([size_x,size_y,size_z]);
}

//00_initial_forms(); #00_min_vol();