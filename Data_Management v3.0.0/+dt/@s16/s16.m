%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s16 < bt.sint16
    methods
        function obj = s16(~)
            obj = obj@bt.sint16(0);
            obj.Description = 'fixdt(1,16,0)';
        end
    end
    
end

