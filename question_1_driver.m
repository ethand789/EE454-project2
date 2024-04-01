function [res1,res2] = question_1_driver()
%gets xy coords for each point on both cameras


im1='Project2DataFiles\Parameters_V1.mat';
im2='Project2DataFiles\Parameters_V2.mat';
points=load('Project2DataFiles\mocapPoints3D.mat').pts3D;

input = [0;0;0;1];

res1 = zeros(39,2);
res2 = zeros(39,2);

for i=1:39
    input(1:3)=points(1:3,i);
    res1(i,1:3)=pointTo2D(input,im1);
    res2(i,1:3)=pointTo2D(input,im2);
end

imData = imread('Project2DataFiles\im1corrected.jpg');
%imData = imread('Project2DataFiles\im2corrected.jpg');

imshow(imData);
hold on

scatter(res1(:,1), res1(:,2), 'r', 'o');
%scatter(res2(:,1), res2(:,2), 'r', 'o');

hold off

xlabel('X');
ylabel('Y');
title('Scatter Plot of X,Y Points on Image');

end