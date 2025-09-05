joy_hull_width=100;
joy_hull_length=104;
joy_hull_height=40;
joy_hull_wall_thickness=3;
joy_hull_screw_tower_radius=4;
joy_hull_cube_cut=6;
joy_screw_length=33;
joy_screw_radius=3.4/2;
joy_screw_head_radius=6/2;
joy_screw_head_length=3.2;
joy_cable_radius=7/2;
joy_button_radius=25/2;
joy_arcade_socket_radius=21/2;
joy_arcade_length=60;
joy_arcade_screw_placement_radius=32/2;
joy_arcade_screw_radius=4.05/2;

include <cube_cutted.scad>;
include <cube_rounded.scad>;
include <matrix_corners.scad>
include <rivnut-m3.scad>

module joy_screw(
    length=joy_screw_length,
    radius=joy_screw_radius,
    head_radius=joy_screw_head_radius,
    head_length=joy_screw_head_length,
)
{
    $fn=100;
    cylinder(h=length,r=radius);
    cylinder(h=head_length,r=head_radius);
}

module joy_hull_screw_tower(
    height=joy_hull_height,
    radius=joy_hull_screw_tower_radius,
    wall_thickness=joy_hull_wall_thickness,
    cube_cut=joy_hull_cube_cut,
) {
    $fn=100;

    screwHolder_r = radius+0.4;
    screwHolder_h = 16.1;

    intersection()
    {
        union() 
        {
            difference()
            {
                cylinder(h=height,r=radius,center=true);

                hull() screwHolder(screwHolder_h,screwHolder_r,height);
            }
            screwHolder(screwHolder_h,screwHolder_r,height);
        }
        union()
        {
            translate([0,0,height/4])
                cylinder(h=height/2,r1=screwHolder_r,r2=radius-1,center=true);
            translate([0,0,-height/4])
                cylinder(h=height/2,r=radius,center=true);
        }
    }
    difference()
    {
        for(a=[0:90:90])
        {
            rotate([0,0,-a])
            translate([0, radius-1, 0])
            difference()
            {
                translate([-wall_thickness/4,0,-height/2])
                    cube([wall_thickness/2,cube_cut+2,height],center=false);
                translate([-wall_thickness/4,-1,-height/2-wall_thickness])
                    rotate([-45,0,])
                        cube([wall_thickness/2,cube_cut*2,height]);
                translate([-wall_thickness/4,-1,height/2+wall_thickness])
                    rotate([-45,0,])
                        cube([wall_thickness/2,cube_cut*2,height]);
            }
        }
        translate([0,0,height/4])
            cylinder(h=height/2,r1=screwHolder_r,r2=radius-1,center=true);
    }

}

module joy_hull(
    width=joy_hull_width, 
    length=joy_hull_length, 
    height=joy_hull_height, 
    wall_thickness=joy_hull_wall_thickness,
    cube_cut=joy_hull_cube_cut,
)
{
    difference()
    {
        cube_cutted(
            [width, length, height], 
            cut=cube_cut
        );
        cube_cutted(
            [
                width-wall_thickness*2, 
                length-wall_thickness*2, 
                height-wall_thickness*2
            ], 
            cut=cube_cut-wall_thickness
        );
    }
}

module joy_cable(
    radius=joy_cable_radius,
    wall_thickness=joy_hull_wall_thickness,
)
{
    $fn=100;
    cylinder(h=wall_thickness*4, r=radius);
    cylinder(h=wall_thickness/3, r=9.5);
    translate([0,0,wall_thickness/3*2])
        cylinder(h=2.3, r=radius+1);
}

module joy_cable_holder(
    radius=joy_cable_radius,
    thickness=joy_hull_wall_thickness,
    zip_width=3,
    zip_thickness=2,
    height=joy_hull_height/2,
)
{
    $fn=100;
    holder_support_width=(radius+zip_thickness*2);
    holder_support_height=height;
    holder_thickness=zip_width+joy_hull_wall_thickness/3;
    holder_width=(radius+zip_thickness*2+thickness/3)*2;
    
    scale([1,1,-1])
    difference()
    {
        intersection()
        {
            hull()
            {
                cylinder(h=holder_thickness,r=holder_width/2);
                intersection()
                {
                    cylinder(h=holder_thickness,r2=holder_width/2,r1=height/3*2);
                    translate([0,-holder_width/2,0])
                        rotate([-60,0,0])
                                cube(holder_support_width*2, center=true);
                }
            }
            translate([-holder_width/2,-height,0])
                cube([holder_width,height,holder_thickness]);
        }
        difference()
        {
            cylinder(h=zip_width, r=radius+zip_thickness*2);
            cylinder(h=zip_width, r=radius+zip_thickness);
        }
    }
}

module joy_button(
    radius=joy_button_radius,
    wall_thickness=joy_hull_wall_thickness,
)
{
    joy_button_socket_thickness=2;

    $fn=100;
    scale([1,1,-1]) 
    {
        cylinder(h=wall_thickness,r=radius);
        translate([0,0,joy_button_socket_thickness])
            cylinder(h=wall_thickness/2,r=radius+2);
    }
}

