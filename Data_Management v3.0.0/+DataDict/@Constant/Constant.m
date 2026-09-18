% DataDict.Constant
% This script defines the data class required for Nexteer constants (#define).

% Change Log
% 03feb2014 K Derry    Initial Release
% 26feb2014 K Derry    New properties: EngDT, EngMin, EngMax, EngVal.
%                      New methods:    dtChange, propChange.
%                      Suppress warnings.
% 20mar2014 K Derry    Demoted class from mpt.Parameter to Simulink.Parameter (simplifies m-files)
%                      Set default CustomStorageClass = 'Define'
% 15apr2014 K Derry    EngVal is now quantized when EngDT is float32
% 11jul2014 K Derry    Default EngDT changed from double to float32.
%                      New method named String for creating Data Dictionary
%                      New LongName property
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngVal.
%                      Uses new ValidateEngDT, ValidateEngVal, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 19nov2014 PLefler    Removed CoderInfo information from String method.
% 09jan2015 PLefler    Changed method for changing EngDT, EngVal, EngMin, EngMax.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 16jan2015 PLefler    Changed EngDT method to assign EngMin and EngMax directly to the data type enMin and enMax.
% 09mar2015 PLefler    Added new properties Header and Define to setup CoderInfo properly for autocoding, updated String method to account for the new properties.
% 20Apr2015 Siva       Added logic to update CoderInfo's Header file information based on .Header value (Issue no: 31)
% 13Apr2016 Siva       Removed .Header property from Constant data class.
%


classdef Constant < Simulink.Parameter
    %% PROPERTIES
    %Observable properties that trigger code execution
    properties (SetObservable)
        EngVal %Engingeering Value, unscaled, engineering units, derives .Value property
        EngDT  %Engineering DataType, derives .DataType property
        EngMin %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax %Engineering Maximum, unscaled, engineering units, derives .Max property
    end

    properties(PropertyType = 'char')
        LongName = '';
        Define = '';
        Header = '';
    end

    %% METHODS
    methods
        function obj = Constant(~)
            obj.EngDT  = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.EngVal = 0;

            obj.Header;
            obj.Define = 'Local';

            addlistener(obj,'DataType','PostSet',@obj.postSetDataType);
            addlistener(obj,'Value','PostSet',@obj.postSetValue);
        end

        function postSetDataType(obj,~,~)
            if ~isequal(obj.DataType,obj.EngDT.BaseType)
                obj.DataType = obj.EngDT.BaseType;
                beep;
                warning backtrace off
                warning('Change to Constant.DataType not accepted, please change EngDT instead.');
                warning backtrace on
            end
        end

        function postSetValue(obj,~,~)
            [~,scaledval] = validateUserEngVal(obj.EngDT,obj,obj.EngVal);
            if ~isequal(scaledval,obj.Value)
                obj.Value = scaledval;
                warning backtrace off
                warning('Change to Constant.Value not accepted, please change EngVal instead.');
                warning backtrace on
            end
        end

        function set.EngDT(obj,val)
            %Include checking to make sure the EngDT is recognized.
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Constant');
                warning backtrace on
            end

            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')

            obj.DataType = obj.EngDT.BaseType;
        end

        function set.EngVal(obj,val)
            [engval,scaleval,msg] = validateUserEngVal(obj.EngDT,obj,val);
            obj.EngVal = engval;
            obj.Value = scaleval;
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Constant');
                warning backtrace on
            end
        end

        function set.EngMin(obj,val)
            [obj.EngMin,obj.Min,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Constant',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngVal = obj.EngVal;
        end

        function set.EngMax(obj,val)
            [obj.EngMax,obj.Max,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Constant',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngVal = obj.EngVal;
        end


        function set.Define(obj,val)
            switch lower(val)
                case 'local'
                    obj.CoderInfo.StorageClass = 'Custom';
                    obj.CoderInfo.CustomStorageClass = 'Define';
                    obj.Define = 'Local';
                case 'global'
                    obj.CoderInfo.StorageClass = 'Custom';
                    obj.CoderInfo.CustomStorageClass = 'ImportedDefine';
                    obj.Define = 'Global';
                otherwise
                    error('Unknown value for Constant.Define property. Accepted values are ''Local'' and ''Global''.');
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
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.EngDT = %s;\n', txt,var,class(obj.EngDT));
            txt = sprintf('%s%s.EngVal = %s;\n', txt,var,Val2String(obj.EngVal));
            txt = sprintf('%s%s.Define = ''%s'';\n', txt, var,obj.Define);
        end
    end % methods

end % classdef

%#ok<*MCSUP>
%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.
