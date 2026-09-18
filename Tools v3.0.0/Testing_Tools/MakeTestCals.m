%  function MakeTestCals(basecals)
%  Creates Unit Test Plan parameter file template.
%  basecals:  string     filename of default parameter values for FDD
%             cell       filenames of every needed param file (common, shared, etc)
%                        (data dictionary of component being tested must be first file in cell array.)
%  examples:
%  MakeTestCals('SF01_Assist_DataDict')
%  MakeTestCals({'SF01_Assist_DataDict'; 'SF00_CommonCals_DataDict'})
%
