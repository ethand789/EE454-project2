function pixel_c = pointTo2D(world_pos,param)
%pointTo2D: takes 3d points x,y, and z and the camera parameters and
%returns x,y coordinates in which the point will apear on camera

%load camera parameters
cam=load(param).Parameters;
%construct S matrix
S=eye(4);
for i=1:3
    S(i,4)=-cam.position(i);
end

%construct R matrix
R=zeros(4);
R(4,4) = 1;
R(1:3,1:3)=cam.Rmat;

%construct P_c coordinate
P_c = R*(S*world_pos);

%converting to film coordinates
focal_len = zeros(3,4);
focal_len(1,1) = cam.foclen;
focal_len(2,2) = cam.foclen;
focal_len(3,3) = 1;

film = focal_len * P_c;

film_c = zeros(3,1);
film_c(1,1) = film(1,1)/film(3,1);
film_c(2,1) = film(2,1)/film(3,1);
film_c(3,1) = 1;

%converting to pixel coordinates
printpoint_m = eye(3);
printpoint_m(1,3) = cam.prinpoint(1,1);
printpoint_m(2,3) = cam.prinpoint(1,2);

pixel_c = printpoint_m * film_c;

end