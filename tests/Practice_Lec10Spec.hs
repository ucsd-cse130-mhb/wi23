{-# LANGUAGE ImportQualifiedPost #-}

module Practice_Lec10Spec where

import Practice_Lec10 (List (..), Tree (..), flipTree, isFlipped)
import Practice_Lec10 qualified as L10 -- don't blindly import map and filter
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 10: All About Recursion" $ do
  describe "map" $ do
    specify "map negate [] == []" $ do
      L10.map negate Nil `shouldBe` Nil

    specify "map (\\n -> n * n * n) [1, 3, 5, 7] == [1, 27, 125, 343]" $ do
      L10.map (\n -> n * n * n) (Cons 1 (Cons 3 (Cons 5 (Cons 7 Nil)))) `shouldBe` Cons 1 (Cons 27 (Cons 125 (Cons 343 Nil)))

    it "applies the given function to all list arguments, maintaining order" $
      property $
        \(Fn f) xs -> all (\(x, x') -> f x == x') (zip xs (ourMap f xs))

    it "maintains the same length as the original list" $
      property $
        \(Fn f) xs -> length xs == length (ourMap f xs)

    it "behaves identically to Haskell's map function" $
      property $
        \(Fn f) xs -> map f xs == ourMap f xs

  describe "filter" $ do
    specify "filter (\\x -> True) [] == []" $ do
      L10.filter (\x -> True) Nil `shouldBe` Nil

    specify "filter (\\x -> False) [1, 2, 3, 4, 5, 6] == []" $ do
      L10.filter (\x -> False) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 Nil)))))) `shouldBe` Nil

    specify "filter (\\n -> n `mod` 2 == 0) [1, 2, 3, 4, 5, 6, 7] == [2, 4, 6]" $ do
      L10.filter (\n -> n `mod` 2 == 0) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 (Cons 7 Nil))))))) `shouldBe` Cons 2 (Cons 4 (Cons 6 Nil))

    it "only has elements from the original list" $
      property $
        \(Fn f) xs -> all (`elem` xs) (ourFilter f xs)

    it "only holds elements that fulfill the filter, with the same order as the original list" $
      property $
        \(Fn f) xs -> filteredCheck f xs (ourFilter f xs)

    it "behaves identically to Haskell's filter function" $
      property $
        \(Fn f) xs -> filter f xs == ourFilter f xs

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
      property $
        \t -> testIsFlipped t (flipTree t)

    it "is reversible when applied twice" $
      property $
        \t -> t == flipTree (flipTree t)

  describe "isFlipped" $ do
    specify "isFlipped Leaf Leaf == True" $ do
      isFlipped Leaf Leaf `shouldBe` True

    specify "isFlipped (Node 5 Leaf (Node 1 Leaf Leaf)) (Node 5 Leaf (Node 1 Leaf Leaf)) == False" $ do
      isFlipped (Node 5 Leaf (Node 1 Leaf Leaf)) (Node 5 Leaf (Node 1 Leaf Leaf)) `shouldBe` False

    specify "isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 2 (Node 2 Leaf Leaf) Leaf) == False" $ do
      isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 2 (Node 2 Leaf Leaf) Leaf) `shouldBe` False

    specify "isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 1 (Node 1 Leaf Leaf) Leaf) == True" $ do
      isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 1 (Node 1 Leaf Leaf) Leaf) `shouldBe` True

    it "returns true for flipped trees" $
      property $
        \t -> isFlipped t (flipTree t)

    it "returns false for non-flipped trees" $
      property $
        \t t' -> (flipTree t /= t') ==> not (isFlipped t t')

-- Convert between List and [Int] to allow for [Int] generation
toHaskellList :: List -> [Int]
toHaskellList Nil = []
toHaskellList (Cons x xs) = x : toHaskellList xs

toCustomList :: [Int] -> List
toCustomList = foldr Cons Nil

-- Call our higher order List functions on an [Int]
hofOnList :: ((Int -> a) -> List -> List) -> (Int -> a) -> [Int] -> [Int]
hofOnList hof f xs = toHaskellList (hof f (toCustomList xs))

ourMap :: (Int -> Int) -> [Int] -> [Int]
ourMap = hofOnList L10.map

ourFilter :: (Int -> Bool) -> [Int] -> [Int]
ourFilter = hofOnList L10.filter

filteredCheck :: (Int -> Bool) -> [Int] -> [Int] -> Bool
filteredCheck _ [] [] = True
filteredCheck _ [] _ = False -- there are more elements in filtered list, it's wrong
filteredCheck f xs [] = not (any f xs) -- filtered list is empty, xs should have nothing that fits filter
filteredCheck f (x : xs) (y : ys)
  | f x = x == y && filteredCheck f xs ys -- check that x is in filtered list and continue
  | otherwise = filteredCheck f xs (y : ys) -- discard x, keep checking

treeLen :: Tree -> Int
treeLen Leaf = 0
treeLen (Node _ l r) = 1 + treeLen l + treeLen r

-- Generate random trees
instance Arbitrary Tree where
  arbitrary = sized $ \n ->
    if n == 0
      then return Leaf
      else oneof [return Leaf, Node <$> arbitrary <*> subtree n <*> subtree n]
    where
      subtree n = resize (n `div` 2) arbitrary

-- SPOILERS! Checks flipTree without assuming that the student's
-- isFlipped is correct. See Problem 10 solutions for an easier implementation of this
testIsFlipped :: Tree -> Tree -> Bool
testIsFlipped Leaf Leaf = True
testIsFlipped (Node e l r) (Node e' l' r') = (e == e') && testIsFlipped l r' && testIsFlipped r l'
testIsFlipped _ _ = False
