module Utils.IOValidation where

isMember n [] = False
isMember n (x:xs)
    | n == x = True
    | otherwise = isMember n xs

clear = putStr "\ESC[2J"


{-

    Input/Output Validation Utility

    Created by Joshua Daveston Ahimaz
    16102543
    
    for the purpose of ---
    
    Functional Programming Principles - PRG2214
    Final Project

-}