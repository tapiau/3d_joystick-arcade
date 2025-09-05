cube_rounded_size=[30,40,50];
cube_rounded_radius=5;
cube_rounded_center=true;
cube_rounded_fn=100;

module cube_rounded_corner(
    size = cube_rounded_size, 
    radius = cube_rounded_radius,
    fn=cube_rounded_fn,
){
    translate ([size[0]/2-radius,size[1]/2-radius,size[2]/2-radius])
        sphere(r = radius,$fn = fn);
}

module cube_rounded_half(
    size = cube_rounded_size, 
    radius = cube_rounded_radius,
    fn=cube_rounded_fn,
){
    cube_rounded_corner(size, radius, fn);
    scale([-1,1,1])
        cube_rounded_corner(size, radius, fn);
    scale([1,-1,1])
        cube_rounded_corner(size, radius, fn);
    scale([-1,-1,1])
        cube_rounded_corner(size, radius, fn);
}

module cube_rounded(
    size = cube_rounded_size, 
    radius = cube_rounded_radius,
    center = cube_rounded_center,
    fn=cube_rounded_fn,
){

    radius0=0;
    radius2=radius*2;

    cube_center = (center == true) ?
        [0, 0, 0] : 
        [ (size[0] / 2), (size[1] / 2), (size[2] / 2) ]
    ;
    
    translate(cube_center) {
        hull()
        {
            cube([size[0]-radius0,size[1]-radius2,size[2]-radius2],center=true);
            cube([size[0]-radius2,size[1]-radius0,size[2]-radius2],center=true);
            cube([size[0]-radius2,size[1]-radius2,size[2]-radius0],center=true);

            cube_rounded_half(size,radius,fn);
            scale([1,1,-1])
                cube_rounded_half(size,radius,fn);
        }
    }
}

