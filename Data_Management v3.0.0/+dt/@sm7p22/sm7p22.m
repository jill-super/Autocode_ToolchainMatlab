%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm7p22 < bt.sint16
    methods
        function obj = sm7p22(~)
            obj = obj@bt.sint16(22);
            obj.Description = 'fixdt(1,16,22)';
        end
    end
    
end

