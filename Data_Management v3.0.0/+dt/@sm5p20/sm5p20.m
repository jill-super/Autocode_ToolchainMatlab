%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm5p20 < bt.sint16
    methods
        function obj = sm5p20(~)
            obj = obj@bt.sint16(20);
            obj.Description = 'fixdt(1,16,20)';
        end
    end
    
end
