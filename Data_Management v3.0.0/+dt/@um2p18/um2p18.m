%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nexteer DataType Class Definition %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef um2p18 < bt.uint16
   methods
      function obj = um2p18(~)
          obj = obj@bt.uint16(18);
          obj.Description = 'fixdt(1,16,18)';
      end
   end
   
end

