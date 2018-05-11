LoadPackage("Digraph");

QuickcheckInt := function(max)
  return Random([1..max]);
end;

QuickcheckList := function(generator)
  return function(max)
    local length, result, i;
    length := Random([1..max]);
    result := [];
    for i in [1..length] do
      Add(result, generator(max));
    od;
    return result;
  end;
end;

QuickcheckSet := function(generator)
  return function(max)
    local length, result, i, member;
    length := Random([1..max]);
    result := [];
    for i in [0..length] do
      member := generator(max);
      while member in result do
        member := generator(max);
      od;
      Add(result, member);
    od;
    return Set(result);
  end;
end;

QuickcheckObject := function(constructor, arg_gens)
  return function(max)
    local arg, arg_list;
    arg_list := [];
    for arg in arg_gens do
      Add(arg_list, arg(max));
    od;
    return CallFuncList(constructor, arg_list);
  end;
end;

QuickcheckRecord := function(attribute_names, arg_gens)
  return function(max)
    local result, i;
    result := rec();
    for i in [1..Length(arg_gens)] do
      result.(attribute_names[i]) := arg_gens[i](max);
    od;
    return result;
  end;
end;

QuickcheckPermutation := function(max)
  return PermList(FLOYDS_ALGORITHM(GlobalRandomSource,max,true));
end;

QuickcheckAbelianGroup := function(max)
  local i, size, ints;
  size := Random([1..max]);
  ints := [];
  for i in [0..size] do
    Add(ints, Random([1..max]));
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

QuickcheckPermutationGroup := function(max)
  local length, permutation_list, i;
  length := Random([1..max]);
  permutation_list := [];
  for i in [1..length] do
    Add(permutation_list, QuickcheckPermutation(max));
  od;
  return CallFuncList(Group, permutation_list);
end;

QuickcheckCoset := function(max)
  return QuickcheckPermutationGroup(max) * QuickcheckPermutation(max);
end;

QuickcheckDigraph := function(max)
  local length, nodes, no_links, source, range, i;
  length := Random([1..max]);
  no_links := Random([1..length]);
  nodes := [1..length];
  source := [];
  range := [];
  for i in [1..no_links] do
    Add(source, Random(nodes));
    Add(range, Random(nodes));
  od;
  return Digraph(nodes, source, range);
end;

group_types := [
  CyclicGroup,
  QuickcheckAbelianGroup,
  #ElementaryAbelianGroup,
  FreeAbelianGroup,
  QuickcheckDihedralGroup,
  QuickcheckQuaternionGroup,
  QuickcheckPermutationGroup
];

QuickcheckGroup := function(max)
  local type, size;
  type := Random([1..Length(group_types)]);
  size := Random([1..max]);
  return group_types[type](size);
end;
