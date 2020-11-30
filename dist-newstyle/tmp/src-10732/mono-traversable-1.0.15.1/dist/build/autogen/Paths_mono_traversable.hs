{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_mono_traversable (
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
version = Version [1,0,15,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\bin"
libdir     = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\lib"
dynlibdir  = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\lib"
datadir    = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\share"
libexecdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\libexec"
sysconfdir = "C:\\Users\\User\\AppData\\Roaming\\cabal\\store\\ghc-8.10.2\\mono-traversa_-1.0.15.1-d4a1ea46354015ecadbf7f69a5d49c1a719525f7\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "mono_traversable_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "mono_traversable_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "mono_traversable_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "mono_traversable_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mono_traversable_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mono_traversable_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
