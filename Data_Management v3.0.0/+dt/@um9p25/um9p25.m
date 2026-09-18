%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um9p25 < bt.uint16
   methods
      function obj = um9p25(~)
          obj = obj@bt.uint16(25);
          obj.Description = 'fixdt(1,16,25)';
      end
   end
   
end
