%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u6p10 < bt.uint16
   methods
      function obj = u6p10(~)
          obj = obj@bt.uint16(10);
          obj.Description = 'fixdt(1,16,10)';
      end
   end
   
end

