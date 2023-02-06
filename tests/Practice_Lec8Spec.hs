module Practice_Lec8Spec where

import Practice_Lec8
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 8: Coding in Haskell" $ do
  describe "replaceAll" $ do
    specify "replaceAll [] == []" $ do
      replaceAll [] `shouldBe` []

    specify "replaceAll [1,2,3] == [\"foo\", \"foo\", \"foo\"]" $ do
      replaceAll [1, 2, 3] `shouldBe` ["foo", "foo", "foo"]

    it "replaces all elements in a list with 'foo'" $
      property $
        \xs -> all (== "foo") (replaceAll (xs :: [Int]))

    it "has the same number of elements as the original list" $
      property $
        \xs -> length (replaceAll xs) == length (xs :: [Int])

  describe "mytake" $ do
    specify "mytake 2 ['a', 'b', 'c', 'd'] == ['a', 'b']" $ do
      mytake 2 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b']

    specify "mytake 7 ['a', 'b', 'c', 'd'] == ['a', 'b', 'c', 'd']" $ do
      mytake 7 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b', 'c', 'd']

    specify "mytake (-2) ['a', 'b', 'c', 'd'] == []" $ do
      mytake (-2) ['a', 'b', 'c', 'd'] `shouldBe` []

    it "takes the given number of elements from a list" $
      property $
        \n xs -> mytake n xs == take n (xs :: String)
