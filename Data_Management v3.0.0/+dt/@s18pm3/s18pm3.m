%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s18pm3 < bt.sint16
    methods
        function obj = s18pm3(~)
            obj = obj@bt.sint16(-3);
            obj.Description = 'fixdt(1,16,-3)';
        end
    end
    
end
