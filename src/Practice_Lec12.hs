module Practice_Lec12 where

import Prelude hiding (sum, any)

-- Lecture: Wednesday, February 6, 2023
-- Practice with the Filter, Map, and Fold-Right Patterns

-- 1) As a warm-up, implement a function `consAll` 
--   without using recursion where `consAll x xss` 
--   takes an object and a **list of lists** and 
--   places the object at the front of every component 
--   list of `xss`. 

consAll :: a -> [[a]] -> [[a]]
consAll y xss = error "TBD: consAll implementation" 

-- Here are some test cases.
-- >>> consAll 7 [[1,2], [], [3]] 
-- [[7,1,2], [7], [7,3]]
--
-- >>> consAll 1 []
-- []
--
-- >>> consAll 1 [[]]
-- [[1]]

-- 2) Use the `consAll` function above to implement a
--   recursive function `subseqs` where `subseqs xs`
--   takes a list `xs` as its argument and returns
--   the list of all subsequences of `xs`. A *subsequence*
--   is defined to be a list of elements drawn `xs` that
--   are not necessarily adjacent but which must appear in
--   the same order as they do in `xs`.

subseqs :: [a] -> [[a]]
subseqs xs = error "TBD: subseqs implementation"

-- Here are some test cases. There's no inherent order to the
-- different subsequences, so your implementation may return
-- them in a different order than shown below.
-- >>> subseqs []
-- [[]]
-- 
-- >>> subseqs [1]
-- [[], [1]]
--
-- >>> subseqs [1, 2, 3]
-- [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]


-- 3) Implement a function `any` using folds where
--   `any p xs` takes a predicate `p` (a Boolean-valued
--   function) and a list `xs` and returns True if some
--   element of `xs` satisfies `p` (i.e. `p x` returns True)
--   and False otherwise.

any :: (a -> Bool) -> [a] -> Bool
any p xs = error "TBD: any implementation"

-- Here are some test cases.
-- >>> any (> 7) [1, 2, 3, 4, 5, 6, 7] 
-- False
--
-- >>> any (\x -> True) []
-- False
--
-- >>> any not [True, True, False, True]
-- True

-- 4) CHALLENGE: Now try to write a **non-recursive**
--   version of `subseqs` using both `consAll` and 
--   `foldr`.

subseqs' :: [a] -> [[a]]
subseqs' xs = error "TBD: subseqs implementation"

-- Here are some test cases. There's no inherent order to the
-- different subsequences, so your implementation may return
-- them in a different order than shown below.
-- >>> subseqs' []
-- [[]]
-- 
-- >>> subseqs' [1]
-- [[], [1]]
--
-- >>> subseqs' [1, 2, 3]
-- [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]
