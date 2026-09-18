% DataDict.Calibration
% This script defines the data class required for Nexteer calibrations.

% Change Log
% 03feb2014 K Derry    Initial Release
% 26feb2014 K Derry    Suppress warnings during callbacks.
% 21mar2014 K Derry    Set default values for CoderInfo properties
%                      Warning of vertical vectors for EngVal and Value
%                      Tune On The Fly (TOTF) property renamed Online per AUTOSAR
% 15apr2014 K Derry    Improved robustness when setting EngVal same as EngMin or EngMax, especially when data type is float32
%                      Suppress warnings about value < min and value > max
% 15may2014 K Derry    Changed default value of HeaderFile property from 'CalConst.h' to 'CalConstants.h'
%                      Changed default value of DefinitionFile prpoerty from 'Partial_CalConst.c' to 'swc_CalConstatns.c'
% 03jun2014 K Derry    Fixed typo in .DefinitionFile property.
% 11jul2014 K Derry    New method named String.  Default EngDT changed from double to float32.
%                      New LongName property.
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngVal, EngMin, EngMax, ReqdResolution, and MaxGrad.
%                      Uses new ValidateEngDT, ValidateEngVal, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 20sep2014 K Derry    Removed ReqdResolution property.  Separated part of String method into separate EngValString method callable by other tools.
% 28oct2014 K Derry    Commented out CoderInfo to simplify data dictionaries.
% 09jan2015 PLefler    Changed base class that DataDict.Calibration inherits from mpt.Parameter to AUTOSAR.Parameter.
%                      Changed method for changing EngDT, EngVal, EngMin, EngMax.
%                      Changed String method to accomdate EA3 vs. EA4 CreateDD
%                      Created logic to prevent Value and DataType properties from being changed.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 20Apr2015 Siva       Enhancement: SafetyRating property has been turned off till we develop a robust ASIL management process(Issue no: 30).
% 10July2015 Siva      Updated String method to populate .PortName in EA4 DD.
% 31July2015 Siva      Replaced "Controls" choice with three new choices for .TuningOwner property(Issue no: 53).
% 30Sep2015 PLefler    Changed GraphLink to be a cell array and created the logic to convert the old style to the new style.    
%                      Made default value for MaxGrad to Inf.
%                      Set the ProgrammedBy property to be hidden.
%                      For the TuningOwner property logic was added to prevent 'Controls' from being set as the assigned value. 
% 20Oct2015 PLefler    Changed default value for ProgrammedBy property from '?' to 'Nexteer'.
%                      Fixed list of AllowedValues for Cardinality and warning message from Init to Inin.  
%                      Fixed warning message for TuningOwner selection to say Calibration.TuningOwner instead of NVM.TuningOwner. 
% 13Jan2015 PLefler    Added Logl as a posibility for Element Name in the CoderInfo property. 

