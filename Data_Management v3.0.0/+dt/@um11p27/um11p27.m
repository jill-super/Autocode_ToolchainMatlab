%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um11p27 < bt.uint16
   methods
      function obj = um11p27(~)
          obj = obj@bt.uint16(27);
          obj.Description = 'fixdt(1,16,27)';
      end
   end
   
end

