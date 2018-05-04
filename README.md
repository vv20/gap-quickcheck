# GAP Quickcheck
This is a prototype of a property testing package, taking inspiration from the Haskell 
Quickcheck[1], Python Hypothesis[2] and Node.js Chai[3] libraries.

## Current Functionality

- Random generation of some types: integers, permutations and some groups.
- Generation of dependent types: lists, records and objects with more complex constructors.
- Running of a randomised test suite with properties that the result is expected to have or the
expected result.

## Development Plans

- Saving failed tests cases to avoid untraceable bugs.
- Allow filters to be passed to generators to generate more specific input.
- Shrink failed tests to the smallest failures.
- Compile into proper GAP package.

## API
The "randomgen.g" file contains functions for generating random input. All of these have the format of taking in a maximum size and returning an argument of that size or smaller. An exxception is the list generator, which takes another generator as an argument and returns a function for generating a list of those.

The "test_infrastructure.g" file has the functionality for running the tests. It should be used as:

```gap
Expect(func).given(list_of_argument_generators).to_have_properties(list_of_expected_properties);
```

The maximum input size and the number of repetitions for each size can be changed with the functions `SetQuickcheckMaxSize` and `SetQuickcheckNumberOfReps` respectively.

## References

- [1] Haskell Quickcheck: https://hackage.haskell.org/package/QuickCheck
- [2] Hypothesis: https://hypothesis.works/
- [3] Node.js Chai: http://www.chaijs.com/
