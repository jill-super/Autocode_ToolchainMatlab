% DataDict.IpSignal
%  This script defines the data class of a Nexteer software component
%  input signal.  It includes the bare minimum amount of information to
%  cross-reference the fully-defined properties of that signal in its
%  source component.
%
%  There shall exist a master list of fully defined signals.  the master
%  list is created by collecting information about output signals from
%  every software component.  When developing a new or revised SWC,
%  information about each input signal is obtained by referencing the
%  master list.
%

%TODO:

% Change Log
% 06mar2014  K Derry    Initial Release
% 24mar2014  K Derry    New methods to provide list of legal property values
% 05jun2014  K Derry    Add EngDT, EngMin, EngMax, Datatype, Min, Max, ReqdResolution, LongName, and DocUnits properties & methods.
% 10jul2014  K Derry    Default EngDT changed from double to float32.
%                       Simplified output of String method for improved readability of data dictionaries.
% 29aug2014  K Derry    Increased number of significant digits in String method when writing EngMin, EngMax, ReqdResolution.
% 29sep2014  K Derry    New EngInit and InitialValue properties. ReqdResolution property renamed as Resolution.
%                       DocUnits can now start with lower case to avoid errors like uSec, mSec.
% 28oct2014  K Derry    Removed .Resolution property.
% 13nov2014  PLefler    ReadIn and ReadType properties added.
% 09jan2015  PLefler    Changed method for changing EngDT, EngMax, EngMin, EngInit.
%                       Added DataType propterty that is Hidden and Dependent and a get method for this property.
%                       Changed method for writing the EngMin and EngMax in the string method.
% 02feb2015  PLefler    Bug fixes.
% 05feb2015  PLefler    Changed String method so that EngDT and EngVal come before EngMin and EngMax.
% 20Apr2015  Siva       Enhancement: SafetyRating property has been turned off till we develop a robust ASIL management process(Issue no: 30).
% 21Mar2016  PLefler    Added Description property.
% 31Mar2016  Siva       Removed duplication of Description property.
% 12Sep2016  Siva       Bug fix for .ReadIn property.
%


