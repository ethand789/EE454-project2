function [res1,res2] = question_1_driver()
%gets xy coords for each point on both cameras


im1='Project2DataFiles\Parameters_V1.mat';
im2='Project2DataFiles\Parameters_V2.mat';
points=load('Project2DataFiles\mocapPoints3D.mat').pts3D;

input = [0;0;0;1];

for i=1:39
    input(1:3)=points(1:3,i);
    res1(i,1:2)=pointTo2D(input,im1);
    res2(i,1:2)=pointTo2D(input,im2);
end

end