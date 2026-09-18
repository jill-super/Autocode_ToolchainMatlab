%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s15p16 < bt.sint32
    methods
        function obj = s15p16(~)
            obj = obj@bt.sint32(16);
            obj.Description = 'fixdt(1,32,16)';
        end
    end
    
end

