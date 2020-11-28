module Main where

import Lib
import Utils.MenuExtras
import Data.Maybe


main :: IO ()
main = menuRecursion

-- Menu Code Prompt
menu :: IO String
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                        >>> BMI Calculator App <<<                          ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI                                                          ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [3] Exit                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║             ~~~ Please select one of the following choices ~~~             ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine


menuSelection :: String -> IO ()
menuSelection choice =
    case choice of
        "1" -> putStrLn "Choice 1"
        "2" -> putStrLn "Choice 2"
        "3" -> exitMenu
        other -> badChoice other

-- Recursive menu
menuRecursion :: IO ()
menuRecursion =  menu >>= menuSelection

badChoice :: String -> IO ()
badChoice x = do
    clear
    putStrLn ("\n" ++ x ++ " Is Not A Valid Choice")
    menuRecursion

{-

    BMI CALCULATOR APP HASKELL ASSIGNMENT

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---

    https://github.com/JAhimaz/BMI-calculator-haskell
    
    Functional Programming Principles - PRG2214
    Final Project - 50%

-}

