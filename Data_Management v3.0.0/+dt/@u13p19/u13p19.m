%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u13p19 < bt.uint32
    methods
        function obj = u13p19(~)
            obj = obj@bt.uint32(19);
            obj.Description = 'fixdt(1,32,19)';
        end
    end
end

