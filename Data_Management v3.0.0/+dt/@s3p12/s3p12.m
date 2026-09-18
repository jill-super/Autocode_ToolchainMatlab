%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef s3p12 < bt.sint16
    methods
        function obj = s3p12(~)
            obj = obj@bt.sint16(12);
            obj.Description = 'fixdt(1,16,12)';
        end
    end
    
end

