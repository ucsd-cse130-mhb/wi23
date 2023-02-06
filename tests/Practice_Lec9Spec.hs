module Practice_Lec9Spec where

import Data.Foldable (foldl')
import Practice_Lec9
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Lecture 9: Datatypes in Haskell" $ do
  describe "dateFormat" $ do
    specify "dateFormat (Date 12 12 2022) == \"December 12, 2022\"" $ do
      dateFormat (Date 12 12 2022) `shouldBe` "December 12, 2022"

  describe "timeFormat" $ do
    specify "timeFormat (Time 6 30 00) == \"06:30:00\"" $ do
      timeFormat (Time 6 30 00) `shouldBe` "06:30:00"

  describe "incrDate" $ do
    specify "incrDate (Date 2 28 2020) == (Date 2 29 2020)" $ do
      incrDate (Date 2 28 2020) `shouldBe` Date 2 29 2020

    specify "incrDate (Date 12 31 2022) == Date 1 1 2023" $ do
      incrDate (Date 12 31 2022) `shouldBe` Date 1 1 2023

  describe "wordCount" $ do
    -- can't do the listWordCount and paraWordCount tests here, because
    -- they are in a where statement and can't be imported here.

    specify "wordCount [Heading 2 \"Chapter One\", Text \"These are nearby beaches\", List False [\"Ocean Beach\", \"Pacific Beach\", \"Cardiff State Beach\", \"San Elijo State Beach\"] ]" $ do
      wordCount
        [ Heading 2 "Chapter One",
          Text "These are nearby beaches",
          List
            False
            [ "Ocean Beach",
              "Pacific Beach",
              "Cardiff State Beach",
              "San Elijo State Beach"
            ]
        ]
        `shouldBe` 17

    it "can determine the wordcount of any arbitrary paragraph" $
      withMaxSuccess 50 $
        property $
          \(ParagraphCounts p count) -> wordCount p == count

-- Problem 9 Utils
data ParagraphCounts = ParagraphCounts [Paragraph] Int deriving (Show, Eq)

instance Arbitrary ParagraphCounts where
  arbitrary = sized $ \n -> do
    len <- arbitrary `suchThat` (<= n)
    paraLen <-
      vectorOf len $
        frequency
          [ ( 4,
              do
                words <- listOf (listOf1 (elements ['a' .. 'z']))
                frequency [(3, return (Text (unwords words), length words)), (1, (\h -> (Heading h (unwords words), length words)) <$> choose (1, 6))]
            ),
            ( 1,
              do
                words <- listOf (listOf (listOf1 (elements ['a' .. 'z'])))
                let len = foldl' (\acc words -> acc + length words) 0 words
                (\b -> (List b (map unwords words), len)) <$> arbitrary
            )
          ]
    let (paras, len) = foldl' (\(paras, totallen) (para, len) -> (para : paras, totallen + len)) ([], 0) paraLen
    return $ ParagraphCounts paras len
