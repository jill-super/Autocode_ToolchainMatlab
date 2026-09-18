%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s7p8 < bt.sint16
    methods
        function obj = s7p8(~)
            obj = obj@bt.sint16(8);
            obj.Description = 'fixdt(1,16,8)';
        end
    end
    
end

