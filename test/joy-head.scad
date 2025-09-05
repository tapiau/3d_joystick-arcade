include <inc/rivnut-m6.scad>

joy_head_r=36/2;
joy_head_cut=5;

module joy_head(
    r=36/2,
    cut=5,
) {
    $fn=200;
    
    difference() {
        translate([0,0,r-cut])
            sphere(r=r);
        translate([0,0,-cut/2])
            cube([40,40,cut], center=true);
        translate([0,0,rivnut_m6_insert_h+1])
            rotate([180,0,0])
                rivnut_m6(insert_h=rivnut_m6_insert_h+1, insert_hat_h=rivnut_m6_insert_hat_h+1);
    }
}

joy_head();
