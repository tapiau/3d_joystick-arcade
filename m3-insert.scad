insert_r = 5.1/2;
insert_h = 9;
insert_hat_r = 8.1/2;
insert_hat_h = 1;

module m3Insert(insert_r, insert_h, insert_hat_r, insert_hat_h) {
    $fn = 80;
    translate([0,0,insert_h])
    scale([1,1,-1]) {
        cylinder(h=insert_h - 1, r=insert_r);
        translate([0,0,insert_h-1])
            cylinder(h=1, r1=insert_r, r2 = insert_r-1);
        cylinder(h=insert_hat_h, r=insert_hat_r);
    }
}

//if(is_undef(CONFIG)) {
//    test_x = 20;
//    test_y = 20;
//    test_z = 10;
//
//    difference() {
//        cube([test_x,test_y,test_z]);
//
//        translate([test_x/2,test_y/2,0])
//            insert(insert_r, test_z, insert_hat_r, insert_hat_h);
//    }
//}
