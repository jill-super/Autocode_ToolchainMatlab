%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm9p24 < bt.sint16
    methods
        function obj = sm9p24(~)
            obj = obj@bt.sint16(24);
            obj.Description = 'fixdt(1,16,24)';
        end
    end
    
end

