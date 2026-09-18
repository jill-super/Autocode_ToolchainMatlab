%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef float32 < bt.single
    methods
        function obj = float32(~)
            obj = obj@bt.single();
            obj.Description = '32-bit floating point single';
        end
    end

end

