RandomInt := function(max)
  return Random([1..max]);
end;

RandomListGen := function(RandomGen, max)
  local length, result, i;
  length := Random([1..max]);
  result := [];
  for i in [0..length] do
    Append(result, [RandomGen(max)]);
  od;
  return result;
end;
