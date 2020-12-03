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

readBMIEntryMin :: BMIRecord -> IO ()
readBMIEntryMin (BMIRecord id a n g b _ _ d) = do
  let bmiType = bmi b
  let gender = _gender g
  putStrLn ("║ " ++ "ID: " ++ (show id) ++ " | Name: " ++ n ++ " | Age: " ++ (show a) ++ " | Gender: " ++ gender ++ "\n║ BMI: " ++ (show b) ++ " | BMI Type: " ++ (show bmiType) ++ " | Date Taken: " ++ (show d))

newBMIEntry = do
  putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
  putStrLn "║                       >>> Calculate BMI (METRIC) <<<                       ║"
  putStrLn "╚════════════════════════════════════════════════════════════════════════════╝\n"
  firstName <- getParameter "your First Name: " validString
  lastName <- getParameter "your Last Name: " validString
  age <- getParameter "your Age: " validNumber
  gInput <- getParameter "your Gender ( M | F | O ): " validGender
  height <- getParameter "your Height (CM):" validDouble
  weight <- getParameter "your Weight (KG):" validDouble
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

  let thisBMIEntry = BMIRecord (fromOnly (head id)) (read age) fullName gender bmiValue (read weight) (read height) (show date)

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