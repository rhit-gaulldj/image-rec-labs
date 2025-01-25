% function to save dlnetowrk from (https://www.mathworks.com/matlabcentral/answers/97188-is-it-possible-to-load-my-user-defined-object-into-matlab-without-the-class-definition-file#answer_106538)

function saveToStruct(obj, filename)
  varname = inputname(1);
  props = properties(obj);
  for p = 1:numel(props)
      s.(props{p})=obj.(props{p});
  end
  eval([varname ' = s'])
  save(filename, varname)
end