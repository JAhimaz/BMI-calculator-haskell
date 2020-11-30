module DB.Datatypes where

{-# LANGUAGE GADTs, TypeFamilies, TemplateHaskell, QuasiQuotes, FlexibleInstances, StandaloneDeriving #-}
import Control.Monad.IO.Class (liftIO)
import Database.Groundhog.TH ()
import Database.Groundhog.Sqlite ()

data BMIEntry = BMIEntry { age :: Int, fullName :: String, gender :: String, bmi :: Double, weight :: Double, height :: Double, timeTaken :: String } deriving Show

-- data BMIRecord = BMIRecord Int String String Double Double Double UTCTime
-- BMIRecord Age Name Gender BMI Weight Height 