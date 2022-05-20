include <00_main.scad>;


module 01_min_vol() {
    cube([size_x,size_y,size_z]);
}

module 01_min_bottom_vol() {
    scale([1,1,1 - top_part])
    01_min_vol();
}

module 01_debug_slice() {
    translate([size_x/2,-size_wall*3,-size_wall*3])
    cube([size_wall, size_y*3, size_z*3], center = true);
}