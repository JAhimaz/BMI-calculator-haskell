module Utils.Validation where

import Data.Char (isDigit)

getParameter label valid = loop
  where
    loop = do
      putStrLn $ "Please enter " ++ label
      value <- getLine
      if valid value
        then pure value
        else do
          putStrLn $ "\nInvalid Value\n"
          loop

validNumber x = do
    isNumber x

isNumber :: String -> Bool
isNumber ""  = False
isNumber "." = False
isNumber xs  =
  case dropWhile isDigit xs of
    ""       -> True
    ('.':ys) -> all isDigit ys
    _        -> False
