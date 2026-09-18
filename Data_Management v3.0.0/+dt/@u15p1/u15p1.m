%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u15p1 < bt.uint16
   methods
      function obj = u15p1(~)
          obj = obj@bt.uint16(1);
          obj.Description = 'fixdt(1,16,1)';
      end
   end
   
end


