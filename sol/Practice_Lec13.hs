module Practice_Lec13 where

import Prelude hiding (sum, any, maximum, minimum)

-- Lecture: Friday, February 8, 2023
-- Practice with the Fold-Left Pattern

-- 1) Using left folds, re-implement the standard 
--   library function `maximum` from the Prelude
--   that returns the maximal element in a list.
--   Note that `maximum` is undefined for an empty
--   list (the Prelude version throws an error).
--   It may help to use a pattern on the left hand 
--   side of the equals.

maximum :: [Int] -> Int
maximum (xh:xt) = foldl f b ys
  where 
    f acc x = if acc > x then acc else x
    -- for xh/xt, you could also `head xs`/`tail xs`
    b       = xh
    ys :: [Int]
    ys      = xt

-- >>> maximum [1]
-- 1
--
-- >>> maximum [1, 4, 2, 1, 3, 0]
-- 4

-- 2)  Re-implement the `filter` function
--   **using** `foldl` instead. In other words,
--   complete the definition of `myFilter` such that
--   `myFoldr p xs` evaluates to the same value
--   as `foldr p xs`.

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p xs = foldl f [] xs
  where f acc x = if p x then acc ++ [x] else acc

-- Some test cases
--
-- >>> myFilter (\x -> True) []
-- []
--
-- >>> myFilter (\x -> False) [1, 2, 3, 4]
-- []
--
-- >>> myFilter (> 10) [43, 2, 15, 12, 9, 0, 1]
-- [43, 15, 12]


-- 3) CHALLENGE: Re-implement the `foldr` function
--   **using** `foldl` instead. In other words,
--   complete the definition of `myFoldr` such that
--   `myFoldr f b xs` evaluates to the same value
--   as `foldr f b xs`.
--
-- Hint: think about how `foldr` and `foldl` expand
-- out and what you might need to manipulate and what
-- other list functions or HOFs might be useful.
--
-- foldr f b [x1, x2, ..., xn] == x1 ‘f‘ (x2 ‘f‘ ... (xn ‘f‘ b)...)
-- foldl f b [x1, x2, ..., xn] == (...((b ‘f‘ x1) ‘f‘ x2) ‘f‘...) ‘f‘ xn

myFoldr :: (a -> b -> b) -> b -> [a] -> b
-- to emulate foldr, we turn (x `f`) into its own function,
-- and fold them into one function with composition
-- (x1 `f`) . (x2 `f`) . (x3 `f`)
-- then call it with base
myFoldr f base xs = foldl rightCompose id xs base
  where
    rightCompose acc x = acc . (f x)

-- >>> myFoldr (+) 0 [1, 2, 3, 4, 5, 6, 7] 
-- 28
--
-- >>> myFoldr (:) [] ['a', 'b', 'c', 'd']
-- ['a', 'b', 'c', 'd']
--
-- >>> myFoldr (flip (++)) "" ["apple", "banana", "mango"]
-- "mangobananaapple"
