{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}

module BMICalculator where

-- Module Imports
import Utils.MenuExtras 
import Utils.Validation
import Utils.Misc
import DB.Datatypes
-- Package Imports
import Data.Maybe 
import Data.Char 
import Data.Time.Clock 
import Data.Time.Calendar 
import Control.Concurrent
-- Database Imports
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

-- DATA TYPE DECLARATIONS

data BMIRecord = BMIRecord Int Int String String Double Double Double UTCTime
-- BMIRecord Age Name Gender BMI Weight Height 

bmi :: (Ord a, Fractional a) => a -> BMI
bmi n
  | n <= 16.5 = SeverelyUnderweight
  | n <= 18.5 = Underweight
  | n <= 25.0 = Normal
  | n <= 30.1 = Overweight
  | n <= 35.0 = Obese1
  | n <= 40.0 = Obese2
  | otherwise = Obese3

data BMI = SeverelyUnderweight
         | Underweight
         | Normal
         | Overweight
         | Obese1
         | Obese2
         | Obese3

instance Show BMI where
  show SeverelyUnderweight = "Severely underweight"
  show Underweight         = "Underweight"
  show Normal              = "Normal"
  show Overweight          = "Overweight"
  show Obese1              = "Obese (Class I)"
  show Obese2              = "Obese (Class II)"
  show Obese3              = "Obese (Class III)"

_gender :: [Char] -> [Char]
_gender n
  | n == "M" = "Male"
  | n == "F" = "Female"
  | n == "O" = "Others"
  | otherwise = "Invalid Gender"

round1dp :: Double -> Double
round1dp x = fromIntegral (round $ x * 1e2) / 1e2

bmiCalc :: Fractional a => a -> a -> a
bmiCalc weight height = (weight / ((height/100)^2))

readBMIEntry :: BMIRecord -> IO ()
readBMIEntry (BMIRecord id a n g b w h d) = do
  let bmiType = bmi b
  let gender = _gender g

  putStrLn "╔════════════════════════════════════════════════════════════════════════════"
  putStrLn ("║ " ++ "ID: " ++ (show id))
  putStrLn ("║ " ++ n ++ "'s BMI Profile")
  putStrLn ("║ Age: " ++ (show a))
  putStrLn ("║ Gender: " ++ gender)
  putStrLn "║ "                                                                         
  putStrLn ("║ Height: " ++ (show h) ++ "CM")                                                
  putStrLn ("║ Weight: " ++ (show w) ++ "KG")                                             
  putStrLn ("║ BMI Reading: " ++ (show b))                                                                 
  putStrLn ("║ BMI Type: " ++ (show bmiType))                                                                   
  putStrLn "║ "            
  putStrLn ("║ Time of Reading: " ++ (show d))                                                                        
  putStrLn "╚════════════════════════════════════════════════════════════════════════════\n\n\n"

newBMIEntry = do
  putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
  putStrLn "║                       >>> Calculate BMI (METRIC) <<<                       ║"
  putStrLn "╚════════════════════════════════════════════════════════════════════════════╝\n"
  firstName <- getParameter "your First Name: " validString
  lastName <- getParameter "your Last Name: " validString
  age <- getParameter "your Age: " validNumber
  gInput <- getParameter "your Gender ( M | F | O ): " validGender
  height <- getParameter "your Height (CM):" validNumber
  weight <- getParameter "your Weight (KG):" validNumber
  -- None Input
  date <- getCurrentTime 
  let fullName = firstName ++ " " ++ lastName
  let gender = map toUpper gInput
  --
  let bmiValue = round1dp (bmiCalc (read weight) (read height))

  conn <- open "bmiapp.db"
  execute conn "INSERT INTO entries (age, fullName, gender, bmi, weight, height, time) VALUES (?, ?, ?, ?, ?, ?, ?)" (BMIEntry (read age) fullName gender bmiValue (read weight) (read height) (show date))
  id <- query conn "SELECT id from entries WHERE time = ?" (Only (show date :: String)) :: IO [Only Int]
  close conn

  let thisBMIEntry = BMIRecord (fromOnly (head id)) (read age) fullName gender bmiValue (read weight) (read height) date

  -- Profile Print
  readBMIEntry thisBMIEntry
  anyKeyContinue

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}