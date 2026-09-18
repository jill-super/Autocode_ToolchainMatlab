%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm13p28 < bt.sint16
    methods
        function obj = sm13p28(~)
            obj = obj@bt.sint16(28);
            obj.Description = 'fixdt(1,16,28)';
        end
    end
    
end