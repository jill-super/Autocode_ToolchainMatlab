% DataDict.ConfigParam 
% Nexteer data class for configurable constants "Non-constant, Constants".   

% Change Log:
% 27Feb2015 PLefler    Initial version
% 09mar2015 PLefler    New properties Header and Define added to DataDict.Constant class, updated String method to account for the new properties.   
% 15Sep2015 PLefler    New property IsBuildPrm was added along with logic to ensure that the property is either true or false. (Issue #67) 
% 29Apr2016 Siva       Removed .Header property from ConfigParam data class.


classdef ConfigParam < DataDict.Constant
    
    properties
        IsBuildPrm = false;
    end

    methods
        function obj = ConfigParam()
            obj.IsBuildPrm = false;
        end
        
        function set.IsBuildPrm(obj,val)
            if islogical(val)
                obj.IsBuildPrm = val;
            else
                error('Input value for IsBuildPrm must be true or false.')
            end
        end
        
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            txt = sprintf('%s%s.LongName = ''%s'';\n', txt,var,obj.LongName);
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            if obj.IsBuildPrm == 1, txt = sprintf('%s%s.IsBuildPrm = true;\n', txt,var);
            else                       txt = sprintf('%s%s.IsBuildPrm = false;\n', txt,var);end;
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.EngDT = %s;\n', txt,var,class(obj.EngDT));
            txt = sprintf('%s%s.EngVal = %s;\n', txt,var,Val2String(obj.EngVal));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            %             txt = sprintf('%s%s.Header = ''%s'';\n', txt, var,obj.Header);
            txt = sprintf('%s%s.Define = ''%s'';\n', txt, var,obj.Define);
        end
    end
    
end

