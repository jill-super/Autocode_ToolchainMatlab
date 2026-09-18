%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um1p17 < bt.uint16
   methods
      function obj = um1p17(~)
          obj = obj@bt.uint16(17);
          obj.Description = 'fixdt(1,16,17)';
      end
   end
   
end
