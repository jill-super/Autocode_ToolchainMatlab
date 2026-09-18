%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Boolean Datatype class definition

classdef boolean < Simulink.AliasType
   properties (Constant = true) 
      Signed = false;
      InterfacePath = '/PortInterfaces/CalPortInterface_boolean';
      dtScl  = 1; %Model-to-Code scalefactor = 1;
      dtMin  = 0; %Minimum allowed (Cnt)
      dtMax  = 1; %Maximum allowed (Cnt)
      enMin  = 0; %Minimum allowed (engineering units)
      enMax  = 1; %Maximum allowed (engineering units)
   end
   
   methods
      function obj = boolean(~)
         obj.BaseType = 'boolean';
      end
      
      function [engmin,scaledmin,str] = validateUserEngMin(obj,val)
            if isempty(val)
                val = 0;
            end
            if (val ~= obj.enMin)
                val = obj.enMin;
                str = 'In workspace, %s.EngMin whose data type is dt.lgc must be 0.\nPlease update your saved files.';
            else
                str = '';
            end
            engmin = val;
            scaledmin = double(single(round(obj.enMin*obj.dtScl)));
        end
        
        function [engmax,scaledmax,str] = validateUserEngMax(obj,val)
            if isempty(val)
                val = 0;
            end
            if (val ~= obj.enMax)
                val = obj.enMax;
                str =  'In workspace, %s.EngMax whose data type is dt.lgc must be 1.\nPlease update your saved files.';
            else
                str = '';
            end
            engmax = val;
            scaledmax = double(single(round(obj.enMax*obj.dtScl)));
        end
        
        function [engval,scaledval,str] = validateUserEngVal(dtobj,calobj,val)
            if (any(any(val > calobj.EngMax))) || (any(any(val < calobj.EngMin)))
                val = calobj.EngVal;
                str = 'In workspace, %s.EngVal has not been changed please use 0 or 1 for objects with a data type of dt.lgc.\nPlease update your saved files.';
            else
                str = '';
            end
            engval = val;
            scaledval = double(single(round(val*dtobj.dtScl)));
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
            scaledinit = num2str(double(single(val*dtobj.dtScl)));
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

