function [] = question_7_driver()
param1='Project2DataFiles\Parameters_V1.mat';
param2='Project2DataFiles\Parameters_V2.mat';
im1='Project2DataFiles\im1corrected.jpg';
im2 = 'Project2DataFiles\im2corrected.jpg';

planewarpdemo(im1,param1);
planewarpdemo(im2,param2);
end