%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s12p3 < bt.sint16
    methods
        function obj = s12p3(~)
            obj = obj@bt.sint16(3);
            obj.Description = 'fixdt(1,16,3)';
        end
    end
    
end

