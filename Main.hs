{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}
module Main where
  
-- Package Imports
import Data.Maybe 
import Data.Char 
import Data.Time.Clock 
import Data.Time.Calendar 
import Control.Concurrent
-- Module Imports
import Utils.MenuExtras 
import Utils.Validation
import DB.Datatypes
import BMICalculator
import BMIRecordsRetrieval
-- Database Imports
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow


main :: IO ()
main = setupProgram

setupProgram = do
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

-- Main Menu Choices
menuSelection :: String -> IO ()
menuSelection choice =
    case choice of
        "1" -> calculateBMI
        "2" -> readingsMenuRecursion
        "0" -> exitMenu
        other -> badChoice mainMenuRecursion other

-- BMI Menu Code Prompt

calculateBMI :: IO ()
calculateBMI = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                       >>> Calculate BMI (METRIC) <<<                       ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝\n"
    clear
    firstName <- getParameter "your First Name: " validString
    clear
    lastName <- getParameter "your Last Name: " validString
    clear
    age <- getParameter "your Age: " validNumber
    clear
    gInput <- getParameter "your Gender ( M | F | O ): " validGender
    clear
    height <- getParameter "your Height (CM):" validNumber
    clear
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
    clear
    readBMIEntry thisBMIEntry
    putStrLn "Entry Recorded. Redirected to Menu in 5 Seconds..."
    threadDelay 5000000
    clear
    mainMenuRecursion

-- Menu Recursions
mainMenuRecursion :: IO ()
mainMenuRecursion =  do
    clear
    menu >>= menuSelection

readingsMenu :: IO String
readingsMenu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                     >>> View Previous Readings <<<                         ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] View All Readings                                                      ║"
    putStrLn "║ [2] View Specific Readings                                                 ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [0] Back                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║             ~~~ Please ENTER one of the following choices ~~~              ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine

readingsMenuRecursion :: IO ()
readingsMenuRecursion = do
    clear
    readingsMenu >>= readingsMenuSelection

readingsMenuSelection :: String -> IO ()
readingsMenuSelection choice =
    case choice of
        "1" -> showAllReadings
        "2" -> putStrLn "Choice 2"
        "0" -> mainMenuRecursion
        other -> badChoice readingsMenuRecursion other

showAllReadings = do
    clear
    getAllEntries
    readingsMenuRecursion

-- Invalid Choices for Menu
badChoice :: IO f -> [Char] -> IO f -- Higher order function
badChoice f x = do
    clear
    putStrLn ("\n" ++ x ++ " Is Not A Valid Choice")
    f


-- Setup Enter Key


{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}

