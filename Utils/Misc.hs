module Utils.Misc where

import System.IO

anyKeyContinue :: IO ()
anyKeyContinue = do
    putStrLn "\nPress ENTER Key To Continue..."
    hSetBuffering stdin NoBuffering
    _ <- getChar
    putStrLn "\n"