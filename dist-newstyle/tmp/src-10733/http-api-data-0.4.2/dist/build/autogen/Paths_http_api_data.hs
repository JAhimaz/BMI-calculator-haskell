{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_http_api_data (
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
version = Version [0,4,2] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\bin"
libdir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\lib"
dynlibdir  = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\lib"
datadir    = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\share"
libexecdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\libexec"
sysconfdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\http-api-data-0.4.2-7e68740350ed9327b10445fb4ac1b69ed4fd3834\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "http_api_data_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "http_api_data_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "http_api_data_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "http_api_data_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "http_api_data_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "http_api_data_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
