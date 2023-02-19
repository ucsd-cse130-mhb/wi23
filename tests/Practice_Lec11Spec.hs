{-# LANGUAGE ImportQualifiedPost #-}

module Practice_Lec11Spec where

import Practice_Lec11
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 11: Beyond Recursion" $ do

  describe "replace" $ do
    specify "replace [1 , 2 , 3] 2 4 == [1 , 4 , 3]" $ do
      replace [1 , 2 , 3] 2 4 `shouldBe` [1 , 4 , 3] 

    specify "replace [1 , 2 , 3] 4 5 == [1 , 2 , 3]" $ do
      replace [1 , 2 , 3] 4 5 `shouldBe` [1 , 2 , 3] 

    specify "replace [1 , 2 , 2] 2 4 == [1 , 4 , 4]" $ do
      replace [1 , 2 , 2] 2 4 `shouldBe` [1 , 4 , 4] 

    it "has the same number of elements as the original list" $
      property $
        \xs a b -> length (replace xs a b) == length (xs :: [Int])

  describe "average" $ do
    specify "average [0.0, 3.0, 7.0] == 3.3333333" $ do
      average [0.0, 3.0, 7.0] `shouldBe` 3.3333333

    specify "average [0.333] == 0.333" $ do
      average [0.333] `shouldBe` 0.333

    specify "average [0.0, 3.0, 7.0, 4.0, 2.0, 4.0, 3.0, 2.0, 4.0, 5.1] == 3.41" $ do
      average [0.0, 3.0, 7.0, 4.0, 2.0, 4.0, 3.0, 2.0, 4.0, 5.1] `shouldBe` 3.41

  describe "evenEvens" $ do
    specify "evenEvens [[1, 2], [3, 4]] == []" $ do
      evenEvens [[1, 2], [3, 4]] `shouldBe` []

    specify "evenEvens [[1, 5, 7], [3, 1, 9]] == [[1, 5, 7], [3, 1, 9]]" $ do
      evenEvens [[1, 5, 7], [3, 1, 9]] `shouldBe` [[1, 5, 7], [3, 1, 9]]

    specify "evenEvens [[2, 4, 5], [0, 4, 8], [3, 6, 2]] == [[2, 4, 5], [3, 6, 2]]" $ do
      evenEvens [[2, 4, 5], [0, 4, 8], [3, 6, 2]] `shouldBe` [[2, 4, 5], [3, 6, 2]]
