{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Eta reduce" #-}

import Data.Char (digitToInt)
import Data.Either (Either)  -- * New data type: Either a b = Right b | Left a 


-- TODO: Use a fold to rewrite and improve upon the asInt function from the file: IntParse.hs
-- TODO: Extend the function to handle some kinds of exceptional conditions
asInt_foldl :: String -> Int
asInt_foldl ""              = 0                             -- Empty string case
asInt_foldl s   
    | head s == '-'         = (-1) * asInt_foldl (tail s)   -- Negative number case
    | otherwise             = foldl step 0 s                -- General case
    where
        numbers :: String
        numbers = "1234567890"

        step :: Int -> Char -> Int         
        step acc d 
            | d `notElem` numbers   = error ("non-digit '" ++ [d] ++ "'")  -- If char is not a digit number case
            | res < 0               = error "The number is too large!"     -- If res > 2^63 - 1 , then its value will be negative (Int issues)
            | otherwise             = res
            where 
                res :: Int 
                res = acc * 10 + digitToInt d
-- ! For excesive large numbers this function do not work properly -> Added an error function



-- TODO: Rewrite the function asInt_foldl fixing that it should not call a error function
type ErrorMessage = String

asInt_either :: String -> Either ErrorMessage Int
asInt_either ""             = Right 0                              -- Empty string case
asInt_either s   
    | head s == '-'         = applyNeg (asInt_either (tail s))     -- Negative number case
    | otherwise             = foldl step (Right 0) s               -- General case
    where
        applyNeg :: Either ErrorMessage Int -> Either ErrorMessage Int
        applyNeg (Right n) = Right ((-1)*n)
        applyNeg left      = left

        numbers :: String
        numbers = "1234567890"

        step :: Either ErrorMessage Int -> Char -> Either ErrorMessage Int    
        step (Left m) _             = Left m    
        step (Right acc) d 
            | d `notElem` numbers   = Left err                         -- If char is not a digit number case
            | res < 0               = Left "The number is too large!"  -- If res > 2^63 - 1 , then its value will be negative (Int issues)
            | otherwise             = Right res
            where 
                res :: Int 
                res = acc * 10 + digitToInt d

                err :: ErrorMessage
                err = "non-digit '" ++ [d] ++ "'"         
-- * It works completely well!



-- TODO: Write your own definition of the Prelude `concat` function using foldr
concat_foldr :: [[a]] -> [a]
concat_foldr x = foldr (++) [] x



-- TODO: Write your own definition of the standard `takeWhile` function using explicit recursion
takeWhile_ER :: (a -> Bool) -> [a] -> [a]
takeWhile_ER _ []   = []
takeWhile_ER f (x:xs) 
    | f x           = x : takeWhile_ER f xs
    | otherwise     = []

-- TODO: Write your own definition of the standard `takeWhile` function using foldr
takeWhile_foldr :: (a -> Bool) -> [a] -> [a]
takeWhile_foldr f list = foldr step [] list 
    where
        step x res 
            | f x       = x : res
            | otherwise = []