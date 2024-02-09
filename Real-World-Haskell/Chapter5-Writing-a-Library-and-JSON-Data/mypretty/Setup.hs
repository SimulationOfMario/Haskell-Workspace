#!/usr/bin/env runhaskell
import Distribution.Simple

main :: IO ()
main = defaultMain

-- ? This file allows Cabal's build process to be heavily customized (if a package needs it)
-- ? This file is the simplest setup