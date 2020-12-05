module Utils.MenuExtras where

-- Module Imports
import Utils.Misc ( anyKeyContinue )

{-

    MenuExtras.hs just contains printables for Display.

-}

-- Used to Exit the menu
appInfo :: IO ()
appInfo = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                            ║"
    putStrLn "║                  ~~ THANKS FOR USING THE BMI CALCULATOR ~~                 ║"
    putStrLn "║                      Created by Joshua Daveston Ahimaz                     ║"
    putStrLn "║                                  16102543                                  ║"
    putStrLn "║                                                                            ║"
    putStrLn "║                      Functional Programming Principles                     ║"
    putStrLn "║                         PRG2214 | Sunway University                        ║"
    putStrLn "║                                                                            ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    anyKeyContinue

displayBMIGuide :: IO ()
displayBMIGuide = do
    putStrLn "╔═════════════════════════════════════════════════════╗"
    putStrLn "║                  BMI RANGES & TYPES                 ║"
    putStrLn "╠═════════════════════════════════════════════════════╣"
    putStrLn "║                                                     ║"
    putStrLn "║           < 16.5 - Severely Underweight             ║"
    putStrLn "║      16.5 – 18.5 - Underweight                      ║"
    putStrLn "║      18.5 - 24.9 - Normal                           ║"
    putStrLn "║      25.0 - 29.9 - Overweight                       ║"
    putStrLn "║      30.0 - 34.9 - Obese (Class I)                  ║"
    putStrLn "║      35.0 - 39.9 - Obese (Class II)                 ║"
    putStrLn "║           > 40.0 - Obese (Class III)                ║"
    putStrLn "║                                                     ║"
    putStrLn "╚═════════════════════════════════════════════════════╝"
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