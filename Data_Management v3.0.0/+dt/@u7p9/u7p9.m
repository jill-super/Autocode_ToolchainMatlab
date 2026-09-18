%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u7p9 < bt.uint16
   methods
      function obj = u7p9(~)
          obj = obj@bt.uint16(9);
          obj.Description = 'fixdt(1,16,9)';
      end
   end
   
end

