% DataDict.SrvRunnable
% This data class is used to communicate Server Runnables and the arguments that they except. 

%Change Log
% 09jan2015 PLefler     Initial Release
% 17feb2015 PLefler     Change to constructor method to create an argument by default, and set Return to 'None'.
% 17mar2015 PLefler     Change to set.Return method to accept DataDict.CSReturn as an input.
% 07apr2015 PLefler     Removed automatic creation of CSArguments.
% 21May2015 Siva        Added help section
% 05Jun2015 Siva        Enhanced the error handling mechanism for notifying users(Issue no:51). 
% 22Mar2016 PLefler     Added Description property.
% 13Apr2016 Siva        Replaced "Non-Rte" with "NonRte" keyword for .Context property.

classdef SrvRunnable < handle

    properties 
        Context = '';
        Description@char;
        Return;
        Arguments@DataDict.CSArguments;
    end
    
    methods
        
        function obj = SrvRunnable(~)
            obj.Context = 'Rte';
            obj.Return = DataDict.CSReturn;
        end
        
        function set.Return(obj,val)
            % val should be a DataDict.CSReturn. To be backward compatible set method should recognize the strings 'None' and 'Standard'. 
            if ischar(val)
                switch val
                    case 'Standard'
                        obj.Return = DataDict.CSReturn;
                        obj.Return.Type = 'Standard';
                    case 'None'
                        obj.Return = DataDict.CSReturn;
                        obj.Return.Type = 'None';
                    otherwise
                        obj.Return = DataDict.CSReturn;
                        warning('Unrecognized data type for SrvRunnable.Return property. Expected values are: DataDict.CSReturn, ''Standard'' or ''None''.')
                end
            elseif isa(val,'DataDict.CSReturn')
                obj.Return = val;
            else
                obj.Return = DataDict.CSReturn;
                warning('Unrecognized data type for SrvRunnable.Return property. Expected values are: DataDict.CSReturn, ''Standard'' or ''None''.')
            end
        end
        
        function set.Context(obj,val)
            switch val
                case {'Rte','NonRte','Both'} % Library input type, then return type should be any bt.
                    obj.Context = val;
                otherwise
                    obj.Context = obj.Context;
                    warning off backtrace
                    beep,warning('Unrecognized SrvRunnable.Context no change made in Workspace. Accepted values are; ''Rte'',''NonRte'',''Both''');
                    warning on backtrace
            end
        end
                
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            
            txt = sprintf('%s = %s;\n', var, cl);
            txt = sprintf('%s%s.Context = ''%s'';\n',txt,var,obj.Context);
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            txt = sprintf('%s%s.Return = DataDict.CSReturn;\n',txt,var);
            arg = obj.Return;
            txt = sprintf('%s%s',txt,strrep(String(arg),'arg',var));
            
            for i = 1:length(obj.Arguments)
                txt = sprintf(['%s%s.Arguments(' num2str(i) ') = DataDict.CSArguments;\n'],txt,var);
                arg = obj.Arguments(i);
                txt = sprintf('%s%s',txt,strrep(strrep(String(arg),'arg',var),'(n)',['(' num2str(i) ')']));
            end
            

        end

    end
    
end


