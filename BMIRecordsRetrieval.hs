{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE KindSignatures #-}

module BMIRecordsRetrieval where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField

import BMICalculator
import DB.Datatypes


getAllEntries = do
    conn <- open "bmiapp.db"
    entries <- query_ conn "SELECT age, fullName, gender, bmi, weight, height, time from entries" :: IO [BMIEntry]
    entriesID <- query_ conn "SELECT id from entries" :: IO [Only Int]
    let entriesWID = zip (map fromOnly entriesID) entries
    close conn
    putStrLn "                                  ╔═ All Previous Readings ═╗"
    putStrLn "══════════════════════════════════════════════════════════════════════════════════════════════╗"
    mapM_ print entriesWID
    putStrLn "══════════════════════════════════════════════════════════════════════════════════════════════╝\n"