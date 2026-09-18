%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s18p13 < bt.sint32
    methods
        function obj = s18p13(~)
            obj = obj@bt.sint32(13);
            obj.Description = 'fixdt(1,32,13)';
        end
    end
end

