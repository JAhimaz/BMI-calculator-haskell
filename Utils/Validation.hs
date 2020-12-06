module Utils.Validation where

-- Package Imports
import Data.Char (isDigit, isSpace, isAlpha)

-- Get Parameter function used for User Input Handling
getParameter :: [Char] -> (String -> Bool) -> IO String
getParameter label valid = loop -- Will Take in a Label to display and a boolean for error checking
  where
    loop = do
      putStrLn $ "Please enter " ++ label
      value <- getLine -- The Users Input
      if valid value -- If the input returns TRUE | FALSE do then following
        then pure value -- Returns the Value with no issue
        else do -- Prompts invalid value and restarts the loop
          putStrLn $ "\nInvalid Value\n"
          loop

-- validString checks if `x` is pure alpha characters and no spaces
validString :: Foldable t => t Char -> Bool
validString x = all isAlpha x && not (all isSpace x)

-- validNumber checks if provided is numbers only
validNumber :: Foldable t => t Char -> Bool
validNumber x = (all isDigit x) && not (all isSpace x)

-- validDouble checks if `x` is a double by using reads
validDouble :: String -> Bool
validDouble x = case reads x :: [(Double, String)] of
      [(_, "")] -> True
      _         -> False

-- validGender is a case check to see if any of the provided values match the given cases.
validGender :: [Char] -> Bool
validGender x
  | x == "M" || x == "m" = True
  | x == "F" || x == "f" = True
  | x == "O" || x == "o" = True
  | otherwise = False
