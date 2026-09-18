% DataDict.CSArguments
% This data class is used for DataDict.SrvRunnable and DataDict.Client classes.

%Change Log
% 09jan2015  PLefler     Initial Release
% 20mar2015  PLefler     Added 'InOut' and 'InPtr' to list of acceptable values for Direction.
% 31Mar2015  Siva        Added functionality to support CSArgument signals with an array of zero initializations if user needs.
% 26Jan2016  PLefler     Fixed bug in String function where structures were not written correctly.
% 21Mar2016  PLefler     Changed order that the properties in the String method are written so that EngDT is written before the EngMin and EngMax are written.    
%                        Added Description property.
% 13Apr2015  Siva        Added logic to supress the unnecessary warnings.
% 02Jun2016  Siva        Added new .TestTolerance Property.

classdef CSArguments < handle
    
    properties
        Name@char;
        EngDT;
        EngMin;
        EngMax;
        TestTolerance = 999;
        Units@char;
        Direction@char;
        InitRowCol;
        Description@char;
    end
    
    methods
        function obj = CSArguments(~)
            obj.Name = '';
            obj.EngDT = dt.float32;
            obj.EngMin = obj.EngDT.enMin;
            obj.EngMax = obj.EngDT.enMax;
            obj.Units = '';
            obj.Direction = '';
            obj.InitRowCol = [1 1];
            obj.Description = '';
        end
        
        function set.EngDT(obj,val)
            %Include checking to make sure the EngDT is recognized.
            [obj.EngDT,msg] = validateUserEngDT(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'CSArguments');
                warning backtrace on
            end
			
            warning('off','all')
            obj.EngMin = obj.EngMin;
            obj.EngMax = obj.EngMax;
            warning('on','all')
        end
        
        function set.Direction(obj,val)
            switch val
                case {'In','Out','InOut','InPtr'}
                    obj.Direction = val;
                case ''
                    obj.Direction = obj.Direction;
                otherwise
                    obj.Direction = obj.Direction;
                    warning off backtrace
                    warning('CSArguments.Direction not recognized no change made in Workspace.')
                    warning on backtrace
            end
            
        end
        
        function set.EngMin(obj,val)
            [obj.EngMin,~,msg] = validateUserEngMin(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'CSArguments',MinMax2String(obj.EngMin)); %#ok<CTPCT>
                warning backtrace on
            end
        end
        
        function set.EngMax(obj,val)
            [obj.EngMax,~,msg] = validateUserEngMax(obj.EngDT,val);
            if ~strcmp(msg,'')
                warning backtrace off
                warning(msg,'CSArguments',MinMax2String(obj.EngMax)); %#ok<CTPCT>
                warning backtrace on
            end
        end
        
        function set.TestTolerance(obj,rqstval)
            if isempty(rqstval) || (isnumeric(rqstval) && (rqstval>=0))
                obj.TestTolerance = rqstval;
            else
                msg = 'CSArguments.TestTolerance property not changed.  Entry must be a positive number.';
                warning off backtrace; warning(msg)
            end
        end
        
        function set.InitRowCol(obj,val)
            obj.InitRowCol = val;
        end
        
        function txt = String(obj)
            arg = inputname(1);
            txt = sprintf('%s.Arguments(n).Name = ''%s'';\n',arg,obj.Name);
            txt = sprintf('%s%s.Arguments(n).EngDT = %s;\n',txt,arg,class(obj.EngDT));
            txt = sprintf('%s%s.Arguments(n).EngMin = %s;\n', txt,arg,Val2String(obj.EngMin));
            txt = sprintf('%s%s.Arguments(n).EngMax = %s;\n', txt,arg,Val2String(obj.EngMax));
            if((strcmp(obj.Direction,'Out')) || (strcmp(obj.Direction,'InOut')))
                txt = sprintf('%s%s.Arguments(n).TestTolerance = %0.10g;\n', txt,arg,obj.TestTolerance);
            end            
            txt = sprintf('%s%s.Arguments(n).Units = ''%s'';\n',txt,arg,obj.Units);
            txt = sprintf('%s%s.Arguments(n).Direction = ''%s'';\n',txt,arg,obj.Direction);
            txt = sprintf('%s%s.Arguments(n).InitRowCol = %s;\n', txt,arg,strcat('[',num2str(obj.InitRowCol),']'));
            dsc = WriteDescription(arg, obj.Description);
            txt = sprintf('%s%s.Arguments(n).%s\n', txt,arg,dsc(5:end)); %using (5:end) to remove 'arg.' from the string that comes out of WriteDescription.
            
        end
    end
    
end
%#ok<*MCSUP>
