%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm6p13 < bt.sint8
    methods
        function obj = sm6p13(~)
            obj = obj@bt.sint8(13);
            obj.Description = 'fixdt(1,8,13)';
        end
    end
    
end
