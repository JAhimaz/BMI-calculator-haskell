module Utils.Misc where

-- Simple Enter to Continue Function for menu astethics
enterKeyContinue :: IO ()
enterKeyContinue = do
    putStrLn "\nPress ENTER Key To Continue..."
    _ <- getLine
    putStrLn "\n"


{- 
    ASCII Characters for Menu Creation
    
    ═ 	║ 	╒ 	╓ 	╔ 	╕ 	╖ 	╗ 	╘ 	╙ 	╚ 	╛ 	╜ 	╝ 	╞ 	╟	╠ 	╡ 	╢ 	╣ 	╤ 	╥ 	╦ 	╧ 	╨ 	╩ 	╪ 	╫ 	╬
-}