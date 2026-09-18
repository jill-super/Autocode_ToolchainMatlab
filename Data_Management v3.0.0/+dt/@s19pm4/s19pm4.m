%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s19pm4 < bt.sint16
    methods
        function obj = s19pm4(~)
            obj = obj@bt.sint16(-4);
            obj.Description = 'fixdt(1,16,-4)';
        end
    end
    
end

