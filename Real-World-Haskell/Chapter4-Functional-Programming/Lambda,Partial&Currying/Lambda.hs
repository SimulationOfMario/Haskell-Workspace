{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant lambda" #-}

safeHead :: [a] -> Maybe a
safeHead (x:_) = Just x
safeHead _     = Nothing

unsafeHead :: [a] -> a
unsafeHead = \(x:_) -> x
-- ! Fails with an empty list