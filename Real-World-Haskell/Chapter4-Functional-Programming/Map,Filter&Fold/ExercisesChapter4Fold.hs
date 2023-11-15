{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

import Data.Char (digitToInt)

-- TODO: Use a fold to rewrite and improve upon the asInt function from the file: IntParse.hs
asInt_foldl :: String -> Int
asInt_foldl x = foldl step 0 x
    where
        step :: Int -> Char -> Int
        step acc x = acc * 10 + digitToInt x
-- ! For excesive large numbers this function do not work properly