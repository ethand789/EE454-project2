function [x_out,y_out] = pointTo2D(world_pos,param)
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
for i=1:3
    %Zhat
    R(3,i)=world_pos(i)-cam.position(i);
end
%Xhat
R(1,1:3)=cross([0,0,1],R(3,1:3));
%Yhat
R(2,1:3)=cross(R(3,1:3),R(1,1:3));

%make perspective matrix
Pers=zeros(3,4);
Pers(3,3)=1;
Pers(1,1)=cam.foclen;
Pers(2,2)=cam.foclen;


end