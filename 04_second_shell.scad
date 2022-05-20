include <00_main.scad>;
use <03_first_shell.scad>;

// next line is a debug_line - uncomment to use
// second_shell_cutted_top = false; //rewrite var from 00_main


module _secord_core_shell() {
    if (second_shell_cutted_top) {
        difference() {
            translate([0,0,size_z*(1-top_overlay)])
            scale([1,1,top_overlay])
            01_min_vol();

            translate([
                -size_x/4,
                -size_y/4,
                size_z - second_shell_offset - size_wall
            ])
            scale([1.5, 1.5, 1])
            01_min_vol();
        }
    } else {
        translate([0,0,size_z*(1-top_overlay)])
        scale([1,1,top_overlay])
        01_min_vol();
    }
}

module _secord_core_offset_shell() {
    minkowski() {
       _secord_core_shell();
       cube(second_shell_offset*2, center = true); 
    }
}

module _second_solid_shell() {
    minkowski() {
        _secord_core_offset_shell();
        cube(size_wall*3, center = true);
        sphere(d=size_wall);
    }
}

module _second_pre_shell() {
    difference() {
        _second_solid_shell();
        01_min_vol();
    }
}

module 04_second_shell() {
    difference() {
        _second_pre_shell();
        03_first_solid_shell(second_shell_offset);
    }
}

module 04_slide() {
    size_debug = size_wall * 10;
    alpha_debug = 0.5;

    intersection() {
        04_second_shell();
        01_debug_slice();
    }

    intersection() {
        03_first_shell();
        01_debug_slice();
    }

    // RED - first shell
    translate([size_x/2,0,size_z])
    color([1,0,0,alpha_debug])
    cube([size_debug,size_debug,size_wall]);

    if (!second_shell_cutted_top) {
        // GREEN - second_shell_offset
        translate([size_x/2+size_wall,-size_wall,size_z+size_wall])
        color([0,1,0,alpha_debug])
        cube([size_debug,size_debug,second_shell_offset]);

        // BLUE - second shell
        translate([size_x/2+size_wall*2,-size_wall*2,size_z+size_wall+second_shell_offset])
        color([0,0,1,alpha_debug])
        cube([size_debug,size_debug,size_wall]);
    }
}

// DEVELOPING ################################

module 04_developing() {
    steps = 6;  // decrease step number for better understanding

    translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
        #01_min_vol();
    }

    translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
        _secord_core_shell();
        #01_min_vol();
    }

    translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
        _secord_core_offset_shell();
        #01_min_vol();
    }

    translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
        _second_solid_shell();
    }

    translate([0, - (steps - 4) * (size_y * 1.5), 0]) {
        _second_pre_shell();
    }

    translate([0, - (steps - 5) * (size_y * 1.5), 0]) {
        04_second_shell();
    }

    translate([0, - (steps - 6) * (size_y * 1.5), 0]) {
        04_slide();   
    }
}

// Do not forget put all structures under a comment in 00_main.scad
04_developing();