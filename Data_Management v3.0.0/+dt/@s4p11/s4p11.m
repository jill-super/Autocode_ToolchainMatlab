%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s4p11 < bt.sint16
    methods
        function obj = s4p11(~)
            obj = obj@bt.sint16(11);
            obj.Description = 'fixdt(1,16,11)';
        end
    end
    
end

