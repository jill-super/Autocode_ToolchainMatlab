%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u12p4 < bt.uint16
   methods
      function obj = u12p4(~)
          obj = obj@bt.uint16(4);
          obj.Description = 'fixdt(1,16,4)';
      end
   end
   
end


