function [F] = question_5_driver(mode)
%gets fundamental matrix from image coordinates
%if mode is 1, the user will choose 8 points by clicking on the image
%otherwise, the coordinates from question 1 will be used

im = imread('Project2DataFiles\im1corrected.jpg');
im2 = imread('Project2DataFiles\im2corrected.jpg');


figure(1); imagesc(im); axis image; drawnow;
figure(2); imagesc(im2); axis image; drawnow;
if mode == 1
    for i=1:8
    figure(1); [x1(i),y1(i)] = ginput(1);
    figure(2); [x2(i),y2(i)] = ginput(1);
    end
else
    [res1,res2] = question_1_driver;
    x1=res1(1,1:39);
    y1=res1(2,1:39);
    x2=res2(1,1:39);
    y2=res2(2,1:39);
end
F=eightpoint(x1,y1,x2,y2);
end