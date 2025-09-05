//insert_r = 5.1/2;

$fn=80;
include <m3-insert.scad>;

module screwHolder(offset_x,offset_y,offset_z,h,r) {
    translate([offset_x,offset_y,offset_z])
    {
        difference() {
            cylinder(h=h,r=r);
            translate([0,0,offset_z+2.2])
                m3Insert(insert_r,insert_h,insert_hat_r, insert_hat_h);   
            cylinder(h=h,r=1.5);
        }
    }
}


module joyTop()
{
    screwHolder_r = 9.2/2;
    screwHolder_h = 16.1;

    offset_x=42.4;
    offset_y=46.6;
    offset_z=5;

    union() {
        difference() {
            import("src/joy-top-ori.stl");
            hull()
                screwHolder(offset_x,offset_y,offset_z,screwHolder_h,screwHolder_r);
            hull()
                screwHolder(-offset_x,offset_y,offset_z,screwHolder_h,screwHolder_r);
            hull()
                screwHolder(offset_x,-offset_y,offset_z,screwHolder_h,screwHolder_r);
            hull()
                screwHolder(-offset_x,-offset_y,offset_z,screwHolder_h,screwHolder_r);
        }

        screwHolder(offset_x,offset_y,offset_z,screwHolder_h,screwHolder_r);
        screwHolder(-offset_x,offset_y,offset_z,screwHolder_h,screwHolder_r);
        screwHolder(offset_x,-offset_y,offset_z,screwHolder_h,screwHolder_r);
        screwHolder(-offset_x,-offset_y,offset_z,screwHolder_h,screwHolder_r);
    }
}

joyTop();


//intersection() {
//    joyTop();
//    translate([33,36,0])
//        cube([30,30,22]);
//}
