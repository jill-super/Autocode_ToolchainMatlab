% DataDict.OpSignal
%  This script defines the data class of a Nexteer software component
%  output signal.
%

%TODO:

% Change Log
% 07mar2014 K Derry    Initial Release, replaces DataDict.Signal (26feb2014)
% 14mar2014 K Derry    New methods to provide list of legal property values
% 10apr2014 K Derry    Bug fix in String method that occured when .Description was a certain length.  Method was parsing into multi-line incorrectly.
% 05jun2014 K Derry    Added LongName, EngInit, and InitialValue properties
% 10jul2014 K Derry    Rearranged order of properties in String method to improve readability of data dictionaries.
%                      Default EngDT changed from double to float32.
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngInit, EngMin, EngMax, ReqdResolution.
%                      Uses new ValidateEngDT, ValidateEngInit, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 29sep2014 K Derry    Rearranged String method commands.  Writing EngInit before EngMin and EngMax.
%                      ReqdResolution property renamed as Resolution. SwCName property renamed as SwcShoName
%                      DocUnits can now start with lower case to avoid errors like uSec, mSec.
% 28oct2014 K Derry    Renamed Resolution to TestTolerance
% 13nov2014 PLefler    Added WrittenIn and WriteType property.
% 26Dec2014 Siva       Bug fix: Fixed issue related to SwcShoName property for having numbers in the SWC short name. (Issue no: 12).
% 09jan2015 PLefler    Added DataType propterty that is Hidden and Dependent and a get method for this property.
%                      Changed method for changing EngDT, EngMax, EngMin, EngInit.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 02feb2015 PLefler    Bug fixes.
% 12Sep2016 Siva       Bug fix for .WrittenIn property.
%


