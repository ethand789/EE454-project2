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
R(1:3,1:3)=cam.Rmat;

%make perspective matrix
Pers=zeros(3,4);
Pers(3,3)=1;
Pers(1,1)=cam.foclen;
Pers(2,2)=cam.foclen;

%calculate result
result = Pers*R*S*world_pos;

x_out=result(1)/result(3);
y_out=result(2)/result(3);

end