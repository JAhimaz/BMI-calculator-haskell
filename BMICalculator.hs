module BMICalculator where

import Data.Maybe
import Data.Time.Clock
import Data.Time.Calendar

-- DATA TYPE DECLARATIONS

data BMIRecord = BMIRecord Int String Float Float Float UTCTime
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

bmiCalc weight height = (weight / ((height/100)^2))

readBMIEntry (BMIRecord a n b w h d) = do

    let bmiType = bmi b

    putStrLn "╔════════════════════════════════════════════════════════════════════════════"
    putStrLn ("║ " ++ n ++ "'s BMI Profile")
    putStrLn ("║ Age: " ++ (show a))
    putStrLn "║ "                                                                         
    putStrLn ("║ Height: " ++ (show h) ++ "CM")                                                
    putStrLn ("║ Weight: " ++ (show w) ++ "KG")                                             
    putStrLn ("║ BMI Reading: " ++ (show b))                                                                 
    putStrLn ("║ BMI Type: " ++ (show bmiType))                                                                   
    putStrLn "║ "            
    putStrLn ("║ Time of Reading: " ++ (show d))                                                                        
    putStrLn "╚════════════════════════════════════════════════════════════════════════════\n\n\n"


{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}