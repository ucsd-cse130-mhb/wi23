{- | CSE 130: Intro to Haskell Assignment.
     Do not change the skeleton code!

     You may only replace the `error "TBD:..."` parts.

     For this assignment, you may use any library function on integers
     but only the following library functions on lists:

     length
     (++)
     (==)

 -}

module Hw3 where

import Prelude  hiding (elem, replicate, sum, reverse)

-- | clone: Make n copies of a String
--
-- >>> clone 5 2
-- [2, 2, 2, 2, 2]
--
-- >>> clone 3 "cat"
-- ["cat","cat","cat"]

clone :: Int -> a -> [a]
clone n x 
  | n <= 0    = error "fill this in"
  | otherwise = error "fill this in"


-- | Is the length of the list exactly one?
--
-- >>> lengthOne []
-- False
--
-- >>> lengthOne [-2]
-- True
--
-- >>> lengthOne [1, 3, 5]
-- False

lengthOne :: [a] -> Bool
lengthOne xs = error "TBD:sumList"

-- | listReverse [x1,x2,...,xn] returns [xn,...,x2,x1]
--
-- >>> listReverse []
-- []
--
-- >>> listReverse [1,2,3,4]
-- [4,3,2,1]
--
-- >>> listReverse ["i", "want", "to", "ride", "my", "bicycle"]
-- ["bicycle", "my", "ride", "to", "want", "i"]

listReverse :: [a] -> [a]
listReverse xs = error "TBD"

-- | In Haskell, a `String` is a simply a list of `Char`, that is:
--
-- >>> ['h', 'a', 's', 'k', 'e', 'l', 'l']
-- "haskell"
--
-- >>> palindrome "malayalam"
-- True
--
-- >>> palindrome "myxomatosis"
-- False

palindrome :: String -> Bool
palindrome w = error "TBD"
