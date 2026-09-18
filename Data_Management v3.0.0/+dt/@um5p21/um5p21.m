%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um5p21 < bt.uint16
   methods
      function obj = um5p21(~)
          obj = obj@bt.uint16(21);
          obj.Description = 'fixdt(1,16,21)';
      end
   end
   
end
