module Utils.Misc where

import System.IO

anyKeyContinue = do
    hSetBuffering stdin NoBuffering
    x <- getChar
    putStrLn "\n"