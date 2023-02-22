module Practice_Lec15 where

import Prelude -- hiding (sum, any, maximum, minimum)
import Data.Set

-- Lecture: Wednesday, February 53, 2023
-- Practice with the full Nano

-- First we'll repeat the practice exercises from
-- last time in the setting of the full Nano.

type Id = String

type Binop = Add | Sub | Mul

data Expr = Num Int -- number
          | Var Id -- variable
          | Bin Binop Expr Expr -- binary expres
          | Let Id Expr Expr -- let expression
          | Lam Id Expr -- abstraction
          | App Expr Expr -- application

data Value = VNum Int
           | VLam Id Expr -- formal + body

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

fv :: Expr -> Set Id
fv e = error "TBD: fv implementation"

--  Test cases
--
-- >>> fv (Lam "x" (Bin Add (Var "x") (Num 3)))
-- fromList []
--
-- >>> fv (App (Lam "x" (Bin Add (Var "x") (Num 3))) (Var "x"))
-- fromList ["x"]

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
-- >>> rename "x" "cat" (Bin Add (Num 2) (Var "x"))
-- Bin Add (Num 2) (Var "cat")
--
-- >>> rename "x" "z" (Lam "x" (Bin Mul (Var "x") (Var "y")))
-- Lam "x" (Bin Mul (Var "x") (Var "y"))
--
-- >>> rename "y" "z" (Lam "x" (Bin Mul (Var "x") (Var "y")))
-- Lam "x" (Bin Mul (Var "x") (Var "z"))

-- 3) Implement a function `noLets` where `noLets e` returns
--    `True` if the input `e` does not contain any `Let` bindings
--    and `False` if it does. We'll use it later.

noLets :: Expr -> Bool
noLets e = error "TBD: noLets implementation"

-- Test Cases
--
-- >>> noLets (Lam "x" (Bin Mul (Var "x") (Var "y")))
-- True
--
-- >>> noLets (Let "x" (Num 1) (Bin Mul (Var "x") (Var "y")))
-- False
--
-- >>> noLets (App (Lam "x" (Var "x")) (Let "y" (Num 2) (Var "y")))
-- False

-- 4) We mentioned at various points in the lectures that 
--    language features like let-bindings are just syntactic
--    sugar. The let-bindings can even be replaced with
--    lambda abstractions and function application without 
--    using any Church encodings or anything complicated. Think
--    about how a let-binding is a combination of a function
--    definition and the immediate application of it
--
--    Implement a function `desugar` that takes an Expr as input
--    and outputs an Expr without any Let bindings that behaves
--    identically to the input under evaluation;
--    i.e. for any `e` we must have `noLets (desugar e) => True`.
--
--    You can copy-paste in the `eval` function from Wed Feb 21's 
--    lecture notes to help with testing.

desugar :: Expr -> Expr
desugar e = error "TBD: desugar implementation"

-- Test Cases
--
-- >>> desugar (Lam "x" (Bin Mul (Var "x") (Var "y")))
-- (Lam "x" (Bin Mul (Var "x") (Var "y")))
--
-- >>> eval [("y", 4)] (desugar (Let "x" (Num 3) (Bin Add (Var "x") (Num 4))))
-- VNum 7
--