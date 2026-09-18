%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s6p9 < bt.sint16
    methods
        function obj = s6p9(~)
            obj = obj@bt.sint16(9);
            obj.Description = 'fixdt(1,16,9)';
        end
    end
    
end

