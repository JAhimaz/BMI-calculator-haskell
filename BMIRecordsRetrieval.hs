module BMIRecordsRetrieval where

-- Module Imports
import BMICalculator
import Utils.Validation
import Utils.Misc
import DB.Datatypes
-- Package Imports
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField


getAllEntries = do
    conn <- open "bmiapp.db"
    entries <- query_ conn "SELECT * FROM entries" :: IO [BMIRecord]
    close conn
    putStrLn "                                  ╔═ All Previous Readings ═╗"
    putStrLn "╔══════════════════════════════════════════════════════════════════════════════════════════════╗"
    mapM_ readBMIEntryMin entries
    putStrLn "╚══════════════════════════════════════════════════════════════════════════════════════════════╝\n"
    anyKeyContinue

getSpecificEntry = do
    conn <- open "bmiapp.db"
    search <- getParameter "a Entry ID (Can Be Found By Viewing All): " validNumber
    let param = read search
    entries <- query conn "SELECT * FROM entries WHERE id = ?" (Only (param :: Int)) :: IO [BMIRecord]
    if (length entries) == 0
        then putStrLn ("No Entries Found With ID " ++ search)
    else readBMIEntry (head entries)
    close conn
    anyKeyContinue