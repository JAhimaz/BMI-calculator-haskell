module Utils.MenuExtras where

import Control.Concurrent

-- Used to Exit the menu
exitMenu :: IO ()
exitMenu = do
    putStrLn "Exiting Program..."
    threadDelay 2000000
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
    threadDelay 2000000

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}