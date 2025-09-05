$fn=200;

skirt_radius=38/2;
skirt_thickness=1.2;
stick_radius=10/2;

module stick_skirt(
    skirt_radius=38/2,
    skirt_thickness=1.2,
    stick_radius=10/2,
) {
    difference() {
        cylinder(h=skirt_thickness, r1=skirt_radius-1,r2=skirt_radius);
        cylinder(h=skirt_thickness, r=stick_radius);
    }
}

stick_skirt();
