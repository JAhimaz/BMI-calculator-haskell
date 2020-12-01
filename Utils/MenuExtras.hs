module Utils.MenuExtras where

import Control.Concurrent

-- Clears the console for visual clarity
clear :: IO ()
clear = putStr "\ESC[2J"

-- Used to Exit the menu
exitMenu :: IO ()
exitMenu = do
    clear
    putStrLn "Exiting Program..."
    threadDelay 2000000
    clear
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

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}