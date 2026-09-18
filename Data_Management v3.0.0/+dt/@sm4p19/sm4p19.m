%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm4p19  < bt.sint16
    methods
        function obj = sm4p19(~)
            obj = obj@bt.sint16(19);
            obj.Description = 'fixdt(1,16,19)';
        end
    end
    
end

