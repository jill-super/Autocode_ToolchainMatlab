%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm5p12 < bt.sint8
    methods
        function obj = sm5p12(~)
            obj = obj@bt.sint8(12);
            obj.Description = 'fixdt(1,8,12)';
        end
    end
    
end
