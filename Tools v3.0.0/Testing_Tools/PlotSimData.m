%  function [return_code] = PlotSimData(FnName, Tnum, test, IO, data, path, suppress)
%  This function plots data for UTP tests.
% 
%  Arguments:
%  			FnName		- string	- name of function tested, include in plot title
%            Tnum        - int       - UTP test case number
% 			test		- struct	- UTP test case information
%  			IO			- struct	- input/output names in cell arrays
%  			data		- struct	- time-based data from simulation
%  			path		- string	- relative path to the simulation output directory
%            suppress    - boolean   - true means close figure after saving.
%  Returns:
%  			return_code - boolean	- flag indicating status upon exist of function (0 == function exited without error)
%
