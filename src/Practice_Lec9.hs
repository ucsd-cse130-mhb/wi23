module Hw3 where

-- Practice with Product/Sum Data Types

data Date = Date Int Int Int
data Time = Time Int Int Int

-- 1) Write functions to convert each of these 
--   data types to Strings by implementing a 
--   function for each data type. 
--
-- Hints: We can use ++ to concatenate strings
--        We can call `show` on Ints to get strings

dateFormat :: Date -> String
dateFormat (Date m d y) = error "fill this in"
  where
    monthName :: Int -> String
    monthName 1 = "January"
    monthName 2 = "February"
    monthName 3 = "March"
    monthName _ = error "Fill in the rest"

-- >>> dateFormat (Date 12 12 2022)
-- "December 12, 2022"

timeFormat :: Date -> String
timeFormat (Time h m s) = error "fill this in"

-- >>> timeFormat (Time 6 30 00)
-- "06:30:00"

-- 2) Write a function `incrDate` that takes a Date
--   object as its input and returns the next date.



-- >>> incrDate (Date 2 28 2020)
-- Date 2 29 2020