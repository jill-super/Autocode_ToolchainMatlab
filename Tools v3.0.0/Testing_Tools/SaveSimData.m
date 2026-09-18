%  function out = SaveSimData(plan, Tnum, IO, data, dirpath)
%    function SaveSimData is a generic function to create data files.  Each
%    System Function UTP shall have its own
%    Matlab script that runs several simulations and calls this function.
%    For example, when the UTP runs the tests,
%    the processing flow would look like this:
%    UTP script sets up Test (input vectors, calibrations, etc.)
%    UTP script runs simulation, then calls SaveSimData function
%    SaveSimData creates datafile(1), a .csv of simulation input & output vectors
%    UTP script sets up Test #2
%    UTP script runs simulation, then calls SaveSimData function
%    SaveSimData creates datafile(2)
%    Repeat
%    end
% 
%  INPUTS:
%     plan    - utp structure from TestDef file
%     Tnum        - int       - UTP test case number
%     IO      - names of input signals and output signals
%     data    - input data and output data from simulation
%     dirpath - relative path of folder in which data files will be stored.
%
