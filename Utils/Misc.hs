module Utils.Misc where

import System.IO ( stdin, hSetBuffering, BufferMode(NoBuffering) )

-- Simple Enter to Continue Function for menu astethics
enterKeyContinue :: IO ()
enterKeyContinue = do
    putStrLn "\nPress ENTER Key To Continue..."
    hSetBuffering stdin NoBuffering
    _ <- getChar
    putStrLn "\n"

{- 
    ASCII Characters for Menu Creation
    
    ═ 	║ 	╒ 	╓ 	╔ 	╕ 	╖ 	╗ 	╘ 	╙ 	╚ 	╛ 	╜ 	╝ 	╞ 	╟	╠ 	╡ 	╢ 	╣ 	╤ 	╥ 	╦ 	╧ 	╨ 	╩ 	╪ 	╫ 	╬
-}