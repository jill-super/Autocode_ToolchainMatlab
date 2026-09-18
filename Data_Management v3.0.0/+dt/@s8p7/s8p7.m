%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s8p7 < bt.sint16
    methods
        function obj = s8p7(~)
            obj = obj@bt.sint16(7);
            obj.Description = 'fixdt(1,16,7)';
        end
    end
end
