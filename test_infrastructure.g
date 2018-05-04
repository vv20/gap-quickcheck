max_size := 100;
no_reps := 1;

Expect := function(func)
  local given;
  given := function(arg_gens)
    local to_have_properties;
    to_have_properties := function(props_list)
      local result, args_list, i, j, arg, prop, tests_failed;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Append(args_list, [arg(j)]);
          od;
          result := CallFuncList(func, args_list);
          for prop in props_list do
            if not prop(result) then
              tests_failed := tests_failed + 1;
              Print("Test failed with arguments:\n");
              for arg in args_list do
                Print(arg, "\n");
              od;
            fi;
          od;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed");
    end;
    return rec(to_have_properties := to_have_properties);
  end;
  return rec(given := given);
end;

SetQuickcheckMaxSize := function(new_max)
  max_size := new_max;
end;

SetQuickcheckNumberOfReps := function(new_no)
  no_reps := new_no;
end;
