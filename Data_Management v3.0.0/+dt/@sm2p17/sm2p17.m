%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm2p17 < bt.sint16
    methods
        function obj = sm2p17(~)
            obj = obj@bt.sint16(17);
            obj.Description = 'fixdt(1,16,17)';
        end
    end
    
end

