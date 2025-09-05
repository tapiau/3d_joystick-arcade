rivnut_m3_insert_r = 5.1/2;
rivnut_m3_insert_h = 9;
rivnut_m3_insert_hat_r = 8.1/2;
rivnut_m3_insert_hat_h = 1;

module rivnut_m3(
    insert_r = rivnut_m3_insert_r,
    insert_h = rivnut_m3_insert_h,
    insert_hat_r = rivnut_m3_insert_hat_r,
    insert_hat_h = rivnut_m3_insert_hat_h,
) {
    $fn = 80;
    translate([0,0,insert_h])
    scale([1,1,-1]) {
        cylinder(h=insert_h - 1, r=insert_r);
        translate([0,0,insert_h-1])
            cylinder(h=1, r1=insert_r, r2 = insert_r-1);
        cylinder(h=insert_hat_h, r=insert_hat_r);
    }
}

//rivnut_m3();
