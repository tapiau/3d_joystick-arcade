cube_cutted_size=[30,40,50];
cube_cutted_cut=1;
cube_cutted_center=true;

module cube_cutted(
    size = cube_cutted_size, 
    cut = cube_cutted_cut,
    center = cube_cutted_center,
){
    cut0=0;
    cut2=cut*2;

    cube_center = (center == true) ?
        [0,0,0]:
        [size[0]/2, size[1]/2, size[2]/2]
    ;
    
    translate(cube_center)
    hull() 
    {
        cube([size[0]-cut0,size[1]-cut2,size[2]-cut2], center=true);
        cube([size[0]-cut2,size[1]-cut0,size[2]-cut2], center=true);
        cube([size[0]-cut2,size[1]-cut2,size[2]-cut0], center=true);
    }
}
