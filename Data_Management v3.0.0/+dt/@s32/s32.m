%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s32 < bt.sint32
    methods
        function obj = s32(~)
            obj = obj@bt.sint32(0);
            obj.Description = 'fixdt(1,32,0)';
        end
    end
    
end

