module Main where

import MenuExtras
import Validation
import Data.Maybe
import BMICalculator

main :: IO ()
main = mainMenuRecursion

-- DATA TYPE DECLARATIONS

data BMIRecord = BMIRecord Int String Float Float Float
-- BMIRecord Age Name BMI Weight Height 

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

bmi n
  | n <= 16.5 = SeverelyUnderweight
  | n <= 18.5 = Underweight
  | n <= 25.0 = Normal
  | n <= 30.1 = Overweight
  | n <= 35.0 = Obese1
  | n <= 40.0 = Obese2
  | otherwise = Obese3
--

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
    height <- getParameter "your Height (CM):" validNumber
    clear
    weight <- getParameter "your Weight (KG):" validNumber
    clear
    putStrLn "Please enter your Name:"
    name <- getLine
    clear
    age <- getParameter "your Age: " validNumber
    let bmiValue = bmiCalc (read weight) (read height)
    let bmiType = bmi bmiValue
    -- let thisBMIProfile = BMIRecord age name weight height
    -- BMIRecord Age Name BMI Weight Height 

    -- Profile Print
    clear
    putStrLn "╔════════════════════════════════════════════════════════════════════════════"
    putStrLn ("║ " ++ name ++ "'s BMI Profile")
    putStrLn ("║ Age: " ++ age)   
    putStrLn "║ "                                                                         
    putStrLn ("║ Height: " ++ height ++ "CM")                                                
    putStrLn ("║ Weight: " ++ weight ++ "KG")                                             
    putStrLn ("║ BMI Reading: " ++ (show bmiValue))                                                                 
    putStrLn ("║ BMI Type: " ++ (show bmiType))                                                                   
    putStrLn "║ "                                                                                  
    putStrLn "╚════════════════════════════════════════════════════════════════════════════"




-- End of BMI Menu Code Prompt


-- Menu Recursions
mainMenuRecursion :: IO ()
mainMenuRecursion =  menu >>= menuSelection


-- End of Menu Recursions

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

