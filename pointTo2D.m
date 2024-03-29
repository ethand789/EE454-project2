function [x_out,y_out] = pointTo2D(x_in,y_in,z_in,param)
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
R=

end