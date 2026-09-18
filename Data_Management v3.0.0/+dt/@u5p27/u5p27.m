%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u5p27 < bt.uint32
   methods
      function obj = u5p27(~)
          obj = obj@bt.uint32(27);
          obj.Description = 'fixdt(1,32,27)';
      end
   end
   
end