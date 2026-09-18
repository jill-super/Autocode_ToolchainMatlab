%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef sm8p23 < bt.sint16
    methods
        function obj = sm8p23(~)
            obj = obj@bt.sint16(23);
            obj.Description = 'fixdt(1,16,23)';
        end
    end
    
end

