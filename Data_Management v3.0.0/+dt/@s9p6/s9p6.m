%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s9p6 < bt.sint16
    methods
        function obj = s9p6(~)
            obj = obj@bt.sint16(6);
            obj.Description = 'fixdt(1,16,6)';
        end
    end
    
end

