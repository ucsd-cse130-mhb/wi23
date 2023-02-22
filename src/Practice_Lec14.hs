module Practice_Lec14 where

import Prelude -- hiding (sum, any, maximum, minimum)
import Data.Set

-- Lecture: Monday, February 13, 2023
-- Practice with Basic Nano

type Id = String

type Binop = Add | Sub | Mul

data Expr = Num Int -- number
          | Var Id -- variable
          | Bin Binop Expr Expr -- binary expression
          | Let Id Expr Expr -- let expression

-- 1) We covered the `eval` function that forms the
--   backbone of our interpreter in lecture, but
--   there are other functions that are also 
--   relevant to the study and implementation of
--   functional languages.
--
--   First implement the function `fv` that returns
--   the set of free variables in a expression. This is 
--   the set of variables that occur free at least once.
--
--   In order to talk about sets, we'll import the 
--   Data.Set module from the standard library.
--
--   Useful Set-related objects and functions:
--   
--   `empty`          the empty set
--   `singleton x`    the set containing just` x`
--   `fromList xs`    creates a set from a list `xs` of elements
--   `union s1 s2`            union of two sets
--   `intersection s1 s2`     intersection of two sets
--   `s1 \\ s2`       elements of s1 that are not in s2 (i.e. s1 \ s2 or s1 - s2)
--   `insert z s1`    add z to set s1, or (s1 `union` singleton z)
--   `delete z s1`    remove z from s1, i.e. (s1 \\ singleton z)

--   Examples of using Data.Set:
--
-- >>> singleton "cat"
-- fromList ["cat"]
--
-- >>> singleton "x" `union` singleton "y"
-- fromList ["x","y"]
--
-- >>> fromList ["z","y","x"] \\ fromList ["w", "y", "v"]
-- fromList ["x","z"]
--
-- >>> delete "z" (fromList ["x", "y"])
-- fromList ["x","y"]

fv :: Expr -> Set Id
fv e = error "TBD: fv implementation"

--  Test cases
--
-- >>> fv (Bin Add (Num 2) (Num 3))
-- fromList []
--
-- >>> fv (Let "x" (Num 1) (Let "z" (Num 2) (Bin Mul (Var "x") (Var "y"))))
-- fromList ["y"]

-- 2) Now write a function `rename` that will rename 
--   all **free** occurrences of a particular variable. In
--   other words `rename x y e` will rename every
--   free occurence of `x` in `e` to `y`. Note that
--   it is possible to use `rename` and end up with
--   a captured `y`, but don't worry about that here.

rename :: Id -> Id -> Expr -> Expr
rename x y e = error "TBD: rename implementation"

--  Test cases
--
-- >>> rename "x" "cat" (Bin Add (Num 2) (Num 3))
-- Bin Add (Num 2) (Num 3)
--
-- >>> rename "x" "z" (Let "x" (Num 1) (Bin Mul (Var "x") (Var "y")))
-- Let "x" (Num 1) (Bin Mul (Var "x") (Var "y"))
--
-- >>> rename "y" "z" (Let "x" (Num 1) (Bin Mul (Var "x") (Var "y")))
-- Let "x" (Num 1) (Bin Mul (Var "x") (Var "z"))