classdef OpSignal < handle
    %% PROPERTIES
    
    %Observable properties that trigger code execution
    properties
        EngDT  %Engineering DataType, derives .DataType property
        EngMin %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngInit %Engineering Initial Value, unscaled, engineering units, derives .InitialValue property
        TestTolerance = 999;     %Allowable difference between code and model
        LongName = '';        %Long name of signal.  e.g. Handwheel Torque
        SwcShoName = '';      %Sofware Component Short Name
        Description = '';
        DocUnits = '';        %Engineering Units (DocUnits is what Simulink calls it in other classes (e.g. Simulink.Signal)
        WrittenIn@cell;
        WriteType = 'Rte';
    end
    
    properties ( Hidden , Dependent )
        DataType;
        Max;
        Min;
    end
    
    %% METHODS
    methods
        function obj = OpSignal(~)
            obj.EngDT    = dt.float32;
            obj.EngMin   = obj.EngDT.enMin;
            obj.EngMax   = obj.EngDT.enMax;
            obj.EngInit  = 0;
        end
        
        function varargout = Valid(~)
            % Provides list of valid property values that can be used in verification tools.
            % output1 is structure of character arrays.  output2 is structure of cell arrays.
            varargout{1} = ['There are no lists to display for the OpSignal class.'];
            varargout{2} = {'There are no lists to display for the OpSignal class.'};
        end
        
        function val = get.DataType(obj)
            val = obj.EngDT;
        end
        
        function val = get.Max(obj)
            val = obj.EngMax*obj.EngDT.dtScl;
        end
        
        function val = get.Min(obj)
            val = obj.EngMin*obj.EngDT.dtScl;
        end
        
        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'OpSignal');
                warning backtrace on
            end
            
            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')
            
        end
        
        function set.EngInit(obj,val)
            [enginit,~,msg] = validateUserEngInit(obj.EngDT,obj,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'OpSignal');
                warning backtrace on
            end
            obj.EngInit = enginit;
        end
        
        function set.EngMin(obj,val)
            [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'OpSignal',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        function set.EngMax(obj,val)
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'OpSignal',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        function set.WriteType(obj,rqstval)
            if strcmp('Rte',rqstval) || strcmp('NonRte',rqstval) || strcmp('Phy',rqstval)
                obj.WriteType = rqstval;
            else
                obj.WriteType = obj.WriteType;
                warning backtrace off
                beep,warning('Unrecognized WriteType no change made in Workspace. Accepted values are; ''Rte'',''NonRte'',''Phy''');
                warning backtrace on
            end
        end
        
        function set.TestTolerance(obj,rqstval)  %#ok<*MCSV,*MCHC,*MCHV2>
            if isempty(rqstval) || (isnumeric(rqstval) && (rqstval>=0))
                obj.TestTolerance = rqstval;
            else
                msg = 'OpSignal.TestTolerance property not changed.  Entry must be a positive number.';
                warning off backtrace; warning(msg)
            end
        end
        
        function set.LongName(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('OpSignal.LongName property not changed because user entered a numeric value.')
                else
                    obj.LongName = rqstval;
                end
            end
        end
        
        function set.SwcShoName(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('OpSignal.SwcShoName property not changed because user entered a numeric value.')
                else
                    newval=regexprep(rqstval, '[~!@#$%^&*()_\-:;"''><,\.?\\ ]',''); %Remove illegal characters and spaces.
                    newval(1) = upper(newval(1));                                 %We know at least first letter should be capitalized.
                    if strcmp(rqstval,newval)
                        obj.SwcShoName = newval;
                    else
                        msg = sprintf(['OpSignal.SwcShoName property not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' rqstval '\n Suggested Fix:  \t' newval]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end
        
        function set.DocUnits(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('OpSignal.DocUnits property not changed because user entered a numeric value.')
                else
                    newval=regexprep(rqstval, '[~!@#$%^&*()-:;"''><,\.?\\ ]',''); %Remove illegal characters and spaces.
                    %               newval(1) = upper(newval(1));                                 %We know at least first letter should be capitalized.
                    if strcmp(rqstval,newval)
                        obj.DocUnits = newval;
                    else
                        msg = sprintf(['OpSignal.DocUnits property not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' rqstval '\n Suggested Fix:  \t' newval]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end
        
        %         function set.WrittenIn(obj,rqstval)
        %             if((iscellstr(rqstval)) && (isempty(rqstval)))
        %                 obj.WrittenIn = {''};
        %                 warning off backtrace;
        %                 warning(['OpSignal.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.'])
        %             else
        %                 %                 disp(rqstval);
        %                 %                 writtenin = '';
        %                 %                 for i = 1:size(obj.WrittenIn,2)
        %                 %                     writtenin = sprintf('%s''%s''',writtenin,obj.WrittenIn{i});
        %                 %                     if i ~= size(obj.WrittenIn,2)
        %                 %                         writtenin = sprintf('%s,',writtenin);
        %                 %                     end
        %                 %                 end
        %                 %                 writtenin = '{';
        %                 %                 for i = 1:size(rqstval,2)
        %                 %                     if(i == 1)
        %                 %                         writtenin = sprintf('%s',rqstval{i}); %#ok<*AGROW>
        %                 %                     else
        %                 %                         writtenin = sprintf('%s,',writtenin);
        %                 %                         writtenin = sprintf('%s,%s',writtenin,rqstval{i});
        %                 %                     end
        %                 %                 end
        %                 %                 ind = 1;
        %                 %                 for i = 1:size(rqstval,2)
        %                 %                     if(i == 1)
        %                 %                         writtenin{ind} = rqstval{i}; %#ok<*AGROW>
        %                 %                         ind = ind + 1;
        %                 %                     else
        %                 %                         writtenin{ind} = ',';
        %                 %                         ind = ind + 1;
        %                 %                         writtenin{ind} = rqstval{i};
        %                 %                         ind = ind + 1;
        %                 %                     end
        %                 %                 end
        %                 writeinnew{1} = [];
        %                 vldflg = 0;
        %                 for a = 1:size(rqstval,2)
        %                     if(~isempty(rqstval{a}))
        %                         if(a == 1)
        %                             writtenin = sprintf('%s''',rqstval{a});
        %                         else if(a == size(rqstval,2))
        %                                 writtenin = sprintf('%s,',writtenin);
        %                                 writtenin = sprintf('%s%s',writtenin,sprintf('''%s',rqstval{a}));
        %                             else
        %                                 writtenin = sprintf('%s,',writtenin);
        %                                 writtenin = sprintf('%s%s',writtenin,sprintf('''%s''',rqstval{a}));
        %                             end
        %                         end
        %                         vldflg = 1;
        %                     else
        %                         warning off backtrace;
        %                         warning(['OpSignal.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.'])
        %                     end
        %                 end
        %                 if(vldflg)
        %                     writeinnew{1} = writtenin;
        %                     obj.WrittenIn = writeinnew;
        %                 else
        %                     obj.WrittenIn = rqstval;
        %                 end
        %             end
        %         end
        
        % New way of implementation
        function set.WrittenIn(obj,rqstval)
            if((iscellstr(rqstval)) && (isempty(rqstval)))
                obj.WrittenIn = {''};
                warning off backtrace;
                warning(['OpSignal.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.'])
            else
                obj.WrittenIn = rqstval;
            end
        end
        
        function txt = String(obj,flag)
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            txt = sprintf('%s%s.LongName = ''%s'';\n', txt,var,obj.LongName);
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.SwcShoName = ''%s'';\n', txt,var,obj.SwcShoName);
            txt = sprintf('%s%s.EngDT = %s;\n', txt,var,class(obj.EngDT));
            txt = sprintf('%s%s.EngInit = %s;\n', txt,var,Val2String(obj.EngInit));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            txt = sprintf('%s%s.TestTolerance = %0.10g;\n', txt,var,obj.TestTolerance);
            
            switch flag
                case 'ea3'
                    
                case 'ea4'
                    writtenin = '';
                    for i = 1:size(obj.WrittenIn,2)
                        writtenin = sprintf('%s''%s''',writtenin,obj.WrittenIn{i});
                        if i ~= size(obj.WrittenIn,2)
                            writtenin = sprintf('%s,',writtenin);
                        end
                    end
                    txt = sprintf('%s%s.WrittenIn = {%s};\n',txt,var,writtenin);
                    %                     txt = sprintf('%s%s.WrittenIn = {''%s''};\n',txt,var,obj.WrittenIn{:});
                    txt = sprintf('%s%s.WriteType = ''%s'';\n',txt,var,obj.WriteType);
            end
        end
        
    end % methods
    
end % classdef
%#ok<*MCSUP>
