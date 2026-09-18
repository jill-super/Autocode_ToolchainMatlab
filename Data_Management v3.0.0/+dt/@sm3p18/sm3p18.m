%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm3p18  < bt.sint16
    methods
        function obj = sm3p18(~)
            obj = obj@bt.sint16(18);
            obj.Description = 'fixdt(1,16,18)';
        end
    end
    
end

