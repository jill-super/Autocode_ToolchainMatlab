%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u9p7 < bt.uint16
   methods
      function obj = u9p7(~)
          obj = obj@bt.uint16(7);
          obj.Description = 'fixdt(1,16,7)';
      end
   end
   
end

