%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u16 < bt.uint16
   methods
      function obj = u16(~)
          obj = obj@bt.uint16(0);
          obj.Description = 'fixdt(1,16,0)';
      end
   end
   
end


