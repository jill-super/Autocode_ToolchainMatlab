%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u20pm4 < bt.uint16
   methods
      function obj = u20pm4(~)
          obj = obj@bt.uint16(-4);
          obj.Description = 'fixdt(1,16,-4)';
      end
   end
   
end

