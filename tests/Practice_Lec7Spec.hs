module Practice_Lec7Spec where

import Practice_Lec7
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 7: From λ to Haskell" $ do
  describe "and3" $ do
    specify "True True False => False" $ do
      and3 True True False `shouldBe` False

    it "ANDs three booleans" $
      property $
        \b1 b2 b3 -> and3 b1 b2 b3 == (b1 && b2 && b3)

  describe "xor3" $ do
    specify "True True False => False" $ do
      xor3 True True False `shouldBe` False

    specify "True True True => True" $ do
      xor3 True True True `shouldBe` True

    specify "False True False => True" $ do
      xor3 False True False `shouldBe` True

    it "XORs three booleans" $
      -- /= works for xor here - if they're not equal xor is true
      property $
        \b1 b2 b3 -> xor3 b1 b2 b3 == ((b1 /= b2) /= b3)

  describe "factorial" $ do
    specify "factorial 3 == 6" $ do
      factorial 3 `shouldBe` 6

    specify "factorial 0 == 1" $ do
      factorial 0 `shouldBe` 1

    specify "factorial (-90) == 1" $ do
      factorial (-90) `shouldBe` 1

    it "calculates the factorial of positive numbers" $
      property $
        \(Positive n) -> factorial n == product [1 .. n]

    it "returns 1 for nonpositive numbers" $
      property $
        \(NonPositive n) -> factorial n == 1
