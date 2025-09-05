$fn=200;

button_r=19.70/2;
button_h=10;
button_wall_thickness=2;

include <rounded_cube.scad>

module button(button_h, button_r, button_wall_thickness) {
    insert_thickness=2.15;
    insert_width=4.65;
    insert_height=3.9;
    insert_gripper=0.5;
    
    notch_offset=4.5;
    notch_width=8.5;
    
    support_thickness=2;
    support_widht=6;

    difference(){
        union(){
            difference() {
                cylinder(h=button_h,r=button_r);
                translate([0,0,button_wall_thickness])
                    cylinder(h=button_h-button_wall_thickness,r=button_r-button_wall_thickness);
                translate([-notch_width/2,-button_r,notch_offset])
                    cube([notch_width,button_r*2,button_h-notch_offset]);
            }
            
            translate([-insert_width/2,-insert_thickness/2,0]) {
                cube([insert_width, insert_thickness, button_h]);
                translate([0,0,1])
                    rounded_cube([insert_width, insert_thickness, button_h + insert_height], fn=100);
            }

            intersection() {
                translate([-0.1,-insert_thickness/2-insert_gripper/2,0]) {
                    cube([0.6, insert_thickness+insert_gripper, button_h + insert_height]);
                }
                cylinder(h=button_h + insert_height, r2=insert_thickness/2, r1=10);
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

button(button_h, button_r, button_wall_thickness);

