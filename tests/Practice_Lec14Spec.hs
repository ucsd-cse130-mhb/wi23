{-# LANGUAGE ImportQualifiedPost #-}

module Practice_Lec14Spec where

import Practice_Lec14
import Data.Set
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 14: Nano" $ do

  describe "fv" $ do
    specify "fv (Bin Add (Num 2) (Num 3)) == fromList []" $ do
      fv (Bin Add (Num 2) (Num 3)) `shouldBe` fromList [] 

    specify "fv (Let \"x\" (Num 1) (Let \"z\" (Num 2) (Bin Mul (Var \"x\") (Var \"y\")))) == fromList [\"y\"]" $ do
      fv (Let "x" (Num 1) (Let "z" (Num 2) (Bin Mul (Var "x") (Var "y")))) `shouldBe` fromList ["y"] 


  describe "rename" $ do
    specify "rename \"x\" \"cat\" (Bin Add (Num 2) (Num 3)) == Bin Add (Num 2) (Num 3)" $ do
      rename "x" "cat" (Bin Add (Num 2) (Num 3)) `shouldBe` Bin Add (Num 2) (Num 3)

    specify "rename \"x\" \"z\" (Let \"x\" (Num 1) (Bin Mul (Var \"x\") (Var \"y\"))) == Let \"x\" (Num 1) (Bin Mul (Var \"x\") (Var \"y\"))" $ do
      rename "x" "z" (Let "x" (Num 1) (Bin Mul (Var "x") (Var "y"))) `shouldBe` Let "x" (Num 1) (Bin Mul (Var "x") (Var "y"))

    specify "rename \"y\" \"z\" (Let \"x\" (Num 1) (Bin Mul (Var \"x\") (Var \"y\"))) == Let \"x\" (Num 1) (Bin Mul (Var \"x\") (Var \"z\"))" $ do
      rename "y" "z" (Let "x" (Num 1) (Bin Mul (Var "x") (Var "y"))) `shouldBe` Let "x" (Num 1) (Bin Mul (Var "x") (Var "z"))

    --it "x is no longer a free variable in e after rename" $
    --  property $
    --    \x y e -> member x (fv (rename x y e)) == False