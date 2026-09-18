%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm6p21 < bt.sint16
    methods
        function obj = sm6p21(~)
            obj = obj@bt.sint16(21);
            obj.Description = 'fixdt(1,16,21)';
        end
    end
    
end

