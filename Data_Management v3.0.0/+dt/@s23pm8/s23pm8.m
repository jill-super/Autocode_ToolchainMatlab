%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s23pm8  < bt.sint16
    methods
        function obj = s23pm8(~)
            obj = obj@bt.sint16(-8);
            obj.Description = 'fixdt(1,16,-8)';
        end
    end
    
end

