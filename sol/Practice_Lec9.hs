module Practice_Lec9 where

-- Lecture: Monday, January 30, 2023
-- Practice with Product/Sum Data Types

data Date = Date Int Int Int deriving (Show, Eq)

data Time = Time Int Int Int deriving (Show, Eq)

-- 1) Write functions to convert each of these
--   data types to Strings by implementing a
--   function for each data type.
--
-- Hints: We can use ++ to concatenate strings
--        We can call `show` on Ints to get strings

dateFormat :: Date -> String
dateFormat (Date m d y) = monthName m ++ " " ++ show d ++ ", " ++ show y
  where
    monthName :: Int -> String
    monthName 1 = "January"
    monthName 2 = "February"
    monthName 3 = "March"
    monthName 4 = "April"
    monthName 5 = "May"
    monthName 6 = "June"
    monthName 7 = "July"
    monthName 8 = "August"
    monthName 9 = "September"
    monthName 10 = "October"
    monthName 11 = "November"
    monthName 12 = "December"
    monthName i = error ("Invalid month number: " ++ show i)

-- >>> dateFormat (Date 12 12 2022)
-- "December 12, 2022"

timeFormat :: Time -> String
timeFormat (Time h m s) = intToTwoCharStr h ++ ":" ++ intToTwoCharStr m ++ ":" ++ intToTwoCharStr s
  where
    -- We need numbers like 6 to turn into a string 06.
    -- If this wasn't an exercise, you'd use
    -- Text.printf to do this formatting for you.
    intToTwoCharStr :: Int -> String
    intToTwoCharStr i
      | i < 10 = "0" ++ show i
      | i < 100 = show i
      | otherwise = error (show i ++ " larger than 100")

-- >>> timeFormat (Time 6 30 00)
-- "06:30:00"

-- 2) Write a function `incrDate` that takes a Date
--   object as its input and returns the next date.
--   To reduce the corner cases, just assume the date
--   is a valid date in the 21st century.

incrDate :: Date -> Date
incrDate (Date m d y)
  | lastDayOfYear (Date m d y) = Date 1 1 (y + 1) -- end of December case
  | lastDayOfMonth (Date m d y) = Date (m + 1) 1 y -- end of any other month case
  | otherwise = Date m (d + 1) y -- increment day within month
  where
    contains :: [Int] -> Int -> Bool
    contains [] _ = False -- no more elements to check, return false
    contains (x : xs) i
      | x == i = True -- we found element!
      | otherwise = contains xs i -- check the rest of the elements

    lastDayOfMonth :: Date -> Bool
    lastDayOfMonth (Date month day year) =
      day
        == ( case month of
               -- this heavily uses guards. if the boolean is true, then the pattern will be accepted
               i | contains [1, 3, 5, 7, 8, 10, 12] i -> 31 -- these are the months that have 31 days
               i | contains [4, 6, 9, 11] i -> 30 -- these are the months with 30
               2 | year `mod` 4 == 0 -> 29 -- February, leap year!
               2 -> 28 -- February, not leap year. If leap year, previous statement will match
               i -> error ("invalid month number: " ++ show i)
           )

    -- You can also match individual months if you'd like!
    -- case i of
    --   1 -> 31
    --   3 -> 31
    --   ...
    -- is totally valid and works :)

    lastDayOfYear :: Date -> Bool
    lastDayOfYear (Date 12 31 _) = True -- is it december 31st? We don't care about the year
    lastDayOfYear _ = False

-- >>> incrDate (Date 2 28 2020)
-- Date 2 29 2020

-- >>> incrDate (Date 12 31 2022)
-- Date 1 1 2023

-- 3) Recall the Paragraph data type from lecture,
--   which combines both sum types and product types
--   and was used to represent a toy model of a
--   subset of Markdown.

data Paragraph
  = Text String -- 3 constructors,
  | Heading Int String -- each with different
  | List Bool [String] -- parameters
  deriving (Show, Eq)

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
wordCount [] = 0  -- base case: no paragraphs, no word count
wordCount (p:ps) = paraWordCount p + wordCount ps  -- count words in head, then add count from rest of paragraph
  where
    listWordCount :: [String] -> Int
    listWordCount [] = 0
    listWordCount (s : strs) = length (words s) + listWordCount strs -- get all the words in s, recurse on the rest

    paraWordCount :: Paragraph -> Int
    -- just find the string in each data type and get the length of it.
    paraWordCount (Text s) = length (words s)
    paraWordCount (Heading _ s) = length (words s)
    paraWordCount (List _ strs) = listWordCount strs

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
 