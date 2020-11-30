module Utils.Validation where

import Data.Char (isDigit, isSpace, isAlpha, isNumber)

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

-- validString :: [Char] -> Bool
-- validString x = not (null (dropWhile isSpace x))

validString :: Foldable t => t Char -> Bool
validString x = (all isAlpha x) && not (all isSpace x)

validNumber :: Foldable t => t Char -> Bool
validNumber x = all isNumber x

validGender x
  | x == "M" || x == "m" = True
  | x == "F" || x == "f" = True
  | x == "O" || x == "o" = True
  | otherwise = False