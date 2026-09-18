% DataDict.PIM
%  This script defines the data class required for Nexteer Per-Instance Memory.
%  This is NOT FOR NVM ACCESS.  It is for memory shared between runnables
%  in a single component.

% Change Log
% 07jul2014 K Derry    Initial Release
% 11jul2014 K Derry    Stripped out many properties & methods now contained in new DataDict.NVM class.
%                      Default EngDT changed from double to float32.
%                      New method named String for creating Data Dictionary
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngInit, EngMin, EngMax.
%                      Uses new ValidateEngDT, ValidateEngInit, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 10sep2014 K Derry    Rearranged String method commands.  Writing EngInit before EngMin and EngMax.
% 28oct2014 K Derry    Commented out CoderInfo to simplify data dictionaries.
% 09jan2015 PLefler    Removed commented out parts of CoderInfo from String method
%                      Provided methods to prevent user from changing DataType and InitValue properties
%                      Changed methods for changing EngDT, EngMax, EngMin, EngInit.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 02mar2015 PLefler    Bug Fix: set.EngInit was not setting the InitialValue property and the postSetInitialValue property listener was trying to set EngVal instead of EngInit.
% 05mar2015 PLefler    Bug Fix: set.EngInit was setting InitialValue to the engineering init instead of the scaled value.
% 13mar2015 PLefler    Bug Fix: set.EngInit was unable to use structure data classes.
% 31Mar2015 Siva       Added functionality to support PIM signals with an array of zero initializations if user needs.
% 18May2015 PLefler    Bug Fixes: Proper property assignment for EngInit, InitialValue and InitRowCol.
% 04Aug2015 PLefler    Removed check to make sure arrays of structures were not defined.
% 04Nov2015 Siva       Bug fix: Updated String method for populating EngMin and EngMax correctly.
% 06Jan2016 PLefler    Bug Fix: Fixed bug in code to write InitialValue property when the EngDT is an enumeration.



classdef PIM < AUTOSAR.Signal
    %% PROPERTIES
    properties (SetObservable)
        EngDT       %Engineering DataType, derives .DataType property
        EngMin      %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax      %Engineering Maximum, unscaled, engineering units, derives .Max property
        InitRowCol  %Initial values dimensions in the order of Row & Column
    end

    properties (Hidden)
        EngInit     %Engineering Initial value, unscaled, engineering units, derives .InitialValue property
    end

    properties
        LongName = '';
    end


    %% METHODS
    methods
        function obj = PIM(~)
            obj.EngDT  = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.InitRowCol = [1 1];
            obj.DataType = obj.EngDT.BaseType;
            obj.CoderInfo.StorageClass = 'Custom';
            obj.CoderInfo.CustomStorageClass = 'PerInstanceMemory';
            obj.CoderInfo.CustomAttributes.needsNVRAMAccess = false;

            addlistener(obj,'DataType','PostSet',@obj.postSetDataType);
            addlistener(obj,'InitialValue','PostSet',@obj.postSetInitialValue);
        end

        function postSetDataType(obj,~,~)
            if ~isequal(obj.DataType,obj.EngDT.BaseType)
                obj.DataType = obj.EngDT.BaseType;
                beep;
                warning backtrace off
                warning('Change to PIM.DataType not accepted, please change EngDT instead.');
                warning backtrace on
            end
        end

        function postSetInitialValue(obj,~,~)

            if isa(obj.EngDT,'bt.struct')
                initvalue = Val2String(eval(obj.EngDT.InitString),obj.EngDT);
                if ~isequal(initvalue,obj.InitialValue)
                    obj.InitialValue = initvalue;
                    warning('Direct changes to InitialValue aren''t allowed please change EngInit.');
                end
                return;
                
            elseif ~isempty(regexp(obj.EngDT.BaseType,'Enum: \w*','once'))
                enum = regexp(obj.EngDT.BaseType,'Enum: (?<name>\w*)','names');
                initvalue = [enum.name '(' enum.name '.getDefaultValue)'];
                if ~isequal(initvalue,obj.InitialValue)
                    warning('Direct changes to InitialValue aren''t allowed please change EngInit.');
                end
                return;
            end

            val = obj.InitRowCol;

            if ~isempty(obj.InitialValue)
                coltxt = [];
                for j = 1:val(2)
                    coltxt = sprintf('%s 0',coltxt);
                end
                txt = coltxt;
                for i = 1:val(1)-1
                    txt = sprintf('%s;%s',txt,coltxt);
                end
                initvalue = sprintf('[%s]',txt);
            else
                initvalue = '0';
            end

            if ~isequal(initvalue,obj.InitialValue)
                obj.InitialValue = initvalue;
                warning('Direct changes to InitialValue aren''t allowed.');
            end

        end

        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'PIM');
                warning backtrace on
            end

            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')

            obj.DataType = obj.EngDT.BaseType;
            obj.InitRowCol = obj.InitRowCol;
        end

        function set.EngInit(~,~)

        end

        function set.EngMin(obj,val)
            [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'PIM',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.Min = [];
        end

        function set.EngMax(obj,val)
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'PIM',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.Max = [];
        end

        function set.InitRowCol(obj,val)
            if isa(obj.EngDT,'bt.struct')
                obj.InitialValue = Val2String(eval(obj.EngDT.InitString),obj.EngDT);
                obj.InitRowCol = val;
                return;
            elseif ~isempty(regexp(obj.EngDT.BaseType,'Enum: \w*','once'))
                enum = regexp(obj.EngDT.BaseType,'Enum: (?<name>\w*)','names');
                obj.InitialValue = [enum.name '(' enum.name '.getDefaultValue)'];
                obj.InitRowCol = val;
                return;
            end

            obj.InitRowCol = val;
            if ~isempty(val)
                coltxt = [];
                for j = 1:val(2)
                    coltxt = sprintf('%s 0',coltxt);
                end
                txt = coltxt;
                for i = 1:val(1)-1
                    txt = sprintf('%s;%s',txt,coltxt);
                end
                obj.InitialValue = sprintf('[%s]',txt);
            else
                obj.InitialValue = '0';
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
%             txt = sprintf('%s%s.EngInit = %s;\n', txt,var,Val2String(obj.EngInit));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,Val2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,Val2String(obj.EngMax));
            txt = sprintf('%s%s.InitRowCol = %s;\n', txt,var,strcat('[',num2str(obj.InitRowCol),']'));

        end

    end % methods



end % classdef

%#ok<*MCSUP>
%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.

