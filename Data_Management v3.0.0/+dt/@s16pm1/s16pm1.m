%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s16pm1 < bt.sint16
    methods
        function obj = s16pm1(~)
            obj = obj@bt.sint16(-1);
            obj.Description = 'fixdt(1,16,-1)';
        end
    end
    
end

