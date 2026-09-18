%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s2p13 < bt.sint16
    methods
        function obj = s2p13(~)
            obj = obj@bt.sint16(13);
            obj.Description = 'fixdt(1,16,13)';
        end
    end
    
end

