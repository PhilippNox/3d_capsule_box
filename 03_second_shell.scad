include <00_vars.scad>;
use <01_internal_walls.scad>;
use <02_first_shell.scad>;

// next line is a debug_line - uncomment to use
//cutted_top_second_shell = false; //rewrite var from 00_vars

module debug_slice() {
    translate([size_wall*2,-size_wall*3,-size_wall*3])
    cube([size_wall, size_y*2.5, size_z*2]);
}

module secord_core_shell() {
    if (cutted_top_second_shell) {
        difference() {
            translate([0,0,size_z*(1-top_overlay)])
            scale([1,1,top_overlay])
            00_min_vol();

            translate([
                -size_x/4,
                -size_y/4,
                size_z - offset - size_wall
            ])
            scale([1.5, 1.5, 1])
            00_min_vol();
        }
    } else {
        translate([0,0,size_z*(1-top_overlay)])
        scale([1,1,top_overlay])
        00_min_vol();
    }
}

module secord_core_offset_shell() {
    minkowski() {
       secord_core_shell();
       cube(offset*2, center = true); 
    }
}

module second_solid_shell() {
    minkowski() {
        secord_core_offset_shell();
        cube(size_wall*3, center = true);
        sphere(d=size_wall, $fn=60);
    }
}

module second_pre_shell() {
    difference() {
        second_solid_shell();
        00_min_vol();
    }
}

module 03_second_shell() {
    difference() {
        second_pre_shell();
        02_first_solid_shell(offset);
    }
}


steps = 6;  // decrease step number for better understanding

translate([0, - (steps - 0) * (size_y * 1.5), 0]) {
    #00_min_vol();
}

translate([0, - (steps - 1) * (size_y * 1.5), 0]) {
    secord_core_shell();
    #00_min_vol();
}

translate([0, - (steps - 2) * (size_y * 1.5), 0]) {
    secord_core_offset_shell();
    #00_min_vol();
}

translate([0, - (steps - 3) * (size_y * 1.5), 0]) {
    second_solid_shell();
}

translate([0, - (steps - 4) * (size_y * 1.5), 0]) {
    second_pre_shell();
}

translate([0, - (steps - 5) * (size_y * 1.5), 0]) {
    03_second_shell();
}

translate([0, - (steps - 6) * (size_y * 1.5), 0]) {
    size_debug = size_wall * 10;
    alpha_debug = 0.5;
    
    intersection() {
        03_second_shell();
        debug_slice();
    }
    
    intersection() {
        02_first_shell();
        debug_slice();
    }
    
    // RED - first shell
    translate([0,0,size_z])
    color([1,0,0,alpha_debug])
    cube([size_debug,size_debug,size_wall]);
    
    if (!cutted_top_second_shell) {
        // GREEN - offset
        translate([size_wall,-size_wall,size_z+size_wall])
        color([0,1,0,alpha_debug])
        cube([size_debug,size_debug,offset]);
        
        // BLUE - second shell
        translate([size_wall*2,-size_wall*2,size_z+size_wall+offset])
        color([0,0,1,alpha_debug])
        cube([size_debug,size_debug,size_wall]);
    }
    
    //#00_min_vol();
}