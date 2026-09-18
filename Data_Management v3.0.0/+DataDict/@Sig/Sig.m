%  DataDict.Sig
%  This script defines the data class of a Nexteer software component
%  signal used during FDD development stage.  It includes the bare minimum
%  amount of information to cross-reference the fully-defined properties
%  of that signal in its source component.
%
%  There shall exist a master list of fully defined signals.  the master
%  list is created by collecting information about output signals from
%  every software component.  When developing a new or revised SWC,
%  information about each input signal is obtained by referencing the
%  master list.
%


% Change Log
% 19Sep2016   Siva    Initial Release


classdef Sig < Simulink.Signal
    
    properties
        SigType@char;
    end
    
    methods
        function obj = Sig(~)
            obj.SigType = 'Inp';
            obj.DataType = 'Single';
        end
        
        function set.SigType(obj,val)
            switch val
                case 'Inp'
                    obj.SigType =  'Inp';
                case 'Outp'
                    obj.SigType = 'Outp';
                case 'StVari'
                    obj.SigType = 'StVari';
                case 'PrsisntStVari'
                    obj.SigType = 'PrsisntStVari';
                otherwise
                    
            end
        end
        
        function txt = String(obj)
            % This function creates a string that looks like the original structure.
            % If the string is placed into a Matlab script, then running the script
            % would generate the original structure in Matlab's workspace.
            var = inputname(1);
            cl = class(obj);
            txt = sprintf('%s = %s;\n', var, cl);
            dsc = WriteDescription(var, obj.Description);
            txt = sprintf('%s%s\n', txt,dsc);
            txt = sprintf('%s%s.Min = %s;\n', txt,var,Val2String(obj.Min));
            txt = sprintf('%s%s.Max = %s;\n', txt,var,Val2String(obj.Max));
            txt = sprintf('%s%s.DocUnits = ''%s'';\n', txt,var,obj.DocUnits);
            txt = sprintf('%s%s.InitialValue = ''%s'';\n', txt,var,obj.InitialValue);
            txt = sprintf('%s%s.SigType = ''%s'';\n', txt,var,obj.SigType);
        end
    end
end

