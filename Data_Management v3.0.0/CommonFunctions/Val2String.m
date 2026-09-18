%  Change Log:
%  11feb2015 PLefler     Added functionality to handle enums.
%  03mar2015 PLefler     Fixed call to index 0 when enums have a value that is zero.
%                        Changed function behavior to write values up to 16 digits.
%  13mar2015 PLefler     Logic added to handle strings as inputs.
%  17mar2015 PLefler     Add ability to handle and empty array.
%  08May2015 PLefler     Fixed bug in writing string for structures, added cast to specific data type for element.
%  05Jun2015 Siva        Updated logic to handle floating point numbers.
%  07Jul2015 K. Derry    Modified the "case {'struct','structEA3'}" section with addition of error handling, three more data types, and 1 bug fix.
%  24Jul2015 PLefler     Fixed bug for structure of structures causing errors in both the val2string_no_dt and val2string_with_dt functions.   
%  31Jul2015 PLefler     Added logic to the val2string_with_dt to handle structures with enumerated values.   
%  06Oct2015 PLefler     Support for arrays of structures was added.
%  12Oct2015 PLefler     Fixed bug for structures with enums where the initial value is [].  
%  18Dec2015 PLefler     Added better error handling for input values with incorrect datatypes.
%  23Dec2015 PLefler     The wrong file was used for the desired changes the correct baselined file was used and the new error checking content was added. 
%  03Feb2016 PLefler     Fixed bugs in val2string_with_dt.
%  14Apr2016 PLefler     Fixed bug in val2string_with_dt for when the value being converted is an enumeration in a structure.    
%
