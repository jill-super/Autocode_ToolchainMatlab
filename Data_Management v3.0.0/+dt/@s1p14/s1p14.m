%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s1p14 < bt.sint16
    methods
        function obj = s1p14(~)
            obj = obj@bt.sint16(14);
            obj.Description = 'fixdt(1,16,14)';
        end
    end
    
end

