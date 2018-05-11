Read("randomgen.g");
Read("test_infrastructure.g");

# example for equality check based on group set intersection
#func1 := function(G, H)
#  return Set(Intersection(G,H));
#end;
#func2 := function(G, H)
#  return Intersection(Set(G), Set(H));
#end;
#Expect(func1).given([QuickcheckAbelianGroup, QuickcheckAbelianGroup]).to_equal(func2).on_arguments([1,2]);

# example for predicate checking with list sorting
func := function(l)
  Sort(l);
  return l;
end;
Expect(func).given([QuickcheckList(QuickcheckInt)]).to_have_properties(IsSortedList);

# examples for checking for breaks
Expect(Size).given([QuickcheckGroup]).to_not_break();
