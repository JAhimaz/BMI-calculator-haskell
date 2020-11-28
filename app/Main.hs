module Main where

import Lib
import Utils.IOValidation

main :: IO ()
main = menuRecursion

-- Menu Code Prompt
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                        >>> BMI Calculator App <<<                          ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI                                                          ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [3] Exit                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ Please select one of the following choices ~~~                             ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine

-- Choices for Menu
menuSelection :: String -> IO ()
menuSelection "1" = putStrLn "Choice 1"
menuSelection "2" = test
menuSelection "3" = exitMenu


-- Recursive menu
menuRecursion :: IO ()
menuRecursion = menu >>= menuSelection

-- Exit Menu
exitMenu :: IO ()
exitMenu = putStrLn "See ya!"


