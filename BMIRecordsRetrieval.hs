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
    entries <- query_ conn "SELECT age, fullName, gender, bmi, weight, height, time FROM entries" :: IO [BMIEntry]
    entriesID <- query_ conn "SELECT id from entries" :: IO [Only Int]
    let entriesWID = zip (map fromOnly entriesID) entries
    close conn
    putStrLn "                                  ╔═ All Previous Readings ═╗"
    putStrLn "                       (ID, AGE, NAME, GENDER, BMI, WEIGHT, HEIGHT, DATE)"
    putStrLn "══════════════════════════════════════════════════════════════════════════════════════════════╗"
    mapM_ print entriesWID
    putStrLn "══════════════════════════════════════════════════════════════════════════════════════════════╝\n"
    anyKeyContinue

getSpecifiEntry col = do
    conn <- open "bmiapp.db"
    if col == "fullName"
        then do
            search <- getParameter "a Entry's Name (Partial or Full): " validStringSearch
            let param = show search
            entries <- query conn "SELECT age, fullName, gender, bmi, weight, height, time FROM entries WHERE fullName LIKE ?" (Only (param :: String)) :: IO [BMIEntry]
            mapM_ print entries           
    else do
        search <- getParameter "a Entry ID: " validNumber
        let param = read search
        entries <- query conn "SELECT * FROM entries WHERE id = ?" (Only (param :: Int)) :: IO [BMIRecord]
        if (length entries) == 0
            then putStrLn ("No Entries Found With ID " ++ search)
        else readBMIEntry (head entries)
    close conn
    anyKeyContinue