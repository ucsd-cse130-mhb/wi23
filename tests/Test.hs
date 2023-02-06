{-# LANGUAGE ImportQualifiedPost #-}
import Practice_Lec10 (List (..), Tree (..), flipTree, isFlipped)
import Practice_Lec10 qualified as L10 -- don't blindly import map and filter
import Practice_Lec7
import Practice_Lec8
import Practice_Lec9
import Test.Hspec
import Test.QuickCheck
import Data.Foldable (foldl')

main :: IO ()
main = hspec $ do
  describe "Lecture 7: From λ to Haskell" $ do
    describe "and3" $ do
      specify "True True False => False" $ do
        and3 True True False `shouldBe` False

      it "ANDs three booleans" $
        property $ \b1 b2 b3 -> and3 b1 b2 b3 == (b1 && b2 && b3)

    describe "xor3" $ do
      specify "True True False => False" $ do
        xor3 True True False `shouldBe` False

      specify "True True True => True" $ do
        xor3 True True True `shouldBe` True

      specify "False True False => True" $ do
        xor3 False True False `shouldBe` True

      it "XORs three booleans" $
        -- /= works for xor here - if they're not equal xor is true
        property $ \b1 b2 b3 -> xor3 b1 b2 b3 == ((b1 /= b2) /= b3)
        
    describe "factorial" $ do
      specify "factorial 3 == 6" $ do
        factorial 3 `shouldBe` 6

      specify "factorial 0 == 1" $ do
        factorial 0 `shouldBe` 1

      specify "factorial (-90) == 1" $ do
        factorial (-90) `shouldBe` 1

      it "calculates the factorial of positive numbers" $
        property $ \(Positive n) -> factorial n == product [1..n]

      it "returns 1 for nonpositive numbers" $
        property $ \(NonPositive n) -> factorial n == 1

  describe "Lecture 8: Coding in Haskell" $ do
    describe "replaceAll" $ do
      specify "replaceAll [] == []" $ do
        replaceAll [] `shouldBe` []

      specify "replaceAll [1,2,3] == [\"foo\", \"foo\", \"foo\"]" $ do
        replaceAll [1, 2, 3] `shouldBe` ["foo", "foo", "foo"]

      it "replaces all elements in a list with 'foo'" $
        property $ \xs -> all (== "foo") (replaceAll (xs :: [Int]))

      it "has the same number of elements as the original list" $
        property $ \xs -> length (replaceAll xs) == length (xs :: [Int])

    describe "mytake" $ do
      specify "mytake 2 ['a', 'b', 'c', 'd'] == ['a', 'b']" $ do
        mytake 2 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b']

      specify "mytake 7 ['a', 'b', 'c', 'd'] == ['a', 'b', 'c', 'd']" $ do
        mytake 7 ['a', 'b', 'c', 'd'] `shouldBe` ['a', 'b', 'c', 'd']

      specify "mytake (-2) ['a', 'b', 'c', 'd'] == []" $ do
        mytake (-2) ['a', 'b', 'c', 'd'] `shouldBe` []

      it "takes the given number of elements from a list" $
        property $ \n xs -> mytake n xs == take n (xs :: String)

  describe "Lecture 9: Datatypes in Haskell" $ do
    describe "dateFormat" $ do
      specify "dateFormat (Date 12 12 2022) == \"December 12, 2022\"" $ do
        dateFormat (Date 12 12 2022) `shouldBe` "December 12, 2022"

    describe "timeFormat" $ do
      specify "timeFormat (Time 6 30 00) == \"06:30:00\"" $ do
        timeFormat (Time 6 30 00) `shouldBe` "06:30:00"

    describe "incrDate" $ do
      specify "incrDate (Date 2 28 2020) == (Date 2 29 2020)" $ do
        incrDate (Date 2 28 2020) `shouldBe` Date 2 29 2020

      specify "incrDate (Date 12 31 2022) == Date 1 1 2023" $ do
        incrDate (Date 12 31 2022) `shouldBe` Date 1 1 2023

    describe "wordCount" $ do
      -- can't do the listWordCount and paraWordCount tests here, because
      -- they are in a where statement and can't be imported here.

      specify "wordCount [Heading 2 \"Chapter One\", Text \"These are nearby beaches\", List False [\"Ocean Beach\", \"Pacific Beach\", \"Cardiff State Beach\", \"San Elijo State Beach\"] ]" $ do
        wordCount
          [ Heading 2 "Chapter One",
            Text "These are nearby beaches",
            List
              False
              [ "Ocean Beach",
                "Pacific Beach",
                "Cardiff State Beach",
                "San Elijo State Beach"
              ]
          ]
          `shouldBe` 17

      it "can determine the wordcount of any arbitrary paragraph" $ withMaxSuccess 50 $
        property $ \(ParagraphCounts p count) -> wordCount p == count

  describe "Lecture 10: All About Recursion" $ do
    describe "map" $ do
      specify "map negate [] == []" $ do
        L10.map negate Nil `shouldBe` Nil 

      specify "map (\\n -> n * n * n) [1, 3, 5, 7] == [1, 27, 125, 343]" $ do
        L10.map (\n -> n * n * n) (Cons 1 (Cons 3 (Cons 5 (Cons 7 Nil)))) `shouldBe` Cons 1 (Cons 27 (Cons 125 (Cons 343 Nil)))

      it "maps a function across a list" $
        property $ \(Fn f) xs -> map f xs == toHaskellList (L10.map f (toCustomList xs))

    describe "filter" $ do
      specify "filter (\\x -> True) [] == []" $ do
        L10.filter (\x -> True) Nil `shouldBe` Nil 

      specify "filter (\\x -> False) [1, 2, 3, 4, 5, 6] == []" $ do
        L10.filter (\x -> False) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 Nil)))))) `shouldBe` Nil 

      specify "filter (\\n -> n `mod` 2 == 0) [1, 2, 3, 4, 5, 6, 7] == [2, 4, 6]" $ do
        L10.filter (\n -> n `mod` 2 == 0) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 (Cons 7 Nil)))))))  `shouldBe` Cons 2 (Cons 4 (Cons 6 Nil)) 

      it "filters a list based on the given function" $
        property $ \(Fn f) xs -> filter f xs == toHaskellList (L10.filter f (toCustomList xs))

    describe "flipTree" $ do
      specify "flipTree Leaf == Leaf" $ do
        flipTree L10.Leaf `shouldBe` Leaf

      specify "flipTree (Node 5 Leaf (Node 1 Leaf Leaf)) == (Node 5 (Node 1 Leaf Leaf) Leaf)" $ do
        flipTree (Node 5 Leaf (Node 1 Leaf Leaf)) `shouldBe` Node 5 (Node 1 Leaf Leaf) Leaf

      specify "flipTree (Node 1 (Node 2 (Node 3 Leaf Leaf) Leaf) (Node 4 Leaf Leaf)) == Node 1 (Node 4 Leaf Leaf) (Node 2 Leaf (Node 3 Leaf Leaf))" $ do
        flipTree
          ( Node
              1
              (Node 2 (Node 3 Leaf Leaf) Leaf)
              (Node 4 Leaf Leaf)
          )
          `shouldBe` Node
            1
            (Node 4 Leaf Leaf)
            (Node 2 Leaf (Node 3 Leaf Leaf))

      it "correctly flips a tree" $
        property $ \t -> testIsFlipped t (flipTree t)

      it "is reversible when applied twice" $
        property $ \t -> t == flipTree (flipTree t)

    describe "isFlipped" $ do
      specify "isFlipped Leaf Leaf == True" $ do
        isFlipped Leaf Leaf `shouldBe` True

      specify "isFlipped (Node 5 Leaf (Node 1 Leaf Leaf)) (Node 5 Leaf (Node 1 Leaf Leaf)) == False" $ do
        isFlipped (Node 5 Leaf (Node 1 Leaf Leaf)) (Node 5 Leaf (Node 1 Leaf Leaf)) `shouldBe` False

      specify "isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 2 (Node 2 Leaf Leaf) Leaf) == False" $ do
        isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 2 (Node 2 Leaf Leaf) Leaf) `shouldBe` False

      specify "isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 1 (Node 1 Leaf Leaf) Leaf)" $ do
        isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 1 (Node 1 Leaf Leaf) Leaf) `shouldBe` True

      it "returns true for flipped trees" $
        property $ \t -> isFlipped t (flipTree t)

      it "returns false for non-flipped trees" $
        property $ \t t' -> (flipTree t /= t') ==> not (isFlipped t t')


-- Problem 9 Utils
data ParagraphCounts = ParagraphCounts [Paragraph] Int deriving (Show, Eq)

instance Arbitrary ParagraphCounts where
  arbitrary = sized $ \n -> do
    len <- arbitrary `suchThat` (<= n)
    paraLen <- vectorOf len $ frequency [(4, do
      words <- listOf (listOf1 (elements ['a'..'z']))
      frequency [(3, return (Text (unwords words), length words)), (1, (\h -> (Heading h (unwords words), length words)) <$> choose (1, 6))]
      ),
      (1, do
      words <- listOf (listOf (listOf1 (elements ['a'..'z'])))
      let len = foldl' (\acc words -> acc + length words) 0 words
      (\b -> (List b (map unwords words), len)) <$> arbitrary
      )]
    let (paras, len) = foldl' (\(paras, totallen) (para, len) -> (para:paras, totallen + len)) ([], 0) paraLen
    return $ ParagraphCounts paras len
  
-- Problem 10 Utils
-- Convert between List and [Int] to allow for [Int] generation
toHaskellList :: List -> [Int]
toHaskellList Nil = []
toHaskellList (Cons x xs) = x : toHaskellList xs

toCustomList :: [Int] -> List
toCustomList = foldr Cons Nil

treeLen :: Tree -> Int
treeLen Leaf = 0
treeLen (Node _ l r) = 1 + treeLen l + treeLen r

-- Generate random trees
instance Arbitrary Tree where
  arbitrary = sized $ \n -> if n == 0 then return Leaf else frequency [(1, return Leaf), (4, do
    elem <- arbitrary
    one <- resize (max 0 (n - 1)) arbitrary
    two <- resize (max 0 (n - 1 - treeLen one)) arbitrary
    oneof $ map return [Node elem one two, Node elem two one])]

-- PROBLEM 10 SPOILERS! Checks flipTree without assuming that the student's
-- isFlipped is correct. See Problem 10 solutions for an easier implementation of this
testIsFlipped :: Tree -> Tree -> Bool
testIsFlipped Leaf Leaf = True
testIsFlipped (Node e l r) (Node e' l' r') = (e == e') && testIsFlipped l r' && testIsFlipped r l'
testIsFlipped _ _ = False
