import Test.Tasty
import Common
import Hw3 

main :: IO ()
main = runTests [unit1, unit2]

unit1 :: Score -> TestTree
unit1 sc = testGroup "Elsa Unit"
  [ mkTest
      (check "01_fixpoint.lc")
      "fact_zero"
      True
      10
      "fact_zero"
  , mkTest
      (check "01_fixpoint.lc")
      "fact_one"
      True
      10
      "fact_one"
  , mkTest
      (check "01_fixpoint.lc")
      "fact_two"
      True
      10
      "fact_two"
  , mkTest
      (check "01_fixpoint.lc")
      "fact_three"
      True
      10
      "fact_three"
  , mkTest
      (check "01_fixpoint.lc")
      "mod_one_two"
      True
      10
      "mod_one_two"
  , mkTest
      (check "01_fixpoint.lc")
      "mod_two_two"
      True
      10
      "mod_two_two"
  , mkTest
      (check "01_fixpoint.lc")
      "mod_three_two"
      True
      10
      "mod_three_two"
  , mkTest
      (check "01_fixpoint.lc")
      "mod_four_two"
      True
      10
      "mod_four_two"
  , mkTest
      (check "02_lists.lc")
      "clone_zero"
      True
      8
      "clone_zero"
  , mkTest
      (check "02_lists.lc")
      "clone_one"
      True
      8
      "clone_one"
  , mkTest
      (check "02_lists.lc")
      "clone_two"
      True
      8
      "clone_two"
  , mkTest
      (check "02_lists.lc")
      "haszero_nil"
      True
      8
      "haszero_nil"
  , mkTest
      (check "02_lists.lc")
      "haszero_yes"
      True
      8
      "haszero_yes"
  , mkTest
      (check "02_lists.lc")
      "haszero_no"
      True
      8
      "haszero_no"
  , mkTest
      (check "02_lists.lc")
      "concat_nil_nil"
      True
      8
      "concat_nil_nil"
  , mkTest
      (check "02_lists.lc")
      "concat_one_nil"
      True
      8
      "concat_one_nil"
  , mkTest
      (check "02_lists.lc")
      "concat_nil_one"
      True
      8
      "concat_nil_one"
  , mkTest
      (check "02_lists.lc")
      "concat_one_one"
      True
      8
      "concat_one_one"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> IO b) -> a -> b -> Int -> String -> TestTree
    mkTest = scoreElsaTest' sc

unit2 :: Score -> TestTree
unit2 sc = testGroup "Haskell Unit"
  [ mkTest
      (\_ -> clone 5 2)
      ()
      [2,2,2,2,2]
      5
      "clone 1"
  , mkTest
      (\_ -> clone 3 "cat")
      ()
      ["cat","cat","cat"]
      5
      "clone 2"
  , mkTest
      lengthOne
      []
      False
      5
      "lengthOne 0"
  , mkTest
      lengthOne
      [-2]
      True
      5
      "lengthOne 1"
  , mkTest
      lengthOne
      [1, 3, 5]
      False
      5
      "lengthOne 2"
  , mkTest
      listReverse
      ([] :: [Int])
      ([] :: [Int])
      5
      "reverse 0"
  , mkTest
      listReverse
      [1, 2, 3, 4]
      [4, 3, 2, 1]
      5
      "reverse 1"
  , mkTest
      listReverse
      ["a", "b", "c", "d"]
      ["d", "c", "b", "a"]
      5
      "reverse 2"
  , mkTest
      palindrome
      "malayalam"
      True
      5
      "palindrome 1"
  , mkTest
      palindrome
      "myxomatosis"
      False
      5
      "palindrome 2"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> b) -> a -> b -> Int -> String -> TestTree
    mkTest f x r n name = scoreTest' sc (f,x,r,n,name)
