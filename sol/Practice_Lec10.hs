module Practice_Lec10 where

import Prelude hiding (filter, flip, map)

-- Lecture: Wednesday, February 1, 2023
-- Practice with Recursive Data Types

-- First, we'll work with our own version of
--   Haskell's lists as a recursive ADT:

data List = Nil           -- base constructor
          | Cons Int List -- inductive constructor
        deriving (Show, Eq)

-- 1) Implement a function `map` that takes a
--   function f (of type Int -> Int) and a list of
--   Ints and returns a new list that consists of
--   `f` applied to every element of the input list.

map :: (Int -> Int) -> List -> List
map _ Nil = Nil -- no items, empty list
map f (Cons x xs) = Cons (f x) (map f xs) -- apply f to x, cons to the result of mapping on rest of items

-- >>> map negate Nil
-- Nil

-- >>> map (\n -> n * n * n) (Cons 1 (Cons 3 (Cons 5 (Cons 7 Nil))))
-- Cons 1 (Cons 27 (Cons 125 (Cons 343 Nil)))

-- 2) Implement a function `filter` that takes a
--   function `f` (of type `Int -> Bool`) and a list of
--   Ints and returns a new list that consists only
--   of those elements `x` such that `f x` evaluates
--   to True.

filter :: (Int -> Bool) -> List -> List
filter _ Nil = Nil -- no items, empty list
filter f (Cons x xs)
  | f x = Cons x (filter f xs)    -- if f x is true, add x to list we're building
  | otherwise = filter f xs       -- if it's false, do not add it, just go to next items.
                                  -- this means that x won't be in the outputted list.

-- >>> filter (\x -> True) Nil
-- Nil

-- >>> filter (\x -> False) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 Nil))))))
-- Nil 

-- >>> filter (\n -> n `mod` 2 == 0) (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 (Cons 7 Nil))))))) 
-- Cons 2 (Cons 4 (Cons 6 Nil))

-- Use the first definition of `Tree` from the lecture
--   for the following two questions:

data Tree = Leaf | Node Int Tree Tree deriving (Show, Eq)

-- 3) Implement a function `flipTree`, that takes a Tree
--   as input and returns the "mirror image" of the Tree,
--   i.e. the tree with all the left and right children
--   swapped.

flipTree :: Tree -> Tree
flipTree Leaf = Leaf
-- note that we don't just switch l and r, we also have to recurse into them to flip their subtrees
flipTree (Node e l r) = Node e (flipTree r) (flipTree l)  

-- >>> flipTree Leaf
-- Leaf

-- >>> flipTree (Node 5 Leaf (Node 1 Leaf Leaf))
-- Node 5 (Node 1 Leaf Leaf) Leaf

-- >>> flipTree (Node 1
--          (Node 2 (Node 3 Leaf Leaf) Leaf)
--          (Node 4 Leaf Leaf) )
-- Node 1 (Node 4 Leaf Leaf)
--        (Node 2 Leaf (Node 3 Leaf Leaf))

-- 4) Finally, implement a function `isFlipped` that takes
--   two trees `t1` and `t2` as inputs and returns True
--   if and only if `t1` and `t2` are the mirror images
--   of each other (and contain the same data).

isFlipped :: Tree -> Tree -> Bool
isFlipped t1 t2 = treeEq (flipTree t1) t2
  where
    treeEq :: Tree -> Tree -> Bool
    treeEq Leaf Leaf = True
    treeEq (Node e1 l1 r1) (Node e2 l2 r2) = (e1 == e2) && treeEq l1 l2 && treeEq r1 r2
    treeEq _ _ = False  -- We have some mix of a Node and a Leaf, can't be equal.

-- >>> isFlipped Leaf Leaf
-- True

-- >>> isFlipped (Node 5 Leaf (Node 1 Leaf Leaf)) (Node 5 Leaf (Node 1 Leaf Leaf))
-- False

-- >>> isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 2 (Node 2 Leaf Leaf) Leaf)
-- False

-- >>> isFlipped (Node 1 Leaf (Node 1 Leaf Leaf)) (Node 1 (Node 1 Leaf Leaf) Leaf)
-- True
