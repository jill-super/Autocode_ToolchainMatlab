%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s15p0 < bt.sint16
    methods
        function obj = s15p0(~)
            obj = obj@bt.sint16(0);
            obj.Description = 'fixdt(1,16,0)';
        end
    end
    
end

