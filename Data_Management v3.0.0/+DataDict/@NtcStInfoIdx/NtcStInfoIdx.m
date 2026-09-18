%DataDict.NtcStInfoIdx
%   This class is used to communicate NTC parameter
%   information by index. 

% Change Log
% 7Jul2015 P Lelfer     Initial Release

classdef NtcStInfoIdx < handle
            
    properties
        Idx = struct('EngVal',{},'Descr',{});
    end
    
    methods
        function obj = NtcStInfoIdx(~)
            obj.Idx(1).EngVal = 1;
            obj.Idx(1).Descr = '';
        end
        function set.Idx(obj,val)
            % Check struct fieldnames for errors
            if ~isequal(fieldnames(obj.Idx),fieldnames(val))
                error('Struct field names for NtcNr don''t match expected values for NtcStInfoIdx (EngVal, Descr).')
            end
            % Check to make sure fields have correct info in them
            % EngVal
            if (ceil(val(end).EngVal) - val(end).EngVal) ~= 0
                error('Invalid NtcStInfoIdx engineering value, the value must be an integer.');
            elseif 0 > val(end).EngVal || val(end).EngVal > 255
                error('NtcStInfoIdx engineering value must be between 0 and 255.');
            end
            % Description
            if ~isempty(val(end).Descr)
                if ~ischar(val(end).Descr)
                    error('NtcStInfoIdx description must be a string.');
                end
            end
                        
            obj.Idx = val;
        end
        
        function txt = String(obj)
            name = inputname(1);
            txt = '';
            for i = 1:size(obj.Idx,2)
                txt = sprintf('%s%s.NtcStInfo.Idx(%s).EngVal = %s;\n', txt, name, num2str(i), num2str(obj.Idx(i).EngVal));
                txt = sprintf('%s%s.NtcStInfo.Idx(%s).Descr = ''%s'';\n', txt, name, num2str(i), obj.Idx(i).Descr);
            end
        end 
        
    end
    
end