module joy_arcade(
    height=joy_hull_wall_thickness,
    radius=joy_arcade_socket_radius,
    screw_placement_radius=joy_arcade_screw_placement_radius,
    screw_radius=joy_arcade_screw_radius,
)
{
    $fn=100;
    scale([1,1,-1]) 
    {
        cylinder(h=height,r=radius/2);
        translate([0,0,height/2])
            cylinder(h=height/2,r=radius);

        matrix_placer_cross(screw_placement_radius) {
            cylinder(h=height,r=screw_radius);
            translate([0,0,0.5])
                cylinder(h=1,r1=screw_radius+1,r2=screw_radius);
            cylinder(h=0.5,r=screw_radius+1);
        }
        translate([0,0,35])
            cylinder(h=4,r1=radius,r2=radius);
    }
}

module screwHolder(h,r,hull_height) {
    $fn=100;
    translate([0,0,0])
    difference() {
        cylinder(h=h,r=r);
        scale([1,1,-1])
        translate([0,0,-rivnut_m3_insert_h])
            rivnut_m3();   
        cylinder(h=h,r=1.5);
    }
}

module joy_notch(
    size=[1,1,1],
    center=false,
    cut=false,
)
{
    if(cut) {
        cube(size,center=center);
    } else {
        cube_cutted(size=size,cut=0.4, center);
        height=size[2]/2;
        cube([size[0],size[1],height],center=center);
    }
}

module joy_notches(
    width,
    length,
    wall_thickness,
    notch=4,
    cut=false,
) 
{
    translate([-width/2+wall_thickness/2,-length/4,-notch/2])
        joy_notch([wall_thickness/2, length/2, notch], center=false,cut);
    translate([width/2-wall_thickness,-length/4,-notch/2])
        joy_notch([wall_thickness/2, length/2, notch], center=false,cut);
    translate([-width/4,-length/2+wall_thickness/2,-notch/2])
        joy_notch([width/2, wall_thickness/2, notch], center=false,cut);
    translate([-width/3,length/2-wall_thickness,-notch/2])
        joy_notch([width/6, wall_thickness/2, notch], center=false,cut);
    translate([width/3-width/6,length/2-wall_thickness,-notch/2])
        joy_notch([width/6, wall_thickness/2, notch], center=false,cut);
}

module joy(
    width=joy_hull_width, 
    length=joy_hull_length, 
    height=joy_hull_height, 
    wall_thickness=joy_hull_wall_thickness,
    cube_cut=joy_hull_cube_cut,
    screw_tower_radius=joy_hull_screw_tower_radius,
    button_radius=joy_button_radius,
) {
    offset_x=42.4;
    offset_y=46.6;
    offset_z=5;

    screw_tower_offset_x=width/2-cube_cut-screw_tower_radius;
    screw_tower_offset_y=length/2-cube_cut-screw_tower_radius;

    
    translate([width/2,length/2,height/2])
    {
        difference() 
        {
            union() 
            {
                joy_hull(
                    width=width, 
                    length=length, 
                    height=height, 
                    wall_thickness=wall_thickness,
                    cube_cut=cube_cut,
                );
                matrix_placer(screw_tower_offset_x,screw_tower_offset_y)
                {   
                    joy_hull_screw_tower(height-wall_thickness*2, screw_tower_radius,wall_thickness,cube_cut);
                }
                translate([0,length/2-wall_thickness,0])
                    rotate([-90,0,0])
                        joy_cable_holder();
            }
            translate([0,0,-height/2])
                matrix_placer(screw_tower_offset_x,screw_tower_offset_y)
                    joy_screw();
            translate([0,length/2,0])
                rotate([90,0,0])
                    joy_cable();
            translate([
                -(width/2-cube_cut-wall_thickness-button_radius-screw_tower_radius/2),
                (length/2-cube_cut-wall_thickness-button_radius-screw_tower_radius/2),
                height/2
            ])
                joy_button();
            translate([
                (width/2-cube_cut-wall_thickness-button_radius-screw_tower_radius/2),
                (length/2-cube_cut-wall_thickness-button_radius-screw_tower_radius/2),
                height/2
            ])
                joy_button();
            translate([0,-((width-wall_thickness-1)/2-joy_arcade_length/2),height/2])
                joy_arcade();

//            joy_notches(width,length,wall_thickness);
        }
    }
}

module joy_bottom() 
{
    intersection()
    {
        difference()
        {
            joy();
            translate([joy_hull_width/2,joy_hull_length/2,joy_hull_height/2])
                joy_notches(joy_hull_width,joy_hull_length,joy_hull_wall_thickness, cut=true);
        }
        // cut half
        translate([0,0,-joy_hull_height/2]) 
            cube([joy_hull_width, joy_hull_length, joy_hull_height]);
    }
}

module joy_top() 
{
    translate([0,0,joy_hull_height])
    scale([1,1,-1])
    intersection()
    {
        joy();
        // cut half
        translate([0,0,joy_hull_height/2]) 
          cube([joy_hull_width, joy_hull_length, joy_hull_height]);
    }
    translate([joy_hull_width/2,joy_hull_length/2,joy_hull_height/2])
        joy_notches(joy_hull_width,joy_hull_length,joy_hull_wall_thickness, cut=false);

}

//intersection(){
joy_top();
//cube([joy_hull_width, joy_hull_length, 5]);
//translate([0,0,0]) cube([20, 20, 40]);
//translate([32,90,0]) cube([30, 22, 40]);
//}

//translate([-joy_hull_width-10,0,0])
intersection() {
translate([joy_hull_width+10,0,0]) joy_bottom();
//translate([joy_hull_width+10,0,0]) cube([20, 20, 40]);
}
