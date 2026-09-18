% DataDict.NVM
%  This script defines the data class required for Nexteer Per-Instance Memory.

% Change Log
% 11jul2014 K Derry    Initial Release, starting from DataDict.PIM
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngInit, EngMin, EngMax, ReqdResolution.
%                      Uses new ValidateEngDT, ValidateEngInit, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 29sep2014 K Derry    Rearranged String method commands.  Writing EngInit before EngMin and EngMax.
%                      Renamed ReqdResolution to Resolution.
% 28oct2014 K Derry    Commented out Resolution.  May or may not get added back later as TestTolerance.
% 19nov2014 PLefler    Commented out parts CoderInfo from the String method to simplify the data dictionary.
% 09jan2015 PLefler    Removed commented out parts of CoderInfo from String method added switch to handle writing different strings for 'EA3' vs 'EA4'.
%                      Changed methods for changing EngDT, EngMax, EngMin, EngInit.
%                      Provided methods to prevent user from changing DataType and InitValue properties.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 02mar2015 PLefler    Bug Fix: set.EngInit was not setting the InitialValue property and the postSetInitialValue property listener was trying to set EngVal instead of EngInit.
% 05mar2015 PLefler    Bug Fix: set.EngInit was setting InitialValue to the engineering init instead of the scaled value.
% 13mar2015 PLefler    Bug Fix: set.EngInit was unable to use structure data classes.
%                      Removed unused method setupCoderInfo.
% 31Mar2015 Siva       Added functionality to support NVM signals with an array of zero initializations if user needs.
% 20Apr2015 Siva       Enhancement: SafetyRating property has been turned off till we develop a robust ASIL management process(Issue no: 30).
% 28Apr2015 PLefler    Added EngInit back into the String method and turned the set.EngInit functionalitiy back on to support the NVM Component.
% 18May2015 PLefler    Bug Fixes: Proper property assignment for EngInit, InitialValue and InitRowCol.
% 04Aug2015 PLefler    Removed check to make sure arrays of structures were not defined.
% 06Oct2015 PLefler    The behavior of the EngInit and InitRowCol properties was changed to support explicit arrays of structures and to prevent warnings when EngInit is [] and InitRowCol is not [1 1].
% 20Oct2015 PLefler    The ProgrammedBy property was hidden and removed from the string method.
%                      Added 'ThermMngt', 'PwrMngt' and 'TqCtrl' to the list of options for TuningOwner.
%                      The SafetyRating property was hidden.
% 23Oct2015 PLefler    Fixed bug in String method, when writing the EngMin and EngMax.
% 29Jan2015 PLefler    Fixed bug that writes '[ 0]' when the EngInit value is set to [].
% 24May2017 Siva       Removed .Alias property as it is not necessary for NVMs.

