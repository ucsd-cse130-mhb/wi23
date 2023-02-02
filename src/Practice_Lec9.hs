module Hw3 where

data IntAndString = MkIntString Int String

lastEx :: IntAndString
lastEx = MkIntString 12 "cat"

dateFormat :: Date -> String
dateFormat (MkDate m d y) = monthName m ++ " " ++ show d ++ ", " ++ show y

monthName :: Int -> String
monthName 1 = "January"
monthName 2 = "February"
monthName 3 = "March"
monthName _ = "TBD"