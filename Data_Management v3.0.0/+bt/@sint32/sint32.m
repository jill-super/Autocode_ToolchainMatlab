%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signed integer 32bits datatype classs definition

% Change Log:
% 11feb2015 PLefler     Changed scaled outputs of validateUserEngMin, validateUserEngMax, validateUserEngVal to remove warnings.
% 16mar2015 PLefler     Added checking for zero arguments being passed to class constructor method.

classdef sint32 < Simulink.AliasType
    properties (Constant = true)
        Signed = true;
        InterfacePath = '/PortInterfaces/CalPortInterface_sint32';
        dtMin  = -2147483648;     %Minimum allowed (Cnt)
        dtMax  =  2147483647;      %Maximum allowed (Cnt)
    end
    properties
        dtScl;       %FloatToFixed
    end
    properties (Dependent)
        enMin;%Minimum allowed (engineering units)
        enMax;%Maximum allowed (engineering units)
    end
    
    methods
        function obj = sint32(var)
            if nargin == 0
                var = 0;
            end
            obj.dtScl = 2^var;
            obj.BaseType = 'int32';
        end
        
        function val = get.enMin(obj)
            val = obj.dtMin/obj.dtScl;
        end
        
        function val = get.enMax(obj)
            val = obj.dtMax/obj.dtScl;
        end
        
        function [engmin,scaledmin,str] = validateUserEngMin(obj,val)
            if isempty(val)
                val = 0;
            end
            if (val < obj.enMin) || (val > obj.enMax)
                val = obj.enMin;
                str = 'In workspace, %s.EngMin is not within the data types Min/Max limits and has been limited to %s.\nPlease update your saved files.';
            else
                str = '';
            end
            engmin = val;
            scaledmin = double(round(val*obj.dtScl));
        end
        
        function [engmax,scaledmax,str] = validateUserEngMax(obj,val)
            if isempty(val)
                val = 0;
            end
            if (val > obj.enMax) || (val < obj.enMin)
                val = obj.enMax;
                str = 'In workspace, %s.EngMax is not within the data types Min/Max limits and has been limited to %s.\nPlease update your saved files.';
            else
                str = '';
            end
            engmax = val;
            scaledmax = double(round(val*obj.dtScl));
        end
        
        function [engval,scaledval,str] = validateUserEngVal(dtobj,calobj,val)
            if (any(any(val > calobj.EngMax)))
                val = min(val,calobj.EngMax);
                str = 'In workspace, %s.EngVal has been limited to the EngMax.\nPlease update your saved files.';
            elseif (any(any(val < calobj.EngMin)))
                val = max(val,calobj.EngMin);
                str = 'In workspace, %s.EngVal has been increased to the EngMin.\nPlease update your saved files.';
            else
                str = '';
            end
            engval = val;
            scaledval = double(round(val*dtobj.dtScl));
        end
        
        function [enginit,scaledinit,str] = validateUserEngInit(dtobj,calobj,val)
            if (any(any(val > calobj.EngMax)))
                val = min(val,calobj.EngMax);
                str = 'In workspace, %s.EngInit has been limited to the EngMax.\nPlease update your saved files.';
            elseif (any(any(val < calobj.EngMin)))
                val = max(val,calobj.EngMin);
                str = 'In workspace, %s.EngInit has been increased to the EngMin.\nPlease update your saved files.';
            else
                str = '';
            end
            enginit = val;
            scaledinit = num2str(double(val*dtobj.dtScl));
        end
        
        function [engdt,str] = validateUserEngDT(dtobj,val)
            meta = metaclass(val);
            pname = meta.ContainingPackage.Name;
            % "meta.ContainingPackage" will tell us what kind of object the user has given.
            if (isempty(meta.ContainingPackage)) || ((~strcmp('dt',pname)) && (~strcmp('enum',pname)) && (~strcmp('enumEA3',pname)) && (~strcmp('struct',pname)) && (~strcmp('structEA3',pname)))
                engdt = dtobj;
                str = '%s.EngDT input is not a ''dt'', ''enum'', or ''enumEA3'' object.';
            else
                engdt = val;
                str = '';
            end
            
        end
        
    end
    
    
end
