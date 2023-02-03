import Practice_Lec7
import Practice_Lec8
import Practice_Lec9
import Practice_Lec10
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Lecture 7: From λ to Haskell" $ do
      describe "and3" $ do
        specify "True True False => False" $ do
          and3 True True False `shouldBe` False

      describe "xor3" $ do
        specify "True True False => False" $ do
          xor3 True True False `shouldBe` False

        specify "True True True => True" $ do
          xor3 True True True `shouldBe` True

        specify "False True False => True" $ do
          xor3 False True False `shouldBe` True

      describe "factorial" $ do
        specify "factorial 3 == 6" $ do
          factorial 3 `shouldBe` 6

        specify "factorial 0 == 1" $ do
          factorial 0 `shouldBe` 1

        specify "factorial (-90) == 1" $ do
          factorial (-90) `shouldBe` 1

  describe "Lecture 8: Coding in Haskell" $ do
    describe "replaceAll" $ do
      specify "replaceAll [] == []" $ do
        replaceAll [] `shouldBe` []

      specify "replaceAll [1,2,3] == [\"foo\", \"foo\", \"foo\"]" $ do
        replaceAll [1,2,3] `shouldBe` ["foo", "foo", "foo"]

    describe "mytake" $ do
      specify "mytake 2 ['a', 'b', 'c', 'd'] == ['a', 'b']" $ do
        mytake 2 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b']

      specify "mytake 7 ['a', 'b', 'c', 'd'] == ['a', 'b', 'c', 'd']" $ do
        mytake 7 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b', 'c', 'd']

      specify "mytake (-2) ['a', 'b', 'c', 'd'] == []" $ do
        mytake (-2) ['a', 'b', 'c', 'd'] `shouldBe` []