classdef IpSignal < handle
    %% PROPERTIES
    
    %Observable properties that trigger code execution
    properties
        EngDT;  %Engineering DataType, derives .DataType property
        EngMin; %Engineering Minimum, unscaled, engineering units, derives .Min property
        EngMax; %Engineering Maximum, unscaled, engineering units, derives .Max property
        EngInit; %Engineering Initial Value, unscaled, engineering units, derives .InitialValue property
        LongName = '';        %Long name of signal.  e.g. Handwheel Torque
        DocUnits = '';        %Engineering Units (DocUnits is what Simulink calls it in other classes (e.g. Simulink.Signal)
        MinReqdASIL = '';     %Minimum required ASIL rating of incoming signal.
        ReadIn@cell;        %
        ReadType = 'Rte';
        Description@char;
    end
    
    properties ( Hidden , Dependent )
        DataType;
        Max;
        Min;
    end
    
    %% METHODS
    methods
        function obj = IpSignal(~)
            obj.EngDT    = dt.float32;
            obj.EngMin   = obj.EngDT.enMin;
            obj.EngMax   = obj.EngDT.enMax;
            obj.EngInit  = 0;
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
        
        function varargout = Valid(~)
            % Provides list of valid property values that can be used in verification tools.
            % output1 is structure of character arrays.  output2 is structure of cell arrays.
            varargout{1}.MinReqdASIL = [''''', ' 'QM, ' 'A, ' 'B, ' 'C, ' 'D'];
            varargout{2}.MinReqdASIL = {'',      'QM',  'A',  'B',  'C',  'D'};
        end
        
        function set.EngDT(obj,val)
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IpSignal');
                warning backtrace on
            end
            
            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')
            
        end
        
        function set.EngInit(obj,val)
            [enginit,~,msg] = validateUserEngInit(obj.EngDT,obj,val);
            obj.EngInit = enginit;
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IpSignal');
                warning backtrace on
            end
        end
        
        function set.EngMin(obj,val)
            [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IpSignal',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        function set.EngMax(obj,val)
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'IpSignal',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
            obj.EngInit = obj.EngInit;
        end
        
        function set.ReadType(obj,rqstval)
            if strcmp('Rte',rqstval) || strcmp('NonRte',rqstval) || strcmp('Phy',rqstval)
                obj.ReadType = rqstval;
            else
                obj.ReadType = obj.ReadType;
                warning off backtrace
                beep,warning('Unrecognized IpSignal.ReadType no change made in Workspace. Accepted values are; ''Rte'',''NonRte'',''Phy''');
                warning on backtrace
            end
            
        end
        
        function set.LongName(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('IpSignal.LongName property not changed because user entered a numeric value.')
                else
                    obj.LongName = rqstval;
                end
            end
        end
        
        function set.DocUnits(obj,rqstval)
            if ~isempty(rqstval)
                if isnumeric(rqstval)
                    warning off backtrace; warning('IpSignal.DocUnits property not changed because user entered a numeric value.')
                else
                    newval=regexprep(rqstval, '[~!@#$%^&*()-:;"''><,\.?\\ ]',''); %Remove illegal characters and spaces.
                    %               newval(1) = upper(newval(1));                                 %We know at least first letter should be capitalized.
                    if strcmp(rqstval,newval)
                        obj.DocUnits = newval;
                    else
                        msg = sprintf(['IpSignal.DocUnits property not changed because entry is invalid.\n' ...
                            ' Requested Value:\t' rqstval '\n Suggested Fix:  \t' newval]);
                        warning off backtrace; warning(msg)
                    end
                end
            end
        end
        
        function set.MinReqdASIL(obj,rqstval)
            if isnumeric(rqstval)
                warning off backtrace; warning('IpSignal.MinReqdASIL property not changed because user enterd a numeric value.')
            else
                [str,cel] = Valid(obj);
                if any(strcmp(rqstval,cel.MinReqdASIL))
                    obj.MinReqdASIL = rqstval;
                else
                    msg = sprintf(['IpSignal.MinReqdASIL property not changed because entry is invalid.\n' ...
                        ' Requested Value:\t' '''' rqstval '''\n' ...
                        ' Allowed values: \t' str.MinReqdASIL]);
                    warning off backtrace; warning(msg)
                end
            end
        end
        
        %         function set.ReadIn(obj,rqstval)
        %             if((iscellstr(rqstval)) && (isempty(rqstval)))
        %                 obj.ReadIn = {''};
        %                 warning off backtrace;
        %                 warning('IpSignal.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
        %             else
        %                 %                 disp(rqstval);
        %                 %                 readin = '';
        %                 %                 for i = 1:size(obj.ReadIn,2)
        %                 %                     readin = sprintf('%s''%s''',readin,obj.ReadIn{i});
        %                 %                     if i ~= size(obj.ReadIn,2)
        %                 %                         readin = sprintf('%s,',readin);
        %                 %                     end
        %                 %                 end
        %                 %                 readin = '{';
        %                 %                 for i = 1:size(rqstval,2)
        %                 %                     if(i == 1)
        %                 %                         readin = sprintf('%s',rqstval{i}); %#ok<*AGROW>
        %                 %                     else
        %                 %                         readin = sprintf('%s,',readin);
        %                 %                         readin = sprintf('%s,%s',readin,rqstval{i});
        %                 %                     end
        %                 %                 end
        %                 %                 ind = 1;
        %                 %                 for i = 1:size(rqstval,2)
        %                 %                     if(i == 1)
        %                 %                         readin{ind} = rqstval{i}; %#ok<*AGROW>
        %                 %                         ind = ind + 1;
        %                 %                     else
        %                 %                         readin{ind} = ',';
        %                 %                         ind = ind + 1;
        %                 %                         readin{ind} = rqstval{i};
        %                 %                         ind = ind + 1;
        %                 %                     end
        %                 %                 end
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
        %                         warning('IpSignal.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
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
        
        % New way of implementation
        function set.ReadIn(obj,rqstval)
            if((iscellstr(rqstval)) && (isempty(rqstval)))
                obj.ReadIn = {''};
                warning off backtrace;
                warning('IpSignal.ReadIn property should be a group of Runnables. Ex: {''MotVelPer1'',''MotVelPer2''}.')
            else 
                obj.ReadIn = rqstval;
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
            txt = sprintf('%s%s.EngDT = %s;\n', txt,var,class(obj.EngDT));
            txt = sprintf('%s%s.EngInit = %s;\n', txt,var,Val2String(obj.EngInit));
            txt = sprintf('%s%s.EngMin = %s;\n', txt,var,MinMax2String(obj.EngMin));
            txt = sprintf('%s%s.EngMax = %s;\n', txt,var,MinMax2String(obj.EngMax));
            %             txt = sprintf('%s%s.MinReqdASIL = ''%s'';\n', txt,var,obj.MinReqdASIL);
            
            switch flag
                case 'ea3'
                    
                case 'ea4'
                    readin = '';
                    for i = 1:size(obj.ReadIn,2)
                        readin = sprintf('%s''%s''',readin,obj.ReadIn{i});
                        if i ~= size(obj.ReadIn,2)
                            readin = sprintf('%s,',readin);
                        end
                    end
                    txt = sprintf('%s%s.ReadIn = {%s};\n', txt,var,readin);
                    %                     txt = sprintf('%s%s.ReadIn = {''%s''};\n', txt,var,obj.ReadIn{:});
                    txt = sprintf('%s%s.ReadType = ''%s'';\n',txt,var,obj.ReadType);
            end
        end
        
    end % methods
    
end % classdef
%#ok<*MCSUP>
%#ok<*MCNPR>