%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef u3p13 < bt.uint16
   methods
      function obj = u3p13(~)
          obj = obj@bt.uint16(13);
          obj.Description = 'fixdt(1,16,13)';
      end
   end
   
end

