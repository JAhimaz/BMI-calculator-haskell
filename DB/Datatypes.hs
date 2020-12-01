{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE KindSignatures #-}

module DB.Datatypes where
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField


data BMIEntry = BMIEntry Int String String Double Double Double String deriving (Show)
data BMIId = BMIId Int deriving (Show)

instance FromRow BMIEntry where
    fromRow = BMIEntry <$> field <*> field <*> field <*> field <*> field <*> field <*> field

instance FromRow BMIId where
    fromRow = BMIId <$> field

instance ToRow BMIEntry where
  toRow (BMIEntry age name gender bmi weight height time) = toRow (age, name, gender, bmi, weight, height, time)



-- Database initialise command (For Testing)
-- sqlite3 bmiapp.db "CREATE TABLE entries (id INTEGER PRIMARY KEY, age INTEGER, fullName TEXT, gender TEXT, bmi DOUBLE, weight DOUBLE, height DOUBLE, time TEXT);" 