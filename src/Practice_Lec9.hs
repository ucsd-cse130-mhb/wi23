module Practice_Lec9 where

-- Lecture: Monday, January 30, 2023
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

timeFormat :: Time -> String
timeFormat (Time h m s) = error "fill this in"

-- >>> timeFormat (Time 6 30 00)
-- "06:30:00"

-- 2) Write a function `incrDate` that takes a Date
--   object as its input and returns the next date.
--   To reduce the corner cases, just assume the date
--   is a valid date in the 21st century.

incrDate :: Date -> Date
incrDate (Date m d y) = error "fill this in"

-- >>> incrDate (Date 2 28 2020)
-- Date 2 29 2020

-- >>> incrDate (Date 12 31 2022)
-- Date 1 1 2023

-- 3) Recall the Paragraph data type from lecture,
--   which combines both sum types and product types
--   and was used to represent a toy model of a 
--   subset of Markdown.

data Paragraph = 
    Text String          -- 3 constructors,
  | Heading Int String   -- each with different  
  | List Bool [String]   -- parameters

--   Write a function `wordCount` which returns the total
--   word count in a list of paragraph objects. The following
--   function from the Prelude will be useful:
--
--   words :: String -> [String]
--   "words breaks a string up into a list of words, which were 
--   delimited by white space.""
--
--   >>> words "Lorem ipsum\ndolor"
--   ["Lorem","ipsum","dolor"]"

wordCount :: [Paragraph] -> Int
wordCount ps = error "use patterns and fill this in"
  where 
    listWordCount :: [String] -> Int
    listWordCount []       = error "try this helper function"
    listWordCount (s:strs) = error "try this helper function"

    paraWordCount :: Paragraph -> Int
    paraWordCount p = error "and this one too" 

-- >>> listWordCount ["wow","","this is a bullet point"]
-- 6

-- >>> paraWordCount (Heading 2 "Chapter One")
-- 2

-- >>> wordCount [Heading 2 "Chapter One",
--                Text "These are nearby beaches",
--                List False ["Ocean Beach", "Pacific Beach",
--                            "Cardiff State Beach", 
--                            "San Elijo State Beach"] ]
-- 17
 