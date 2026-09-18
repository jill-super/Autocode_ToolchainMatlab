% DataDict.Display
% This script defines the data class required for Nexteer display variable.

% Change Log
% 03feb2014 K Derry    Initial Release
% 20mar2014 K Derry    Now derived from mpt.Signal instead of Simulink.Signal
%                      Set newly available .MemorySection = 'MemVolatile'
%                      New EngDT property, listeners, and related method
% 09may2014 K Derry    New EngMin, EngMax properties and related methods
% 04jun2014 K Derry    New LongName property
% 10jul2014 K Derry    Default EngDT changed from double to float32.
%                      New method named String for creating Data Dictionary
%                      Uses new WriteDescription function in String method.
% 01sep2014 K Derry    New EngInit property.
%                      Increased number of significant digits in String method when writing EngInit, EngMin, EngMax.
%                      Uses new ValidateEngDT, ValidateEngInit, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 28oct2014 K Derry    Commented out CoderInfo to simplify data dictionaries.
% 09jan2105 PLefler    Changed Inherited class from mpt.Signal to AUTOSAR.Signal.
%                      Removed Commented out CoderInfo to simplify data dictionaries.
%                      Changed method for writing the EngMin and EngMax in the string method.
%                      Changed method for changing EngDT, EngVal, EngMin, EngMax.
% 05mar2015 PLefler    Bug Fix: set.EngInit was not setting the InitialValue property and the postSetInitialValue property listener was trying to set EngVal instead of EngInit.
% 31Mar2015 Siva       Added functionality to support DISPLAY signals with an array of zero initializations if user needs.

classdef Display < AUTOSAR.Signal
    %% PROPERTIES
    properties (SetObservable)
        EngDT   %Engineering DataType, derives .DataType property
        EngMin  %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax  %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngInit %Engineering Initial value, unscaled, engineering units, derives .InitialValue property
        InitRowCol  %Initial values dimensions in the order of Row & Column
    end
    
    properties
        LongName = '';
    end
    
    
    %% METHODS
    methods
        function obj = Display(~)
            obj.EngDT  = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.InitRowCol = [1 1];
            obj.EngInit= obj.InitRowCol;
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
                warning('Change to Display.DataType not accepted, please change EngDT instead.');
                warning backtrace on
            end
        end
        
        function postSetInitialValue(obj,~,~)
            obj.InitialValue = Val2String(zeros(obj.InitRowCol));
        end
        
        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Display');
                warning backtrace on
            end
            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')
            
            obj.DataType = obj.EngDT.BaseType;
        end
        
        function set.EngInit(obj,~)
            obj.EngInit = zeros(obj.InitRowCol);
        end
        
        function set.EngMin(obj,val)
            obj.Min = [];
            if(~isequal(obj.InitRowCol,[1 1]))
                [obj.EngMin,~,~] = validateUserEngMin(obj.EngDT,val);
                obj.EngMin = obj.EngMin;
            else
                [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
                if ~strcmp(msg,'')
                    warning backtrace off
                    warning(msg,'Display',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                    warning backtrace on
                end
            end
        end
        
        function set.EngMax(obj,val)
            obj.Max = [];
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'Display',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
        end
        
        function set.InitRowCol(obj,val)
            obj.InitRowCol = val;
            if(~isempty(obj.InitRowCol))
                obj.EngInit = zeros(obj.InitRowCol);
                obj.InitialValue = num2str(zeros(obj.InitRowCol));
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
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            txt = sprintf('%s%s.InitRowCol = %s;\n', txt,var,strcat('[',num2str(obj.InitRowCol),']'));
            
        end
    end % methods
    
end % classdef

%#ok<*MCSUP>
%#ok<*ATUNK> This comment suppresses warnings.  Do not uncomment or delete.
