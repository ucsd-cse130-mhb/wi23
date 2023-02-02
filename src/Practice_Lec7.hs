module Practice_Lec7 where

-- 1) Use patterns to implement a definition for a 
--   function that computes the Boolean AND of 
--   three Boolean arguments. What's the least number
--   of equations that you need to define this?

and3 :: Bool -> Bool -> Bool -> Bool
and3 x y z = error "split this into equations with patterns"

-- >>> and3 True True False
-- False

-- 2) Use patterns to implement a definition for a 
--   function that computes the XOR of three 
--   Boolean bits. In other words (xor3 x y z) is
--   True if and only if an odd number of its arguments
--   are True. What's the least number of equations that
--   you need to define this?

xor3 :: Bool -> Bool -> Bool -> Bool
xor3 x y z = error "split this into equations with patterns"

-- >>> xor3 True True False
-- False

-- >>> xor3 True True True
-- True

-- >>> xor3 False True False
-- True

-- 3) Give a recursive definition for factorial in Haskell
--   using whatever techniques you want. For the sake of
--   completeness set factorial n = 1 for any negative n.

factorial :: Int -> Int
factorial n = error "add an implementation"

-- >>> factorial 3
-- 6

-- >>> factorial 0
-- 0

-- >>> factorial (-90)
-- 0