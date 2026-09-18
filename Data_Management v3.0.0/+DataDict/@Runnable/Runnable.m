% DataDict.Runnable
% This data class is used to communicate Periodics and the rate at which they should execute.

% Change Log
% 09Jan2015 PLefler     Initial Release
% 21May2015 Siva        Added help section
% 30Sep2015 PLefler     Added Context property and logic to enforce accepted values.
% 21Oct2015 Siva        Enabled and Initialized .Context property to "Rte".
% 22Mar2016 PLefler     Added Description property.
% 13Apr2016 Siva        Replaced "Non-Rte" with "NonRte" keyword for .Context property.
% 13May2016 Siva        Added logic to automatically convert "Non-Rte" to "NonRte" keyword for .Context property.
%

classdef Runnable < handle
    properties
        Context = '';
        TimeStep;
        Description@char;
    end
    
    methods
        function obj = Runnable()
            obj.Context = 'Rte';
            obj.TimeStep = 0.002;
        end
        
        function set.TimeStep(obj,val)
            if isnumeric(val)
                obj.TimeStep = val;
                
            elseif isa(val,'char')
                if ~isempty(regexp(val,'ISR|MotorControl|MotorControlx2','once'))
                    obj.TimeStep = val;
                else
                    obj.TimeStep = obj.TimeStep;
                    warning off backtrace
                    warning('Unknown Runnable.TimeStep input type, no change made from base TimeStep in Workspace.')
                    warning on backtrace
                end
            else
                obj.TimeStep = obj.TimeStep;
                warning off backtrace
                warning('Unknown Runnable.TimeStep input type, no change made from base TimeStep in Workspace.')
                warning on backtrace
            end
        end
        
        function set.Context(obj,val)
            switch val
                case {'Rte','NonRte'} % Library input type, then return type should be any bt.
                    obj.Context = val;
                case 'Non-Rte'
                    obj.Context = 'NonRte';
                otherwise
                    obj.Context = obj.Context;
                    warning off backtrace
                    beep,warning('Unrecognized Runnable.Context no change made in Workspace. Accepted values are; ''Rte'',''NonRte''');
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
            if isnumeric(obj.TimeStep)
                txt = sprintf('%s%s.TimeStep = %0.10g;\n', txt,var,obj.TimeStep);
            else
                txt = sprintf('%s%s.TimeStep = ''%s'';\n', txt,var,obj.TimeStep);
            end
            
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            
        end
        
    end
    
end

