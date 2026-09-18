%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef b08 < bt.uint8
   methods
      function obj = b08(~)
          obj = obj@bt.uint8(0);
          obj.Description = 'packed binary (unsigned 8-bit integer)';
      end
   end
   
end