module Practice_Lec11 where

import Prelude hiding (map, foldr, foldl, sum)

-- Lecture: Monday, February 6, 2023
-- Practice with Tail Recursion and the Filter Pattern

-- 1) Implement a **tail-recursive** version of
--   the list function `replace` where 
--   `replace xs a b` returns a copy of `xs` where
--   every occurence of `a` has been replaced by `b`.
--   You can use the following library functions on
--   lists (as well as `(:)` and `[]`):
--     `(==)`, `(++)`, and `reverse`

replace :: [Int] -> Int -> Int -> [Int]
replace xs a b = error "TBD: replace implementation"
  where 
    helper acc []     = error "TBD: helper base case"
    helper acc (y:ys) = error "TBD: helper recursive case"

-- Here are some test cases.
-- >>> replace [1 , 2 , 3] 2 4
-- [1 , 4 , 3]
--
-- >>> replace [1 , 2 , 3] 4 5
-- [1 , 2 , 3]
--
-- >>> replace [1 , 2 , 2] 2 4
-- [1 , 4 , 4]

-- 2) Write a tail recurisve function that computes the 
--   average (mean) of a list of real numbers. You can use
--   list library functions, but using `sum` or 
--   `foldr`/`foldl` would defeat the purpose of the exercise.
--   Don't worry about the case of an empty input.

average :: [Float] -> Float
average xs = error "TBD: implement average"

-- >>> average [0.0, 3.0, 7.0]
-- 3.3333333
--
-- >>> average [0.333]
-- 0.333
--
-- >>> average [0.0, 3.0, 7.0, 4.0, 2.0, 4.0, 3.0, 2.0, 4.0, 5.1]
-- 3.41

-- Practice problem with `filter`.

-- 3) Let `xss` be a list of lists of the same length,
--   i.e. a matrix. Write a function
--   `evenEvens` using either `filter` or
--   list comprehensions such that `evenEvens xss`
--   returns a list (submatrix) of the rows of `xss` 
--   such that the row has an even number of even elements.

evenEvens :: [[Int]] -> [[Int]]
evenEvens xss = error "TBD: implement evenEvens"

-- Test Cases.
-- When the output is the empty matrix:
-- >>> evenEvens [[1, 2], [3, 4]]
-- []
--
-- >>> evenEvens [[1, 5, 7], [3, 1, 9]]
-- [[1, 5, 7], [3, 1, 9]]
--
-- >>> evenEvens [[2, 4, 5], [0, 4, 8], [3, 6, 2]]
-- [[2, 4, 5], [3, 6, 2]]
