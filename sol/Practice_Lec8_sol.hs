module Practice_Lec8 where

import Prelude hiding (length)

-- Practice with list function

-- 1) Write a recursive list function that takes an
--   arbitrary list as input and returns a list of
--   the same length where every element is "foo"

replaceAll :: [a] -> [String]
replaceAll [] = []                         -- base case: empty list to []
replaceAll (_:xs) = "foo" : replaceAll xs  -- recursive: match on (x : xs),
                                           -- where x would be the head of
                                           -- the list (first element) and
                                           -- xs is the tail (rest of the
                                           -- list).
                                           -- We set x to underscore because
                                           -- we don't care about what the value
                                           -- of the head is: we just want to
                                           -- replace it with foo.
                                           -- for each element x, replace it
                                           -- with foo and add it to the rest of
                                           -- the list replaced with xs via
                                           -- a recursive call.

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
mytake n _ | n <= 0 = []              -- if number is non-positive, return []

mytake _ [] = []                      -- if list is empty, return empty list.
                                      -- We don't care about the number, we
                                      -- have no values to return. This handles
                                      -- the case where n is too large

mytake n (x:xs) = x : mytake (n-1) xs -- when we have elements and a positive n
                                      -- (if n was nonpositive, it would have
                                      -- matched the first pattern), return x
                                      -- and take n-1 elements from remaining
                                      -- list elements

-- >>> mytake 2 ['a', 'b', 'c', 'd']
-- ['a', 'b']

-- >>> mytake 7 ['a', 'b', 'c', 'd']
-- ['a', 'b', 'c', 'd']

-- >>> mytake (-2) ['a', 'b', 'c', 'd']
-- []