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
-- Package Imports
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField


main :: IO ()
main = setupProgram

setupProgram = do
    setupDatabase
    mainMenuRecursion

setupDatabase = do
    conn <- open "bmiapp.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS entries (id INTEGER PRIMARY KEY, age INTEGER, fullName TEXT, gender TEXT, bmi DOUBLE, weight DOUBLE, height DOUBLE, time TEXT)"
    close conn

-- Main Menu Code Prompt
menu :: IO String
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                        >>> BMI Calculator App <<<                          ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI (New Reading)                                            ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║ [3] View Statistics of Readings                                            ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [0] Exit                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║             ~~~ Please ENTER one of the following choices ~~~              ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine

-- Menu Recursions
mainMenuRecursion :: IO ()
mainMenuRecursion =  do
    menu >>= menuSelection

-- Main Menu Choices
menuSelection :: String -> IO ()
menuSelection choice =
    case choice of
        "1" -> calculateBMI
        "2" -> readingsMenuRecursion
        "3" -> putStrLn "Statistics"
        "0" -> exitMenu
        other -> badChoice mainMenuRecursion other

-- BMI Menu Code Prompt

calculateBMI :: IO ()
calculateBMI = do
    newBMIEntry
    mainMenuRecursion


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
    readingsMenu >>= readingsMenuSelection

readingsMenuSelection :: String -> IO ()
readingsMenuSelection choice =
    case choice of
        "1" -> showAllReadings
        "2" -> specificReadingMenuRecursion
        "0" -> mainMenuRecursion
        other -> badChoice readingsMenuRecursion other

showAllReadings = do
    getAllEntries
    readingsMenuRecursion

showSpecificReading = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                      >>> View Specific Entries <<<                         ║"
    putStrLn "║                                                                            ║"
    putStrLn "║  What Would You Like To Search By?                                         ║"
    putStrLn "║                                                                            ║"
    putStrLn "║  1) ID                                                                     ║"
    putStrLn "║  2) Full Name                                                              ║"
    putStrLn "║                                                                            ║"
    putStrLn "║  0) Back                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝\n"
    getLine

specificReadingMenuRecursion :: IO ()
specificReadingMenuRecursion = do
    showSpecificReading >>= specificReadingMenuSelection


specificReadingMenuSelection choice =
    case choice of
        "1" -> do
            getSpecifiEntry "id"
            specificReadingMenuRecursion
        "2" -> do
            getSpecifiEntry "fullName"
            specificReadingMenuRecursion
        "0" -> readingsMenuRecursion
        other -> badChoice specificReadingMenuRecursion other


-- Invalid Choices for Menu
badChoice :: IO f -> [Char] -> IO f -- Higher order function
badChoice f x = do
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

