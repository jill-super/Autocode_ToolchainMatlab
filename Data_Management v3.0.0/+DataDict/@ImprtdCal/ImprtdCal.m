% DataDict.ImprtdCal
% This script defines the data class required for Nexteer Imported calibrations.

% Change Log
% 05Jun2015 Siva    Initial Release
% 10July2015 Siva   Updated String method such that EngMin is written first instead of EngMax(Issue no:54).
%                   Updated String method to populate .PortName in EA4 DD.
% 22Mar2016 PLefler     Added Description property to String method.


classdef ImprtdCal < AUTOSAR.Parameter

    %Observable properties that trigger code execution
    properties (SetObservable )
        EngVal %Engingeering Value, unscaled, engineering units, derives .Value property
        EngDT  %Engineering DataType, derives .DataType property
        EngMax %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngMin %Engineering Minimum, unscaled, engineering units, derives .Min property
    end

    % Impact (Relative effect that changes to this cal have on other cal values)
    properties(PropertyType = 'char');
        PortName = '';
    end


    %% METHODS

    methods

        function obj = ImprtdCal(~)

            obj.CoderInfo.StorageClass = 'Custom';
            obj.CoderInfo.CustomStorageClass = 'CalPrm';
            obj.CoderInfo.CustomAttributes.ElementName = 'Val';
            obj.CoderInfo.CustomAttributes.InterfacePath = '/PortInterfaces/CalPortInterface_single';

            obj.EngDT  = dt.float32;
            obj.EngMax = obj.EngDT.enMax;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngVal = 0;
            obj.PortName = 'UNDEFINED';

            addlistener(obj,'DataType','PostSet',@obj.postSetDataType);
            addlistener(obj,'Value','PostSet',@obj.postSetValue);

        end

        function postSetDataType(obj,~,~)
            if ~isequal(obj.DataType,obj.EngDT.BaseType)
                obj.DataType = obj.EngDT.BaseType;
                beep;
                warning backtrace off
                warning('Change to Calibration.DataType not accepted, please change EngDT instead.');
                warning backtrace on
            end
        end

        function postSetValue(obj,~,~)
            [~,scaledval] = validateUserEngVal(obj.EngDT,obj,obj.EngVal);
            if ~isequal(scaledval,obj.Value)
                obj.Value = scaledval;
                warning backtrace off
                warning('Change to Calibration.Value not accepted, please change EngVal instead.');
                warning backtrace on
            end
        end

        function set.EngDT(obj,val)
            %Include checking to make sure the EngDT is recognized.
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Calibration');
                warning backtrace on
            end

            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')

            obj.DataType = obj.EngDT.BaseType;
            obj.CoderInfo.CustomAttributes.InterfacePath = obj.EngDT.InterfacePath;

        end

        function set.EngVal(obj,val)
            [engval,scaleval,msg] = validateUserEngVal(obj.EngDT,obj,val);
            obj.EngVal = engval;
            obj.Value = scaleval;
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Calibration');
                warning backtrace on
            end
            if isa(engval,'struct')
                obj.CoderInfo.CustomAttributes.ElementName = 'Rec';
            else
                valsize = size(engval);
                if valsize(2) == 1;
                    obj.CoderInfo.CustomAttributes.ElementName = 'Val';
                elseif valsize(1) > 1
                    obj.CoderInfo.CustomAttributes.ElementName = 'Ary2d';
                elseif valsize(2) > 1
                    obj.CoderInfo.CustomAttributes.ElementName = 'Ary1d';
                end
            end
        end

        function set.EngMin(obj,val)
            [obj.EngMin,obj.Min,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Calibration',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngVal = obj.EngVal;
        end

        function set.EngMax(obj,val)
            [obj.EngMax,obj.Max,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Calibration',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngVal = obj.EngVal;
        end

        function set.PortName(obj,val)
            if isempty(val)
                val = 'UNDEFINED';
            end
            obj.PortName = val;
            obj.CoderInfo.CustomAttributes.PortName = val;
        end

        function txt = String(obj,flag)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.EngDT = %s;\n', txt,var,class(obj.EngDT));
            txt = sprintf('%s%s.EngVal = %s;\n', txt, var ,Val2String(obj.EngVal));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            switch flag
                case 'ea3'
                    txt = sprintf('%s%s.CoderInfo.Alias = ''%s'';\n', txt, var, obj.CoderInfo.Alias);
                case 'ea4'
                    txt = sprintf('%s%s.PortName = ''%s'';\n', txt,var,obj.PortName);
                    %txt = sprintf('%s%s.CoderInfo.CustomAttributes.PortName = ''%s'';\n', txt, var, obj.CoderInfo.CustomAttributes.PortName);
                otherwise
                    error('Known EA# flag passed to String method');
            end
            
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            
        end

    end % methods

end
%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.
%#ok<*MCSUP>
