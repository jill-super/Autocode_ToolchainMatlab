%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef b32 < bt.uint32
   methods
      function obj = b32(~)
          obj = obj@bt.uint32(0);
          obj.Description = 'packed binary (unsigned 32-bit integer)';
      end
   end
   
end

