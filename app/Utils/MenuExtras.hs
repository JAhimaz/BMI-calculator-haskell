module Utils.MenuExtras where

-- Clears the console for visual clarity
clear = putStr "\ESC[2J"

-- Used to Exit the menu
exitMenu :: IO ()
exitMenu = do
    clear
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                            ║"
    putStrLn "║                     ~~ THANKS FOR USING THE PROGRAM ~~                     ║"
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