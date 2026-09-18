%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u32 < bt.uint32
   methods
      function obj = u32(~)
          obj = obj@bt.uint32(0);
          obj.Description = 'fixdt(1,32,0)';
      end
   end
   
end