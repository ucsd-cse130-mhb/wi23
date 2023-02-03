module Practice_Lec7 where

-- 1) Use patterns to implement a definition for a 
--   function that computes the Boolean AND of 
--   three Boolean arguments. What's the least number
--   of equations that you need to define this?

and3 :: Bool -> Bool -> Bool -> Bool
and3 True True True = True    -- if all 3 bools are True, return True
and3 _    _    _    = False   -- for any other case, return false.
                              -- _ will match any value that hasn't been
                              -- matched before.

-- >>> and3 True True False
-- False

-- 2) Use patterns to implement a definition for a 
--   function that computes the XOR of three 
--   Boolean bits. In other words (xor3 x y z) is
--   True if and only if an odd number of its arguments
--   are True. What's the least number of equations that
--   you need to define this?

xor3 :: Bool -> Bool -> Bool -> Bool
-- First, we'll match all the cases where 1 bool is true. We need to ensure
-- the other bools are false, so we don't use underscores.
-- True _ _ would match True True False, since _ would accept any value,
-- and that isn't what we want.
xor3 True  False False = True
xor3 False True  False = True
xor3 False False True  = True

-- Now, we need to match the case where 3 bools are true.
xor3 True  True  True  = True

-- We have captured all cases where an odd number of arguments are true.
-- Any other combination of bools will have an even number of Trues.
-- We can use underscore to set all of these to False.
xor3 _    _    _       = False

-- >>> xor3 True True False
-- False

-- >>> xor3 True True True
-- True

-- >>> xor3 False True False
-- True

-- 3) Give a recursive definition for factorial in Haskell
--   using whatever techniques you want. For the sake of
--   completeness set factorial n = 1 for any non-positive n.

factorial :: Int -> Int
factorial n
  | n <= 0 = 1  -- as stated in description: non-positive numbers should be 1
  | otherwise = n * factorial (n - 1)

-- >>> factorial 3
-- 6

-- >>> factorial 0
-- 1

-- >>> factorial (-90)
-- 1