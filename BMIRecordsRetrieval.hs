module BMIRecordsRetrieval where

-- Module Imports
import Utils.Validation ( getParameter, validNumber )
import Utils.Misc ( enterKeyContinue )
import DB.Datatypes ( _gender, bmi, BMIRecord(..) )
-- Database Imports
import Database.SQLite.Simple
    ( close, execute, open, query, query_, Only(Only) )


getAllEntries :: IO ()
getAllEntries = do
    conn <- open "bmiapp.db"
    entries <- query_ conn "SELECT * FROM entries" :: IO [BMIRecord]
    close conn
    putStrLn "                                  ╔═ All Previous Readings ═╗"
    putStrLn "╔══════════════════════════════════════════════════════════════════════════════════════════════╗"
    mapM_ readBMIEntryMin entries
    putStrLn "╚══════════════════════════════════════════════════════════════════════════════════════════════╝\n"
    enterKeyContinue

getSpecificEntry :: IO ()
getSpecificEntry = do
    conn <- open "bmiapp.db"
    search <- getParameter "a Entry ID (Can Be Found By Viewing All): " validNumber
    let param = read search
    entries <- query conn "SELECT * FROM entries WHERE id = ?" (Only (param :: Int)) :: IO [BMIRecord]
    if (length entries) > 0
        then readBMIEntry (head entries)
    else putStrLn ("No Entries Found With ID " ++ search)
    close conn
    enterKeyContinue

readBMIEntry :: BMIRecord -> IO ()
readBMIEntry (BMIRecord id a n g b w h d) = do
  let bmiType = bmi b
  let gender = _gender g

  putStrLn "╔════════════════════════════════════════════════════════════════════════════"
  putStrLn ("║ " ++ "ID: " ++ show id)
  putStrLn ("║ " ++ n ++ "'s BMI Profile")
  putStrLn ("║ Age: " ++ show a)
  putStrLn ("║ Gender: " ++ gender)
  putStrLn "║ "                                                                         
  putStrLn ("║ Height: " ++ show h ++ "CM")                                                
  putStrLn ("║ Weight: " ++ show w ++ "KG")                                             
  putStrLn ("║ BMI Reading: " ++ show b)                                                                 
  putStrLn ("║ BMI Type: " ++ show bmiType)                                                                   
  putStrLn "║ "            
  putStrLn ("║ Time of Reading: " ++ show d)                                                                        
  putStrLn "╚════════════════════════════════════════════════════════════════════════════\n\n\n"

readBMIEntryMin :: BMIRecord -> IO ()
readBMIEntryMin (BMIRecord id a n g b _ _ d) = do
  let bmiType = bmi b
  let gender = _gender g
  putStrLn ("║ " ++ "ID: " ++ show id ++ " | Name: " ++ n ++ " | Age: " ++ show a ++ " | Gender: " ++ gender ++ "\n║ BMI: " ++ show b ++ " | BMI Type: " ++ show bmiType ++ " | Date Taken: " ++ (show d))

removeSpecificEntry :: IO ()
removeSpecificEntry = do
    conn <- open "bmiapp.db"
    search <- getParameter "a Entry ID To Delete (Can Be Found By Viewing All): " validNumber
    let param = read search
    entries <- query conn "SELECT * FROM entries WHERE id = ?" (Only (param :: Int)) :: IO [BMIRecord]
    if (length entries) > 0
        then do
            execute conn "DELETE FROM entries WHERE id = ?" (Only (param :: Int))
            putStrLn ("\nDeleted The Following Entry: ")
            mapM_ readBMIEntryMin entries
    else putStrLn ("No Entries Found With ID " ++ search)
    close conn
    enterKeyContinue
