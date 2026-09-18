% usage: testdef2doors('reqname','EA3/EA4') where the .req extension is optional
% 
% This program creates a testdef2doors.csv file to be used by a doors script to import
% linked testdef.m lines into a doors attribute. Used on the
% 'mil' phase with the TestDef.req file generated from the associated .m file.
% 
% Once this file is created, use the doors script 'ImportTrace' inside
% EPS Tools inside of the open module and have it point to this script
% and the path of the doors module.
%
