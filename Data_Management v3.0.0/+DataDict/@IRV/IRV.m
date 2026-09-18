% DataDict.IRV
% This script defines the data class required for Nexteer Inter Runnable Variable.

% Change Log
% 10jun2014 K Derry    Initial Release
% 09jul2014 K Derry    Add EngInit property and method of scaling to InitialValue.  Add String method.
%                      Default EngDT changed from double to float32.
% 01sep2014 K Derry    Increased number of significant digits in String method when writing EngInit, EngMin, EngMax.
%                      Uses new ValidateEngDT, ValidateEngInit, ValidateEngMin, ValidateEngMax functions.
%                      Uses new WriteDescription function in String method.
% 09jan2015 PLefler    Methods to prevent user from changing DataType and InitValue properties have been added.
%                      Changed methods for changing EngDT, EngMax, EngMin, EngInit.
%                      Changed method for writing the EngMin and EngMax in the string method.
% 12Sep2016  Siva      Bug fix for .ReadIn & .WrittenIn properties.
%

classdef IRV < AUTOSAR.Signal
    %% PROPERTIES
    properties (SetObservable)
        EngDT   %Engineering DataType, derives .DataType property
        EngMin  %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax  %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngInit %Engineering Initial value, unscaled, engineering units, derives .InitialValue property
        ReadIn = {''};
        WrittenIn = {''};
    end
    
    properties
        LongName = '';
    end
    
    
    %% METHODS
    methods
        function obj = IRV(~)
            obj.EngDT  = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.EngInit= 0;
            
            addlistener(obj,'DataType','PostSet',@obj.postSetDataType);
            addlistener(obj,'InitialValue','PostSet',@obj.postSetInitialValue);
            
        end
        
        function postSetDataType(obj,~,~)
            if ~isequal(obj.DataType,obj.EngDT.BaseType)
                obj.DataType = obj.EngDT.BaseType;
                beep;
                warning backtrace off
                warning('Change to IRV.DataType not accepted, please change EngDT instead.');
                warning backtrace on
            end
        end
        
        function postSetInitialValue(obj,~,~)
            [~,scaledval] = validateUserEngInit(obj.EngDT,obj,obj.EngVal);
            if ~isequal(scaledval,obj.InitialValue)
                obj.InitialValue = scaledval;
                warning backtrace off
                warning('Change to IRV.InitialValue not accepted, please change EngVal instead.');
                warning backtrace on
            end
        end
        
        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IRV');
                warning backtrace on
            end
            
            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')
            
            obj.DataType = obj.EngDT.BaseType;
        end
        
        function set.EngInit(obj,val)
            [enginit,~,msg] = validateUserEngInit(obj.EngDT,obj,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IRV');
                warning backtrace on
            end
            obj.EngInit = enginit;
        end
        
        function set.EngMin(obj,val)
            [obj.EngMin,obj.Min,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IRV',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        function set.EngMax(obj,val)
            [obj.EngMax,obj.Max,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IRV',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        %         function set.ReadIn(obj,rqstval)
        %             if((iscellstr(rqstval)) && (isempty(rqstval)))
        %                 obj.ReadIn = {''};
        %                 warning off backtrace;
        %                 warning('IRV.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
        %             else
        %                 readinnew{1} = [];
        %                 vldflg = 0;
        %                 for a = 1:size(rqstval,2)
        %                     if(~isempty(rqstval{a}))
        %                         if(a == 1)
        %                             readin = sprintf('%s''',rqstval{a});
        %                         else if(a == size(rqstval,2))
        %                                 readin = sprintf('%s,',readin);
        %                                 readin = sprintf('%s%s',readin,sprintf('''%s',rqstval{a}));
        %                             else
        %                                 readin = sprintf('%s,',readin);
        %                                 readin = sprintf('%s%s',readin,sprintf('''%s''',rqstval{a}));
        %                             end
        %                         end
        %                         vldflg = 1;
        %                     else
        %                         warning off backtrace;
        %                         warning('IRV.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
        %                     end
        %                 end
        %                 if(vldflg)
        %                     readinnew{1} = readin;
        %                     obj.ReadIn = readinnew;
        %                 else
        %                    obj.ReadIn = rqstval;
        %                 end
        %             end
        %         end
        %
        %         function set.WrittenIn(obj,rqstval)
        %             if((iscellstr(rqstval)) && (isempty(rqstval)))
        %                 obj.WrittenIn = {''};
        %                 warning off backtrace;
        %                 warning('IRV.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
        %             else
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
        %                         warning('IRV.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
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
        function set.ReadIn(obj,rqstval)
            if((iscellstr(rqstval)) && (isempty(rqstval)))
                obj.ReadIn = {''};
                warning off backtrace;
                warning('IRV.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
            else
                obj.ReadIn = rqstval;
            end
        end
        
        function set.WrittenIn(obj,rqstval)
            if((iscellstr(rqstval)) && (isempty(rqstval)))
                obj.WrittenIn = {''};
                warning off backtrace;
                warning('IRV.WrittenIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
            else
                obj.WrittenIn = rqstval;
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
            txt = sprintf('%s%s.EngInit = %s;\n', txt,var,Val2String(obj.EngInit));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            
            readin = '';
            for i = 1:size(obj.ReadIn,2)
                readin = sprintf('%s''%s''',readin,obj.ReadIn{i});
                if i ~= size(obj.ReadIn,2)
                    readin = sprintf('%s,',readin);
                end
            end
            txt = sprintf('%s%s.ReadIn = {%s};\n', txt,var,readin);
            %             txt = sprintf('%s%s.ReadIn = {''%s''};\n', txt,var,obj.ReadIn{:});
            
            writtenin = '';
            for i = 1:size(obj.WrittenIn,2)
                writtenin = sprintf('%s''%s''',writtenin,obj.WrittenIn{i});
                if i ~= size(obj.WrittenIn,2)
                    writtenin = sprintf('%s,',writtenin);
                end
            end
            txt = sprintf('%s%s.WrittenIn = {%s};\n',txt,var,writtenin);
            %             txt = sprintf('%s%s.WrittenIn = {''%s''};\n',txt,var,obj.WrittenIn{:});
            
        end
        
    end % methods
end % classdef

%#ok<*MCSUP>
%#ok<*ATUNK> This comment suppresses warnings.  Do not uncomment or delete.
