%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef float64 < bt.double
    methods
        function obj = float64(~)
            obj = obj@bt.double();
            obj.Description = '64-bit floating point single';
        end
    end
    
end