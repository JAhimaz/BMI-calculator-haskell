module Main where

import Lib

main :: IO ()
main = someFunc

-- Menu Code Prompt
menu = do
    putStrLn "╔════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                       >>> BMI Calculator App <<<                           ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [1] Calculate BMI                                                          ║"
    putStrLn "║ [2] View Previous Readings                                                 ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ [3] Exit                                                                   ║"
    putStrLn "║                                                                            ║"
    putStrLn "║ Please select one of the following choices ~~~                             ║"
    putStrLn "╚════════════════════════════════════════════════════════════════════════════╝"
    getLine

-- doMenuRecursion = menu