$fn=200;

module button_housing(
    button_housing_r=23.5/2,
    button_housing_h=20.7,
    button_housing_wall_thickness=2,
    button_housing_foot_height=3,
    switch_floor_thickness=1,
) {
    insert_thickness=2.15;
    insert_width=4.65;
    insert_height=3.9;
    
    support_thickness=2;
    support_widht=6;

    difference(){
        union(){
            difference() {
                cylinder(h=button_h,r=button_r);
                translate([0,0,button_wall_thickness])
                    cylinder(h=button_h-button_wall_thickness,r=button_r-button_wall_thickness);
            }
            
            translate([-insert_width/2,-insert_thickness/2,0]) {
                cube([insert_width, insert_thickness, button_h + insert_height]);
            }

            translate([-0.1,-insert_thickness/2-0.1,0]) {
                intersection() {
                    cube([0.2, insert_thickness+0.3, button_h + insert_height]);
                    cylinder(h=button_h + insert_height, r2=insert_thickness, r1=10);
                }
            }
            
            translate([-support_thickness/2,-support_widht/2,0])
                cube([support_thickness, support_widht, button_h]);
        }
        difference() {
            cylinder(h=1,r=button_r+1);
            cylinder(h=2,r1=button_r-1,r2=button_r+1);
        }
            
    }

}

button_housing(button_h, button_r, button_wall_thickness);

