% DataDict.CSReturn
% Data Class used to communicate the data type, range and test tolerance of return from a function.

% Change Log:
% 21May2015  Siva    Added help section
% 05Jun2015  Siva    Bug fix: Updated string method to generate Return Parameter Name in Data Dictionary.
% 19Jun2015  Siva    Removed .Name property from string method.
% 21Mar2016 PLefler  Added Description property.
% 29Apr2016  Siva    Added logic to remove .Description property when Return Type is "None".
% 03Apr2017  Siva    Added support to include AUTOSAR specified return types.

classdef CSReturn < handle
    
    properties
        Name@char;
        Type
        Min
        Max
        TestTolerance
        Description@char
    end
    
    methods
        function obj = CSReturn(~)
            obj.Name = '';
            obj.Type = 'None';
            obj.Min = [];
            obj.Max = [];
            obj.TestTolerance = [];
        end
        
        function set.Type(obj,val)
            meta = metaclass(val);
            name = meta.Name;
            if isempty(meta.ContainingPackage)
                if strcmp('char',name)
                    switch val
                        case {'None','Standard'}
                            obj.Name = obj.Name;
                            obj.Type = val;
                            obj.Min = obj.Min;
                            obj.Max = obj.Max;
                            obj.TestTolerance = obj.TestTolerance;
                        otherwise                            
                            [miscpah, ~] = NxtrToolsPahFindr('Miscellaneous');
                            RtnTypInfo = NxtrXlsRead(miscpah,'RtnTyp');
                            if(~isempty(RtnTypInfo))
                                rtntypsize = size(RtnTypInfo);
                                for a = 2:rtntypsize(1)
                                    if(strcmp(RtnTypInfo{a,1},val))
                                        obj.Name = obj.Name;
                                        obj.Type = val;
                                        obj.Min = RtnTypInfo{a,2};
                                        obj.Max = RtnTypInfo{a,3};
                                        obj.TestTolerance = obj.TestTolerance;
                                        break;
                                    end
                                end
                            else
                                error('Unknown CSReturn.Type input string value. Accepted strings are ''None'' or ''Standard'' or ''Autosar based Valid Return Types''.');
                            end
                    end
                end
            elseif strcmp('bt',meta.ContainingPackage.Name)
                switch name
                    case {'bt.double','bt.struct','bt.structelement'}
                        error('Unknown CSReturn.Type base type value. Accepted values are ''bt.sint8'', ''bt.sint16'', ''bt.sint32'', ''bt.uint8'', ''bt.uint16'', ''bt.uint32'', ''bt.boolean'' and ''bt.single''');
                    otherwise
                        obj.Type = val;
                        obj.Min = obj.Min;
                        obj.Max = obj.Min;
                        obj.TestTolerance = obj.TestTolerance;
                end
            else
                error('Unknown CSRturn.Type input value.');
            end
        end
        
        function set.Min(obj,val)
            meta = metaclass(obj.Type);
            if strcmp('char',meta.Name)
                type = obj.Type;
            else
                type = '';
            end
            switch type
                case 'None'
                    obj.Min = [];
                case 'Standard'
                    obj.Min = 0;
                otherwise
                    [miscpah, ~] = NxtrToolsPahFindr('Miscellaneous');
                    RtnTypInfo = NxtrXlsRead(miscpah,'RtnTyp');
                    if(~isempty(RtnTypInfo))
                        rtntypsize = size(RtnTypInfo);
                        for a = 2:rtntypsize(1)
                            if(strcmp(RtnTypInfo{a,1},obj.Type))
                                obj.Min = [RtnTypInfo{a,1} '.' RtnTypInfo{a,2}];
                                break;
                            end
                        end
                    else
                        [~, obj.Min, msg] = validateUserEngMin(obj.Type,val);
                        if ~strcmp('',msg)
                            warning backtrace off
                            warning(msg,'CSReturn',MinMax2String(obj.Min)); %#ok<CTPCT>
                            warning backtrace on
                        end
                    end
            end
        end
        
        function set.Max(obj,val)
            meta = metaclass(obj.Type);
            if strcmp('char',meta.Name)
                type = obj.Type;
            else
                type = '';
            end
            switch type
                case 'None'
                    obj.Max = [];
                case 'Standard'
                    obj.Max = 1;
                otherwise
                    [miscpah, ~] = NxtrToolsPahFindr('Miscellaneous');
                    RtnTypInfo = NxtrXlsRead(miscpah,'RtnTyp');
                    if(~isempty(RtnTypInfo))
                        rtntypsize = size(RtnTypInfo);
                        for a = 2:rtntypsize(1)
                            if(strcmp(RtnTypInfo{a,1},obj.Type))
                                obj.Max = [RtnTypInfo{a,1} '.' RtnTypInfo{a,3}];
                                break;
                            end
                        end
                    else
                        [~, obj.Max, msg] = validateUserEngMax(obj.Type,val);
                        if ~strcmp('',msg)
                            warning backtrace off
                            warning(msg,'CSReturn',MinMax2String(obj.Max)); %#ok<CTPCT>
                            warning backtrace on
                        end
                    end
            end
        end
        
        function set.TestTolerance(obj,val)
            if isequal('None',obj.Type)
                if ~isequal([],val)
                    warning backtrace off
                    warning('Test Tolerance for CSReturn.Type of Type ''None'' must equal ''[]''. No change has been made.')
                    warning backtrace on
                end
                obj.TestTolerance = [];
            else
                obj.TestTolerance = val;
            end
        end
        
        % String method assumes that the object Type will not be a value that isn't allowed.
        function txt = String(obj)
            arg = inputname(1);
            meta = metaclass(obj.Type);
            if strcmp('char',meta.Name)
                txt = sprintf('%s.Return.Type = ''%s'';\n',arg,obj.Type);
            else
                txt = sprintf('%s.Return.Type = %s;\n',arg,meta.Name);
            end
            txt = sprintf('%s%s.Return.Min = %s;\n',txt,arg,MinMax2String(obj.Min));
            txt = sprintf('%s%s.Return.Max = %s;\n',txt,arg,MinMax2String(obj.Max));
            txt = sprintf('%s%s.Return.TestTolerance = %s;\n',txt,arg,Val2String(obj.TestTolerance));
            dsc = WriteDescription(arg, obj.Description);
            if(~strcmp(obj.Type,'None'))
                txt = sprintf('%s%s.Return.%s\n', txt,arg,dsc(5:end)); %using (5:end) to remove 'arg.' from the string that comes out of WriteDescription.
            end
        end
    end
    
end %#ok<*MCSUP>

