%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm10p25 < bt.sint16
    methods
        function obj = sm10p25(~)
            obj = obj@bt.sint16(25);
            obj.Description = 'fixdt(1,16,25)';
        end
    end
    
end

