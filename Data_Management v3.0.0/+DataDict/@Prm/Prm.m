%  DataDict.Prm
%  This script defines the data class of a Nexteer software component
%  Parameter used during FDD development stage. It includes the bare
%  minimum amount of information to cross-reference the fully-defined
%  properties of that signal in its source component.
%

% Change Log
%  19Sep2016   Siva    Initial Release


classdef Prm < Simulink.Parameter
    properties
        PrmType@char;
    end
    
    methods
        function obj = Prm(~)
            obj.PrmType = 'Cal';
            obj.Value = 0;
            obj.DataType = 'single';
            
        end
        
        function set.PrmType(obj,val)
            switch lower(val)
                case 'cal'
                    obj.PrmType = 'Cal';
                case 'con'
                    obj.PrmType = 'Con';
                case 'eol'
                    obj.PrmType = 'Eol';                
                case 'cfg'
                    obj.PrmType = 'Cfg';
                otherwise
                    error('Unknown PrmType, accepted values are; ''Cal'', ''Con'', ''Eol'', ''Cfg''.');
            end
        end
        
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            txt = sprintf('%s%s.Value = %s;\n', txt,var,Val2String(obj.Value));
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            txt = sprintf('%s%s.Min = %s;\n', txt,var,Val2String(obj.Min));
            txt = sprintf('%s%s.Max = %s;\n', txt,var,Val2String(obj.Max));
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.PrmType = ''%s'';\n', txt,var,obj.PrmType);
        end
    end
end
