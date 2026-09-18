function setSubSystemFunction(SS, FunctionName, FileName)
%
% setSubSystemFunction() - sets an subsystem to generate code in a function
% and file specified by the arguments.
%
% SS : (1xN String) : full path to subsystem
% FunctionName:  (1xN String) : name to use for C function
% FileName: name to use for file name ( no extension )
%
% example:  setSubSystemFunction('myModel/SubSystem', 'myFunction',
% ,'myFile' );

set_param(SS, 'TreatAsAtomicUnit', 'on'); 
set_param(SS, 'RTWSystemCode', 'Function');
set_param(SS, 'RTWFcnNameOpts', 'User specified');
set_param(SS, 'RTWFcnName', FunctionName);
%
set_param(SS, 'RTWFileNameOpts', 'User specified');
set_param(SS, 'RTWFileName', FileName);

end