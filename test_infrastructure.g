max_size := 100;
no_reps := 1;

Expect := function(func)
  local given;
  given := function(arg_gens)
    local to_have_properties, to_equal, to_not_break, to_break;

    to_have_properties := function(props_list...)
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
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
    end;

    to_equal := function(func2)
      local on_arguments;
      on_arguments := function(list_of_indices)
          local result1, args_list, i, j, arg, tests_failed, index, args_list2, result2;
          tests_failed := 0;
          for i in [1..no_reps] do
            for j in [1..max_size] do
              args_list := [];
              for arg in arg_gens do
                Append(args_list, [arg(j)]);
              od;
              result1 := CallFuncList(func, args_list);
              # assemble the set of arguments for the second function
              args_list2 := [];
              for index in list_of_indices do
                Append(args_list2, [args_list[index]]);
              od;
              result2 := CallFuncList(func2, args_list2);
              if not result1 = result2 then
                tests_failed := tests_failed + 1;
                Print("Test failed with arguments:\n");
                for arg in args_list do
                  Print(arg, "\n");
                od;
              fi;
            od;
          od;
          Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      end;
      return rec(on_arguments := on_arguments);
    end;

    to_not_break := function()
      local prev_value, args_list, i, j, exited_cleanly, tests_failed, arg;
      prev_value := BreakOnError;
      BreakOnError := false;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Append(args_list, [arg(j)]);
          od;
          exited_cleanly := CALL_WITH_CATCH(func, args_list)[1];
          if not exited_cleanly then
              Print("Test failed with arguments:\n");
              for arg in args_list do
                Print(arg, "\n");
              od;
              tests_failed := tests_failed + 1;
          fi;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      BreakOnError := prev_value;
    end;

    to_break := function()
      local prev_value, args_list, i, j, exited_cleanly, tests_failed, arg;
      prev_value := BreakOnError;
      BreakOnError := false;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Append(args_list, [arg(j)]);
          od;
          exited_cleanly := CALL_WITH_CATCH(func, args_list)[1];
          if exited_cleanly then
              Print("Test failed with arguments:\n");
              for arg in args_list do
                Print(arg, "\n");
              od;
              tests_failed := tests_failed + 1;
          fi;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      BreakOnError := prev_value;
    end;
    return rec(
    to_have_properties := to_have_properties,
    to_equal := to_equal,
    to_not_break := to_not_break
    );
  end;

  return rec(given := given);
end;

SetQuickcheckMaxSize := function(new_max)
  max_size := new_max;
end;

SetQuickcheckNumberOfReps := function(new_no)
  no_reps := new_no;
end;
