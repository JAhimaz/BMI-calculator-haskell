module Utils.Misc where

import System.IO ( stdin, hSetBuffering, BufferMode(NoBuffering) )

anyKeyContinue :: IO ()
anyKeyContinue = do
    putStrLn "\nPress ENTER Key To Continue..."
    hSetBuffering stdin NoBuffering
    _ <- getChar
    putStrLn "\n"