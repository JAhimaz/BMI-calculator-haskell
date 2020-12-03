module DB.Datatypes where
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField

data BMIEntry = BMIEntry Int String String Double Double Double String deriving (Show)

instance ToRow BMIEntry where
  toRow (BMIEntry age name gender bmi weight height time) = toRow (age, name, gender, bmi, weight, height, time)

data BMIRecord = BMIRecord Int Int String String Double Double Double String

instance FromRow BMIRecord where
    fromRow = BMIRecord <$> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field
-- BMIRecord Age Name Gender BMI Weight Height 

bmi :: (Ord a, Fractional a) => a -> BMI
bmi n
  | n <= 16.5 = SeverelyUnderweight
  | n <= 18.5 = Underweight
  | n <= 25.0 = Normal
  | n <= 30.1 = Overweight
  | n <= 35.0 = Obese1
  | n <= 40.0 = Obese2
  | otherwise = Obese3

data BMI = SeverelyUnderweight
         | Underweight
         | Normal
         | Overweight
         | Obese1
         | Obese2
         | Obese3

instance Show BMI where
  show SeverelyUnderweight = "Severely underweight"
  show Underweight         = "Underweight"
  show Normal              = "Normal"
  show Overweight          = "Overweight"
  show Obese1              = "Obese (Class I)"
  show Obese2              = "Obese (Class II)"
  show Obese3              = "Obese (Class III)"

_gender :: [Char] -> [Char]
_gender n
  | n == "M" = "Male"
  | n == "F" = "Female"
  | n == "O" = "Others"
  | otherwise = "Invalid Gender"


-- Database initialise command (For Testing)
-- sqlite3 bmiapp.db "CREATE TABLE entries (id INTEGER PRIMARY KEY, age INTEGER, fullName TEXT, gender TEXT, bmi DOUBLE, weight DOUBLE, height DOUBLE, time TEXT);" 