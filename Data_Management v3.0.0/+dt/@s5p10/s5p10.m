%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s5p10 < bt.sint16
    methods
        function obj = s5p10(~)
            obj = obj@bt.sint16(10);
            obj.Description = 'fixdt(1,16,10)';
        end
    end
    
end

