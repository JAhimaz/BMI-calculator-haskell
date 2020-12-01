{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Cabal (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,2,1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\bin"
libdir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\lib"
dynlibdir  = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\lib"
datadir    = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\share"
libexecdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\libexec"
sysconfdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\Cabal-3.2.1.0-ca98e881210f7eb61bf157b512c452873c834473\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Cabal_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Cabal_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Cabal_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Cabal_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Cabal_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Cabal_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
