% DataDict.Client
% This script defines the data class required for Nexteer client runnable operations.

% Change Log:
% 17feb2015 PLefler     Change to constructor method to create an argument by default and set the Return value to 'None'.
% 17mar2015 PLefler     Change to set.Return method to accept DataDict.CSReturn as an input.
% 07apr2015 PLefler     Removed automatic creation of CSArguments.
% 21May2015 Siva        Added help section
% 05Jun2015 Siva        Added check to ensure that .CallLocation property accepts only cell arrays of strings(Issue no:52).
% 21Mar2016 PLelfer     Added Description property.

classdef Client < handle
    
    properties 
        CallLocation = cell(1);
        Description@char;
        Return;
        Arguments@DataDict.CSArguments;
    end
    
    methods
        function obj = Client(~)
            obj.CallLocation = cell(1);
            obj.Description = '';
            obj.Return = DataDict.CSReturn;
        end
  
        function set.CallLocation(obj,val)
            if(iscell(val))
                obj.CallLocation  = val;
            else
                obj.CallLocation  = obj.CallLocation;
                warning backtrace off
                warning('Wrong format for Client.CallLocation, no change made in Workspace. Only cell arrays are accepted for Client.CallLocation format. Ex:{''Per1'',''Srv1''}');
                warning backtrace on
            end
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
                        warning('Unrecognized data type for Client.Return property. Expected values are: DataDict.CSReturn, ''Standard'' or ''None''.')
                end
            elseif isa(val,'DataDict.CSReturn')
                obj.Return = val;
            else
                obj.Return = DataDict.CSReturn;
                warning('Unrecognized data type for Client.Return property. Expected values are: DataDict.CSReturn, ''Standard'' or ''None''.')
            end
        end
                
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            
            txt = sprintf('%s = %s;\n', var, cl);
            %% Write CallLocation
            txt = sprintf('%s%s.CallLocation = {',txt,var);
            for i = 1:size(obj.CallLocation,2)
                if i~=size(obj.CallLocation,2)
                    txt = sprintf('%s''%s'',',txt,obj.CallLocation{1,i});
                else
                    txt = sprintf('%s''%s''',txt,obj.CallLocation{1,i});
                end
            end
            txt = sprintf('%s};\n',txt);
            %% Write Description
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            
            %% Write CSReturn
            txt = sprintf('%s%s.Return = DataDict.CSReturn;\n',txt,var);
            arg = obj.Return;
            txt = sprintf('%s%s',txt,strrep(String(arg),'arg',var));
            
            for i = 1:length(obj.Arguments)
                txt = sprintf(['%s%s.Arguments(' num2str(i) ') = DataDict.CSArguments;\n'],txt,var);
                arg = obj.Arguments(i);
                txt = sprintf('%s%s',txt,strrep(strrep(String(arg),'arg',var),'(n)',['(' num2str(i) ')']));
            end
            %%

        end

    end
    
end


