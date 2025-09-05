module rounded_cube(size = [1, 1, 1], center = false,radius = 0.5,fn=10){

obj_translate = (center == true) ?
[0, 0, 0] : [
(size[0] / 2),
(size[1] / 2),
(size[2] / 2)
];
    
    //echo (obj_translate);
translate(v = obj_translate) {
        hull(){
            cube([size[0]-radius-radius,size[1]-radius-radius,size[2]],center=true);
            cube([size[0]-radius-radius,size[1],size[2]-radius-radius],center=true);
            cube([size[0],size[1]-radius-radius,size[2]-radius-radius],center=true);
           
            translate ([size[0]/2-radius,size[1]/2-radius,size[2]/2-radius])
            sphere(r = radius,$fn = fn);
            translate ([-size[0]/2+radius,size[1]/2-radius,size[2]/2-radius])
            sphere(r = radius,$fn = fn);
            translate ([-size[0]/2+radius,-size[1]/2+radius,size[2]/2-radius])
            sphere(r = radius,$fn = fn);
            translate ([size[0]/2-radius,-size[1]/2+radius,size[2]/2-radius])
            sphere(r = radius,$fn = fn);
           
            translate ([size[0]/2-radius,size[1]/2-radius,-size[2]/2+radius])
            sphere(r = radius,$fn = fn);
            translate ([-size[0]/2+radius,size[1]/2-radius,-size[2]/2+radius])
            sphere(r = radius,$fn = fn);
            translate ([-size[0]/2+radius,-size[1]/2+radius,-size[2]/2+radius])
            sphere(r = radius,$fn = fn);
            translate ([size[0]/2-radius,-size[1]/2+radius,-size[2]/2+radius])
            sphere(r = radius,$fn = fn);
        }
    }
}
