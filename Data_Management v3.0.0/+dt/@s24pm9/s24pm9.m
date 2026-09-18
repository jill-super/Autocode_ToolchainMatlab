%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s24pm9 < bt.sint16
    methods
        function obj = s24pm9(~)
            obj = obj@bt.sint16(-9);
            obj.Description = 'fixdt(1,16,-9)';
        end
    end
    
end

