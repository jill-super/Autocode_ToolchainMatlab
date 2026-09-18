%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm11p26 < bt.sint16
    methods
        function obj = sm11p26(~)
            obj = obj@bt.sint16(26);
            obj.Description = 'fixdt(1,16,26)';
        end
    end
    
end
