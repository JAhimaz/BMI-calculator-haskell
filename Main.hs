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
import BMICalculator
-- Database Imports
{-# LANGUAGE GADTs, TypeFamilies, TemplateHaskell, QuasiQuotes, FlexibleInstances, StandaloneDeriving #-}
import Control.Monad.IO.Class (liftIO)
import Database.Groundhog.TH
import Database.Groundhog.Sqlite


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
        "2" -> putStrLn "Choice 2"
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
    let thisBMIEntry = BMIRecord (read age) fullName gender bmiValue (read weight) (read height) date
    -- BMIRecord Age Name BMI Weight Height 

    -- Profile Print
    clear
    readBMIEntry thisBMIEntry

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

