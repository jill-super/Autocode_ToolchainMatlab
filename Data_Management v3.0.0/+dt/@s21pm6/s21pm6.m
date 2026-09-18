%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s21pm6 < bt.sint16
    methods
        function obj = s21pm6(~)
            obj = obj@bt.sint16(-6);
            obj.Description = 'fixdt(1,16,-6)';
        end
    end
    
end

