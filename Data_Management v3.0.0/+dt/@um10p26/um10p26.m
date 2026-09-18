%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um10p26 < bt.uint16
   methods
      function obj = um10p26(~)
          obj = obj@bt.uint16(26);
          obj.Description = 'fixdt(1,16,26)';
      end
   end
   
end

