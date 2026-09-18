%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s5p26 < bt.sint32
    methods
        function obj = s5p26(~)
            obj = obj@bt.sint32(26);
            obj.Description = 'fixdt(1,32,26)';
        end
    end
    
end

