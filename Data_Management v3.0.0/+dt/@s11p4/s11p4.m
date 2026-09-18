%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s11p4 < bt.sint16
    methods
        function obj = s11p4(~)
            obj = obj@bt.sint16(4);
            obj.Description = 'fixdt(1,16,4)';
        end
    end
    
end

