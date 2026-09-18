%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u14p2 < bt.uint16
   methods
      function obj = u14p2(~)
          obj = obj@bt.uint16(2);
          obj.Description = 'fixdt(1,16,2)';
      end
   end
   
end


