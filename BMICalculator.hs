module BMICalculator where

-- Module Imports
import Utils.Validation
    ( getParameter,
      validString,
      validNumber,
      validGender,
      validDouble )
import Utils.Misc ( anyKeyContinue )
import DB.Datatypes ( BMIEntry(BMIEntry), BMIRecord(BMIRecord) )
import BMIRecordsRetrieval ( readBMIEntry )
-- Package Imports
import Data.Char ( toUpper ) 
import Data.Time.Clock ( getCurrentTime ) 
-- Database Imports
import Database.SQLite.Simple
    ( close, execute, open, query, Only(..) )

-- DATA TYPE DECLARATIONS

round1dp :: Double -> Double
round1dp x = fromIntegral (round $ x * 1e2) / 1e2

bmiCalc :: Fractional a => a -> a -> a
bmiCalc weight height = weight / ((height/100)^2)

newBMIEntry :: IO ()
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
  entry <- query conn "SELECT * FROM entries WHERE time = ?" (Only (show date :: String)) :: IO [BMIRecord]
  close conn

  let thisBMIEntry = head entry

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