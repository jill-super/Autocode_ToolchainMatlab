% usage: simulink2doors('systemname','EA3/EA4') where the .slx extension is optional
% 
% This program creates a simulink2doors.csv file to be used by a doors script to import
% linked simulink model blocks into a doors attribute. Used on the 'design' phase simulink model.
% 
% Once this file is created, use the doors script 'ImportTrace' inside
% EPS Tools inside of the open module and have it point to this script
% and the path of the doors module.
%
