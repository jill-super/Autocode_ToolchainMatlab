%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm12p27 < bt.sint16
    methods
        function obj = sm12p27(~)
            obj = obj@bt.sint16(27);
            obj.Description = 'fixdt(1,16,27)';
        end
    end
    
end