classdef Calibration < AUTOSAR.Parameter

    %Observable properties that trigger code execution
    properties (SetObservable )
        EngVal %Engingeering Value, unscaled, engineering units, derives .Value property
        EngDT  %Engineering DataType, derives .DataType property
        EngMin %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax %Engineering Maximum, unscaled, engineering units, derives .Max property
        GraphLink = {''}  % Identifies table relationships for plotting (e.g. X1 pairs with Y1)
    end

    %Other properties
    % Monotony (e.g. X-tables usually must be Strictly_Increasing)
    properties(PropertyType = 'char',...
            AllowedValues = {'?'; 'None'; 'Increasing'; 'Strictly_Increasing'; 'Decreasing'; 'Strictly_Decreasing'});
        Monotony = '?';  % Rule applies to tables only
    end

    % Max_Grad (max allowable slope in a table)
    properties(PropertyType = 'double scalar')
        MaxGrad = Inf;  % Maximum allowable slope in a table
    end

    % Programmed By (At what location does the final value get written?)
    properties(Hidden,PropertyType = 'char',...
            AllowedValues = {'?'; 'Supplier'; 'Nexteer'; 'Customer'});
        ProgrammedBy = 'Nexteer';  % Supplier, Nexsteer, or Customer
    end

    % Cardinality (e.g. Program = one value for all vehicle variants)
    properties(PropertyType = 'char',...
            AllowedValues = {'?'; 'N'; 'I'; 'R'; 'Cmn';'Inin';'Rt'}); %
        Cardinality = '?';  % Non-, Init-, or Runtime- selectable
    end

    % Safety Rating
    properties(PropertyType = 'char',...
            AllowedValues = {'?'; 'A'; 'B'; 'C'; 'D'; 'QM'; 'n/a'});
        SafetyRating = '?';  % ASIL rating
    end

    % Impact (sensitivity of other cals to this cal)
    properties(PropertyType = 'char', ...
            AllowedValues = {'?'; 'L';'M';'H'});
        Impact = '?';        % Low, Medium, High
    end

    %Group Owner (Of 'Value' and 'CustomerVisible' properties only.  Other properties per blanket ownership rules)
    properties(PropertyType = 'char',...
            AllowedValues = {'?'; 'CSE'; 'Safety'; 'Controls'; 'EPDT'; 'FDD'; 'ThermMngt'; 'PwrMngt'; 'TqCtrl';});
        TuningOwner = '?';      % CSE - owns values even when tuned by customer
    end

    % Boolean properties
    properties(PropertyType = 'logical scalar')
        CustomerVisible = false; % true means the cal should be included in customer project files
        Online          = false; % Tune On The Fly.  true means online RAM tuning
    end

    % Impact (Relative effect that changes to this cal have on other cal values)
    properties(PropertyType = 'char');
        LongName = '';
        PortName = '';
    end


    %% METHODS

    methods

        function obj = Calibration(~)

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
            elseif isa(obj.EngDT,'dt.lgc')
                obj.CoderInfo.CustomAttributes.ElementName = 'Logl';
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
        
        function set.Cardinality(obj,val)
            switch val
                case {'N' 'Cmn'}
                    val = 'Cmn';
                case {'I' 'Inin'}
                    val = 'Inin';
                case {'R' 'Rt'}
                    val = 'Rt';
                otherwise
                    error('Unexpected input for the Cardinality property. Expected input values are ''Cmn'', ''Inin'' and ''Rt''.');
            end
            obj.Cardinality = val;
        end
        
        function set.TuningOwner(obj,val)
            if strcmp(val,'Controls')
                warning('For Calibration.TuningOwner ''Controls'' is no longer an accepted value for tuning owner. Instead of ''Controls'' please choose, ''CSE'', ''ThermMngt'', ''PwrMngt'', or ''TqCtrl''.');
                val = '?';
            end
            obj.TuningOwner = val;
        end
        
        function set.GraphLink(obj,val)
            if ischar(val)
                obj.GraphLink = strsplit(val,',');
                warning('Calibration.GraphLink has been updated to new standards please check the new format to ensure no errors have occurred.')
            elseif iscell(val)
                if isempty(val)
                    obj.GraphLink = val;
                elseif ~any(cellfun(@ischar,val))
                    error('For Calibration.GraphLink each element in the cell array must be a string.');
                else
                    obj.GraphLink = val;
                end
                
            else
                error('Unknown Calibration.GraphLink input type. Please provide a cell of array strings. For example TblCalY.GraphLink = {''TblCalX'',''TblCalBilnrSeln''};')
            end
        end

        function txt = String(obj,flag)
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
            txt = sprintf('%s%s.EngVal = %s;\n', txt, var ,Val2String(obj.EngVal));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,Val2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,Val2String(obj.EngMax));
            % txt = sprintf('%s%s.ProgrammedBy = ''%s'';\n', txt,var,obj.ProgrammedBy);
            txt = sprintf('%s%s.Cardinality = ''%s'';\n', txt,var,obj.Cardinality);
            if obj.CustomerVisible==1, txt = sprintf('%s%s.CustomerVisible = true;\n', txt,var);
            else                       txt = sprintf('%s%s.CustomerVisible = false;\n', txt,var);end;
            if obj.Online==1, txt = sprintf('%s%s.Online = true;\n', txt,var);
            else              txt = sprintf('%s%s.Online = false;\n', txt,var);end;
            txt = sprintf('%s%s.Impact = ''%s'';\n', txt,var,obj.Impact);
            %             txt = sprintf('%s%s.SafetyRating = ''%s'';\n', txt,var,obj.SafetyRating);
            txt = sprintf('%s%s.TuningOwner = ''%s'';\n', txt,var,obj.TuningOwner);
            
            tempstr = '';
            for i = 1:length(obj.GraphLink)
                tempstr = sprintf('%s''%s''',tempstr,obj.GraphLink{i});
                if i ~= length(obj.GraphLink)
                    tempstr = sprintf('%s,',tempstr);
                end
            end
            
            txt = sprintf('%s%s.GraphLink = {%s};\n', txt,var,tempstr);
            txt = sprintf('%s%s.Monotony = ''%s'';\n', txt,var,obj.Monotony);
            txt = sprintf('%s%s.MaxGrad = %0.10g;\n', txt,var,obj.MaxGrad);

            switch flag
                case 'ea3'
                    txt = sprintf('%s%s.CoderInfo.Alias = ''%s'';\n', txt, var, obj.CoderInfo.Alias);
                case 'ea4'
                    txt = sprintf('%s%s.PortName = ''%s'';\n', txt,var,obj.PortName);
                    %                     txt = sprintf('%s%s.CoderInfo.CustomAttributes.PortName = ''%s'';\n', txt, var, obj.CoderInfo.CustomAttributes.PortName);
                otherwise
                    error('Known EA# flag passed to String method');

            end
        end

    end % methods

end
%#ok<*ATUNK> This comment suppresses warnings. Do not uncomment or delete.
%#ok<*MCSUP>