classdef NVM < AUTOSAR.Signal
    %% PROPERTIES
    %Observable properties that trigger code execution
    properties (SetObservable)
        EngDT  %Engineering DataType, derives .DataType property
        EngMin %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngInit %Engingeering Value, unscaled, engineering units, derives .InitialValue property
        InitRowCol %Initial values dimensions in the order of Row & Column
    end

    %Other properties
    properties
        LongName = '';
    end

    properties(Hidden, PropertyType = 'char', AllowedValues = {'?'; 'Supplier'; 'Nexteer'; 'Customer'});
        ProgrammedBy = 'Nexteer'; end; % Supplier, Nexsteer, or Customer

    properties(Hidden, PropertyType = 'char', AllowedValues = {'?'; 'A'; 'B'; 'C'; 'D'; 'QM'; 'n/a'});
        SafetyRating = '?'; end; % ASIL rating

    properties(PropertyType = 'char', AllowedValues = {'?'; 'L';'M';'H'});
        Impact = '?'; end;       % Low, Medium, High

    properties(PropertyType = 'char', AllowedValues = {'?'; 'CSE'; 'Safety'; 'Controls'; 'EPDT'; 'FDD'; 'ThermMngt'; 'PwrMngt'; 'TqCtrl';});
        TuningOwner = '?'; end;  % CSE - owns values even when tuned by customer

    properties(PropertyType = 'logical scalar')
        CustomerVisible = false; end;   % true means the cal should be included in customer project files


    %% METHODS
    methods
        function obj = NVM(~)
            obj.EngDT  = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.EngInit = 0;
            obj.CoderInfo.StorageClass = 'Custom';
            obj.CoderInfo.CustomStorageClass = 'PerInstanceMemory';
            obj.CoderInfo.CustomAttributes.needsNVRAMAccess = true;

            addlistener(obj,'DataType','PostSet',@obj.postSetDataType);
            %             addlistener(obj,'InitialValue','PostSet',@obj.postSetInitialValue);

        end

        function postSetDataType(obj,~,~)
            if ~isequal(obj.DataType,obj.EngDT.BaseType)
                obj.DataType = obj.EngDT.BaseType;
                beep;
                warning backtrace off
                warning('Change to NVM.DataType not accepted, please change EngDT instead.');
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
            end

            [enginit,~,~] = validateUserEngInit(obj.EngDT,obj,obj.EngInit);
            val = size(enginit);
            if ~isempty(val)
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
                warning('Direct changes to InitialValue aren''t allowed please change EngInit.');
            end

        end

        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'NVM');
                warning backtrace on
            end

            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')

            obj.DataType = obj.EngDT.BaseType;
            obj.EngInit = obj.EngInit;
        end

        function set.EngInit(obj,val)
            if isempty(val)
                obj.EngInit = val;
                
                if isempty(obj.InitRowCol)
                    obj.InitRowCol = [1 1];
                end
                
                if isa(obj.EngDT,'bt.struct')
                    valstring = Val2String(eval(obj.EngDT.InitString),obj.EngDT);
                else
                    valstring = '0';
                end
                
                coltxt = [];
                for j = 1:obj.InitRowCol(2)
                    coltxt = sprintf('%s %s',coltxt,valstring);
                end
                
                txt = coltxt;
                for i = 1:obj.InitRowCol(1)-1
                    txt = sprintf('%s;%s',txt,coltxt);
                end
                
                initvalue = sprintf('[%s]',txt);
                obj.InitialValue = initvalue;
                

            else
                [enginit,~,msg] = validateUserEngInit(obj.EngDT,obj,val);
                if ~strcmp(msg,'')
                    warning(msg,'NVM');
                end

                obj.EngInit = enginit;
                tempstr = [];

                obj.InitRowCol = size(obj.EngInit);

                for i = 1:obj.InitRowCol(1)

                    colstr = cell(1,obj.InitRowCol(2));
                    for j = 1:obj.InitRowCol(2)

                        if isa(obj.EngDT,'bt.struct')
                            colstr{j} = Val2String(obj.EngInit(i,j),obj.EngDT);
                        else
                            colstr{j} = num2str(obj.EngInit(i,j));
                        end

                    end

                    if i == obj.InitRowCol(1)
                        tempstr = sprintf('%s%s',tempstr, strjoin(colstr,','));
                    else
                        tempstr = sprintf('%s%s;',tempstr, strjoin(colstr,','));
                    end

                end

                obj.InitialValue = sprintf('[%s]',tempstr);
            end
        end

        function set.EngMin(obj,val)
            [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'NVM',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
            obj.Min = [];
        end

        function set.EngMax(obj,val)
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'NVM',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
            obj.Max = [];
        end

        function set.InitRowCol(obj,val)
            
            if isempty(obj.EngInit)
                if isa(obj.EngDT,'bt.struct')
                    obj.InitRowCol = val;
                    obj.EngInit = obj.EngInit;
                else
                    obj.InitRowCol = val;
                    obj.InitialValue = sprintf('[%s]',num2str(zeros(val)));
                end
            else
                obj.InitRowCol = size(obj.EngInit);
            end

        end

        function set.TuningOwner(obj,val)
            if strcmp(val,'Controls')
                warning('For NVM.TuningOwner ''Controls'' is no longer an accepted value for tuning owner. Instead of ''Controls'' please choose, ''CSE'', ''ThermMngt'', ''PwrMngt'', or ''TqCtrl''.');
                val = '?';
            end
            obj.TuningOwner = val;
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
            txt = sprintf('%s%s.EngInit = %s;\n', txt,var,Val2String(obj.EngInit));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,Val2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,Val2String(obj.EngMax));
%             txt = sprintf('%s%s.ProgrammedBy = ''%s'';\n', txt,var,obj.ProgrammedBy);
            if obj.CustomerVisible==1, txt = sprintf('%s%s.CustomerVisible = true;\n', txt,var);
            else                       txt = sprintf('%s%s.CustomerVisible = false;\n', txt,var);end;
            txt = sprintf('%s%s.Impact = ''%s'';\n', txt,var,obj.Impact);
            % txt = sprintf('%s%s.SafetyRating = ''%s'';\n', txt,var,obj.SafetyRating);
            txt = sprintf('%s%s.TuningOwner = ''%s'';\n', txt,var,obj.TuningOwner);
            %             txt = sprintf('%s%s.CoderInfo.Alias = ''%s'';\n', txt, var, obj.CoderInfo.Alias);
            txt = sprintf('%s%s.InitRowCol = %s;\n', txt, var, strcat('[',num2str(obj.InitRowCol),']'));
        end

    end % methods

end % classdef

%#ok<*MCSUP>
%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.

