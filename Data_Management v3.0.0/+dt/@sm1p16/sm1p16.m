%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm1p16 < bt.sint16
    methods
        function obj = sm1p16(~)
            obj = obj@bt.sint16(16);
            obj.Description = 'fixdt(1,16,16)';
        end
    end
    
end

