QuickcheckRandomInt := function(max)
  return Random([1..max]);
end;

QuickcheckRandomList := function(generator)
  return function(max)
    local length, result, i;
    length := Random([1..max]);
    result := [];
    for i in [0..length] do
      Append(result, [generator(max)]);
    od;
    return result;
  end;
end;

QuickcheckRandomPermutation := function(max)
  local int1, int2;
  int1 := Random([1..max]);
  int2 := Random([1..max]);
  while int1 = int2 do
    int2 := Random([1..max]);
  od;
  return (int1, int2);
end;

QuickcheckAbelianGroup := function(max)
  local i, size, ints;
  size := Random([1..max]);
  ints := [];
  for i in [0..size] do
    Append(ints, [Random([1..max])]);
  od;
  return AbelianGroup(ints);
end;

QuickcheckQuaternionGroup := function(max)
  local rounded_size;
  rounded_size := max;
  while rounded_size mod 4 <> 0 do
    rounded_size := rounded_size + 1;
  od;
  return QuaternionGroup(rounded_size);
end;

QuickcheckDihedralGroup := function(max)
  local rounded_size;
  rounded_size := max;
  while rounded_size mod 4 <> 0 do
    rounded_size := rounded_size + 1;
  od;
  return DihedralGroup(rounded_size);
end;

group_types := [
  CyclicGroup,
  QuickcheckAbelianGroup,
  #ElementaryAbelianGroup,
  FreeAbelianGroup,
  QuickcheckDihedralGroup,
  QuickcheckQuaternionGroup
];

QuickcheckRandomGroup := function(max)
  local type, size;
  type := Random([1..Length(group_types)]);
  size := Random([1..max]);
  Print(size, "\n");
  Print(type, "\n");
  return group_types[type](size);
end;