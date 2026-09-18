%  MIL
% 
%  MIL tool is an interface to perform Model-In-The-Loop(MIL) validation for
%  our EPS designs.
% 
%  MIL tool works in two different modes:
%  1. Normal Mode
%  2. Batch Mode
% 
%  In 'Normal Mode', User can perform two different activities:
%  a) Test Plan Development
%       - In this scenario User can add a Test Case, execute it and analyze
%         the results.
%       - Now User can either edit the same Test Case or add a new Test Case
%         and analyze the results.
%       - User has to select various options like
%                'Number of Test Cases',
%                'Robustness Test',
%                'Generating Plots',
%                'Generate Reports',
%                'Save Test cases as CSV files',
%  b) Final MIL validation
%       - In this scenario User can perform a 'Final' MIL validation for
%         'ONE AND ONLY ONE FDD'.
%       - All necessary options are set automatically by MIL tool itself.
%       - A synergy delivery folder('<FDDName>_<FDD ShoName>_MIL') with all
%         necessary artifacts would be created 'automatically' by 'MIL' tool.
% 
%  In 'Batch Mode', User can perform 'Final' MIL validation for 'Countless'
%  number of FDD's 'automatically'.
%       - If an error is encountered during execution of an FDD, 'MIL' tool
%         would record the error & continue with another FDD.
%       - User has to ensure that all the necessary input files of different
%         FDD's are placed in a single folder.
%       - A detailed LOG file('MIL_BatchMode_<Current Date>_log.txt') would
%         be generated for user convenience.
%       - A synergy delivery folder('MIL_BatchMode_<Current Date>') with
%         all necessary artifacts would be created 'automatically by 'MIL' tool.
% 
%  For more information about 'MIL' tool and also for a 'step-by-step' user guide
%  of 'MIL' tool, please refer to the 'FDD Test Plan Authoring Standards' document
%  present in our eroom in the below location.
% 
%  http://eroom1.nexteer.com/eRoom/erooms8/NextGeneration/0_165f22
% 
%
