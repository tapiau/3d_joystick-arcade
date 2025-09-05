include <rivnut-m3.scad>

screw_holder_height = 16.1;
screw_holder_radius = 5;

module screw_holder(
    h=screw_holder_height,
    r=screw_holder_radius,
) {
    $fn=100;
    cylinder(h=h,r=r);
}

screw_holder();
