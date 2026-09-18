%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s24p7 < bt.sint32
    methods
        function obj = s24p7(~)
            obj = obj@bt.sint32(7);
            obj.Description = 'fixdt(1,32,7)';
        end
    end
    
end