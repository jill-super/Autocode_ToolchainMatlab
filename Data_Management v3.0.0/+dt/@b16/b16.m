%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef b16 < bt.uint16
   methods
      function obj = b16(~)
          obj = obj@bt.uint16(0);
          obj.Description = 'packed binary (unsigned 16-bit integer)';
      end
   end
   
end

