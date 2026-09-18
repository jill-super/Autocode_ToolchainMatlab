%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u8p8 < bt.uint16
   methods
      function obj = u8p8(~)
          obj = obj@bt.uint16(8);
          obj.Description = 'fixdt(1,16,8)';
      end
   end
   
end

