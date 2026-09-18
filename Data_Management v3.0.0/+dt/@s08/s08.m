%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s08 < bt.sint8
    methods
        function obj = s08(~)
            obj = obj@bt.sint8(0);
            obj.Description = 'fixdt(1,8,0)';
        end
    end
    
end

