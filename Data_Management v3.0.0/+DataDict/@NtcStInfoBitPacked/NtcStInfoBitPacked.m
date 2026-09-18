%DataDict.NtcStInfoBitPacked
%   This class is used to communicate NTC parameter
%   information by bit.

% Change Log
% 7Jul2015 P Lelfer     Initial Release

classdef NtcStInfoBitPacked < handle
    
    properties
        Bit0Descr
        Bit1Descr
        Bit2Descr
        Bit3Descr
        Bit4Descr
        Bit5Descr
        Bit6Descr
        Bit7Descr
    end
    
    methods
        function obj = NtcStInfoBitPacked(~)
            obj.Bit0Descr = 'Unused';
            obj.Bit1Descr = 'Unused';
            obj.Bit2Descr = 'Unused';
            obj.Bit3Descr = 'Unused';
            obj.Bit4Descr = 'Unused';
            obj.Bit5Descr = 'Unused';
            obj.Bit6Descr = 'Unused';
            obj.Bit7Descr = 'Unused';
        end
            
        function set.Bit0Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit0Descr = val;
        end
        
        function set.Bit1Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit1Descr = val;
        end
        
        function set.Bit2Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit2Descr = val;
        end
        
        function set.Bit3Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit3Descr = val;
        end
        
        function set.Bit4Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit4Descr = val;
        end
        
        function set.Bit5Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit5Descr = val;
        end
        
        function set.Bit6Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit6Descr = val;
        end
        
        function set.Bit7Descr(obj,val)
            obj.checkDescr(val);
            obj.Bit7Descr = val;
        end
        
        
        
        function txt = String(obj)
            name = inputname(1);
            txt = sprintf('%s.NtcStInfo.Bit0Descr = ''%s'';\n', name, obj.Bit0Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit1Descr = ''%s'';\n',txt, name, obj.Bit1Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit2Descr = ''%s'';\n',txt, name, obj.Bit2Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit3Descr = ''%s'';\n',txt, name, obj.Bit3Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit4Descr = ''%s'';\n',txt, name, obj.Bit4Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit5Descr = ''%s'';\n',txt, name, obj.Bit5Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit6Descr = ''%s'';\n',txt, name, obj.Bit6Descr);
            txt = sprintf('%s%s.NtcStInfo.Bit7Descr = ''%s'';\n',txt, name, obj.Bit7Descr);
        end
        
        
    end
        
    methods (Static = true)
           function checkDescr(val)
            if ~ischar(val)
                error('Ntc BitDescr must be a string.');
            end
        end 
    end
end

