%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u08 < bt.uint8
   methods
      function obj = u08(~)
          obj = obj@bt.uint8(0);
          obj.Description = 'fixdt(1,8,0)';
      end
   end
   
end