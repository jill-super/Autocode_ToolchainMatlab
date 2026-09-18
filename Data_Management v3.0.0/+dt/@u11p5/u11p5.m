%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u11p5 < bt.uint16
   methods
      function obj = u11p5(~)
          obj = obj@bt.uint16(5);
          obj.Description = 'fixdt(1,16,5)';
      end
   end
   
end

