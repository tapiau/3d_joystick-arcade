matrix_placer_corners_list=[[1,1],[-1,1],[1,-1],[-1,-1]];
matrix_placer_cross_list=[[1,0],[-1,0],[0,1],[0,-1]];

module matrix_placer(
    x,
    y,
)
{
    for(i=matrix_placer_corners_list)
    {
        translate([x*i[0],y*i[1],0])
            scale([i[0],i[1],1])
                children();
    }
}
module matrix_placer_cross(
    offset,
)
{
    for(i=matrix_placer_cross_list)
    {
        scale_x = i[0]!=0 ? i[0] : 1;
        scale_y = i[1]!=0 ? i[1] : 1;
        
        translate([offset*i[0],offset*i[1],0])
            scale([scale_x,scale_y,1])
                children();
    }
}
