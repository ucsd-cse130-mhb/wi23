module Practice_Lec8 where

import Prelude hiding (length)

-- Practice with list function

-- 1) Write a recursive list function that takes an
--   arbitrary list as input and returns a list of
--   the same length where every element is "foo"

replaceAll :: [a] -> [String]
replaceAll xs = error "split this into equations with patterns"

-- >>> replaceAll []
-- []

-- >>> replaceAll [1, 2, 3]
-- ["foo", "foo", "foo"]


-- 2) Fill in the skeleton below to write a function
--   `mytake n xs` that returns a list consisting of 
--   the first n elements of xs. If n is too large, then
--   only return as many elements as you have. If n is
--   negative, then return an empty list.

mytake :: Int -> [a] -> [a]
mytake n xs = error "split this into equations with patterns"

-- >>> mytake 2 ['a', 'b', 'c', 'd']
-- ['a', 'b']

-- >>> mytake 7 ['a', 'b', 'c', 'd']
-- ['a', 'b', 'c', 'd']

-- >>> mytake (-2) ['a', 'b', 'c', 'd']
-- []