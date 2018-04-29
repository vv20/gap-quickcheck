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

RandomPermutation := function(max)
  local int1, int2;
  int1 := Random([1..max]);
  int2 := Random([1..max]);
  while int1 = int2 do
    int2 := Random([1..max]);
  od;
  Print(int1);
  Print("\n");
  Print(int2);
  Print("\n");
  return (int1, int2);
end;
