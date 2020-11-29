module Main where
  
{-# LANGUAGE OverloadedStrings #-}

-- Package Imports
import Data.Maybe
import Data.Time.Clock
import Data.Time.Calendar
-- Module Imports
import Utils.MenuExtras
import Utils.Validation
import BMICalculator
-- Database Imports
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Control.Concurrent

main :: IO ()
main = setupProgram

-- data TestField = TestField Int String deriving (Show)

-- instance FromRow TestField where
--   fromRow = TestField <$> field <*> field

setupProgram = do
  -- conn <- open "test.db"
  -- execute conn "INSERT INTO test (str) VALUES (?)"
  --   (Only ("test string 2" :: String))
  -- r <- query_ conn "SELECT * from test" :: IO [TestField]
  -- mapM_ print r
  -- close conn
  mainMenuRecursion

-- Main Menu Code Prompt
menu :: IO String
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                        >>> BMI Calculator App <<<                          ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI                                                          ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [0] Exit                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║             ~~~ Please ENTER one of the following choices ~~~              ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine

menuSelection :: String -> IO ()
menuSelection choice =
    case choice of
        "1" -> calculateBMI
        "2" -> putStrLn "Choice 2"
        "0" -> exitMenu
        other -> badChoice mainMenuRecursion other

-- BMI Menu Code Prompt

-- calculateBMI :: IO String
calculateBMI = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                       >>> Calculate BMI (METRIC) <<<                       ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝\n"
    clear
    putStrLn "Please enter your Name:"
    name <- getLine
    clear
    age <- getParameter "your Age: " validNumber
    clear
    height <- getParameter "your Height (CM):" validNumber
    clear
    weight <- getParameter "your Weight (KG):" validNumber
    -- None Input
    date <- getCurrentTime 
    --
    let bmiValue = bmiCalc (read weight) (read height)
    let thisBMIEntry = BMIRecord (read age) name bmiValue (read weight) (read height) date
  
    -- BMIRecord Age Name BMI Weight Height 

    -- Profile Print
    clear
    readBMIEntry thisBMIEntry

-- End of BMI Menu Code Prompt


-- Menu Recursions
mainMenuRecursion :: IO ()
mainMenuRecursion =  menu >>= menuSelection


-- Invalid Choices for Menu

badChoice :: IO f -> [Char] -> IO f -- Higher order function
badChoice f x = do
    clear
    putStrLn ("\n" ++ x ++ " Is Not A Valid Choice")
    f

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}

