%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um4p20 < bt.uint16
   methods
      function obj = um4p20(~)
          obj = obj@bt.uint16(20);
          obj.Description = 'fixdt(1,16,20)';
      end
   end
   
end

