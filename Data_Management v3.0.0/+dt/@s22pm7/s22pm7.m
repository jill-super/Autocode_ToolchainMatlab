%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s22pm7 < bt.sint16
    methods
        function obj = s22pm7(~)
            obj = obj@bt.sint16(-7);
            obj.Description = 'fixdt(1,16,-7)';
        end
    end
    
end

