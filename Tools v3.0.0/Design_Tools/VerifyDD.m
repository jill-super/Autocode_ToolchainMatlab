% function VerifyDD( PrgType, filename, dependency1, dependency2, ...)
% Verifies quality of component data dictionary file
%  PrgType    - Name of the Electrical architecture used for our EPS
%               software i.e. 'EA3' or 'EA4'.
%  filename   - Name of component data dictionary file to verify.  The .m
%               extension is optional.
%  (optional) - User may include a comma-separated list of other data
%               dictionary files needed for verification.  For example, if a
%               .Graphlink property references a calibration from another
%               software component, the .m file for that component is needed
%               to verify that the Graphlink property's value contains a
%               valid calibration name from the other file.
% 
% Function throws an error if it cannot load 'Engineering_Units.m'
% Function throws an error if it cannot load 'Available_Nexteer_Signals.m'
% 
% For each category of variable (FDD, Runnable, SrvRunnable, Client, IpSignal, OpSignal, Calibration, CalStruct,
% Constant, IRV, PIM, NVM, Display, CSArguments), this function checks the variable's name for proper formatting.
%  Then it checks property values against many different rules.
%
