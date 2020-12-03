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
import Database.SQLite.Simple.ToField


main :: IO ()
main = setupProgram

setupProgram = do
    setupDatabase
    mainMenuRecursion

setupDatabase = do
    conn <- open "bmiapp.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS entries (id INTEGER PRIMARY KEY, age INTEGER, fullName TEXT, gender TEXT, bmi DOUBLE, weight DOUBLE, height DOUBLE, time TEXT)"
    entries <- query_ conn "SELECT * FROM entries" :: IO [BMIRecord]
    let countEntries = length entries
    putStrLn ("\n\nLoaded " ++ (show countEntries) ++ " Entries\n\n")
    close conn

-- Main Menu Code Prompt
menu :: IO String
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                        >>> BMI Calculator App <<<                          ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI (New Reading)                                            ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║ [3] BMI Guide                                                              ║"
    putStrLn "║ [4] Application Info                                                       ║"
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
        "3" -> do
            displayBMIGuide
            mainMenuRecursion
        "4" -> do
            appInfo
            mainMenuRecursion
        "0" -> do
                putStrLn "Exiting Program..."
                threadDelay 2000000
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
    putStrLn "║ [3] Remove Specific Readings                                               ║"
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
        "2" -> do 
                getSpecificEntry
                readingsMenuRecursion
        "3" -> do 
                removeSpecificEntry
                readingsMenuRecursion
        "0" -> mainMenuRecursion
        other -> badChoice readingsMenuRecursion other

showAllReadings = do
    getAllEntries
    readingsMenuRecursion


-- Invalid Choices for Menu
badChoice :: IO f -> [Char] -> IO f -- Higher order function
badChoice f x = do
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

