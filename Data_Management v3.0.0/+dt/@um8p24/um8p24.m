%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um8p24 < bt.uint16
   methods
      function obj = um8p24(~)
          obj = obj@bt.uint16(24);
          obj.Description = 'fixdt(1,16,24)';
      end
   end
   
end

