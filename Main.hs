module Main where
  
-- Package Imports
import Control.Concurrent ( threadDelay )
-- Module Imports
import Utils.MenuExtras
import DB.Datatypes ( BMIRecord )
import BMICalculator ( newBMIEntry )
import BMIRecordsRetrieval
    ( getAllEntries, getSpecificEntry, removeSpecificEntry )
-- Database Imports
import Database.SQLite.Simple ( close, execute_, open, query_ )

-- The main runs the setup program function
main :: IO ()
main = setupProgram

-- setupProgram first sets up the database then continues on to the main menu.
setupProgram :: IO ()
setupProgram = do
    setupDatabase
    mainMenuRecursion

{- setupDatabase creates the database and table `entries` if it doesn't exist already and prints the number of
current entries within the database -}
setupDatabase :: IO ()
setupDatabase = do
    conn <- open "bmiapp.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS entries (id INTEGER PRIMARY KEY, age INTEGER, fullName TEXT, gender TEXT, bmi DOUBLE, weight DOUBLE, height DOUBLE, time TEXT)"
    entries <- query_ conn "SELECT * FROM entries" :: IO [BMIRecord]
    let countEntries = length entries
    putStrLn ("\n\nLoaded " ++ show countEntries ++ " Entries\n\n")
    close conn

-- Main Menu Code Prompt
menu :: IO String
menu = do
    mainMenuPrompt
    getLine

-- Readings Menu
readingsMenu :: IO String
readingsMenu = do
    previousReadingsPrompt
    getLine

-- Menu Recursions
mainMenuRecursion :: IO ()
mainMenuRecursion =  do
    menu >>= menuSelection

readingsMenuRecursion :: IO ()
readingsMenuRecursion = do
    readingsMenu >>= readingsMenuSelection

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

-- Calculate BMI
calculateBMI :: IO ()
calculateBMI = do
    newBMIEntry
    mainMenuRecursion

-- Show all readings
showAllReadings = do
    getAllEntries
    readingsMenuRecursion

-- Invalid Choices for Menu
badChoice :: IO f -> [Char] -> IO f -- Badchoice takes in a function and a String [Char]
badChoice f x = do
    putStrLn ("\n" ++ x ++ " Is Not A Valid Choice") -- It will print the invalid choice
    f -- And go to a provided recursion function (AKA returning to the menu)

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}

