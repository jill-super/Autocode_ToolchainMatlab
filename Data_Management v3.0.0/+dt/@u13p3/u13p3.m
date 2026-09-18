%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u13p3 < bt.uint16
   methods
      function obj = u13p3(~)
          obj = obj@bt.uint16(3);
          obj.Description = 'fixdt(1,16,3)';
      end
   end
   
end


