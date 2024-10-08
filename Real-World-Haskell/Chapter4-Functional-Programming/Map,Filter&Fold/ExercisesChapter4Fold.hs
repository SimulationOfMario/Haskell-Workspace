{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use list comprehension" #-}

import Data.Char (digitToInt)
import Data.Either (Either)  -- * New data type: Either a b = Right b | Left a 
import Data.List (groupBy, foldl')


-- TODO: Use a fold to rewrite and improve upon the asInt function from the file: IntParse.hs
-- TODO: Extend the function to handle some kinds of exceptional conditions
asInt_foldl :: String -> Int
asInt_foldl ""              = 0                             -- Empty string case
asInt_foldl s   
    | head s == '-'         = (-1) * asInt_foldl (tail s)   -- Negative number case
    | otherwise             = foldl' step 0 s                -- General case
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
    | otherwise             = foldl' step (Right 0) s               -- General case
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



-- TODO: Write your own definition of the Prelude `takeWhile` function using explicit recursion
takeWhile_ER :: (a -> Bool) -> [a] -> [a]
takeWhile_ER _ []   = []
takeWhile_ER f (x:xs) 
    | f x           = x : takeWhile_ER f xs
    | otherwise     = []

-- TODO: Write your own definition of the Prelude `takeWhile` function using foldr
takeWhile_foldr :: (a -> Bool) -> [a] -> [a]
takeWhile_foldr f list = foldr step [] list 
    where
        step x res 
            | f x       = x : res
            | otherwise = []



-- TODO: Write your own implementation of the Data.List `groupBy` function using foldr
groupBy_foldr :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy_foldr f list = foldr step [] list
    where
        step x []               = [[x]]
        step x [r]
            | all check r       = [x : r]
            | otherwise         = step x [] ++ [r]
            where 
                check y = f x y
        step x rL               = step x (init rL) ++ [last rL]


-- TODO: Write your own implementation of the Data.List `groupBy` function using foldl
groupBy_foldl :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy_foldl f list = foldl' step [] list
    where
        step [] x               = [[x]]
        step [r] x
            | all check r       = [r ++ [x]]
            | otherwise         = r : step [] x
            where 
                check y = f x y
        step (r:rs) x               = r : step rs x


-- ? Example function to use as an input argument for groupBy_fold
compMod :: Int -> Int -> Bool
compMod x y = x `mod` b == y `mod` b
    where 
        b :: Int
        b = 2       -- You can change this number


-- ? Example input list argument for groupBy_fold
listExample1 :: [Int]
listExample1 = [1,1, 2,4,6, 3,5,7, 0,-2,-4,8, 1,1,3, 2, 5,7, 4, 3, 2, 7]



-- TODO: Write your own implementation of the Data.List `any` function using foldl
any_foldl :: Foldable t => (a -> Bool) -> t a -> Bool
any_foldl f list = foldl' step False list
    where
        step True _     = True
        step _ x        = f x


-- TODO: Write your own implementation of the Data.List `any` function using foldr
any_foldr :: Foldable t => (a -> Bool) -> t a -> Bool
any_foldr f list = foldr step False list
    where
        step _ True     = True
        step x _        = f x



-- TODO: Write your own implementation of the Prelude `cycle` function using foldl
cycle_foldl :: (Eq a) => [a] -> [a]
cycle_foldl list = foldl' step [] list
    where
        step res x = if res' == list
                     then res' ++ step res x
                     else res'
            where
                res' = res ++ [x]
-- ! I made it using (Eq a), but in the `cycle` definition this does not show up


-- TODO: Write your own implementation of the Prelude `cycle` function using foldr
cycle_foldr :: (Eq a) => [a] -> [a]
cycle_foldr list = foldr step [] list
    where
        step x res = if res' == list
                     then res' ++ step x res
                     else res'
            where
                res' = x : res
-- ! I made it using (Eq a), but in the `cycle` definition this does not show up



-- TODO: Write your own implementation of the Data.List `words` function using foldr
words_foldr :: String -> [String]
words_foldr str = fixFirst $ foldr step [] str
    where
        isSeparator x = x `elem` "\n\t\r "

        step c []           = if isSeparator c then [] else [[c]]
        step c res
            | isSeparator c = if null $ head res then res else [] : res
            | otherwise     = (c : head res) : tail res
        
        fixFirst list = if not (null list) && null (head list) then tail list else list
        

-- TODO: Write your own implementation of the Data.List `words` function using foldl
words_foldl :: String -> [String]
words_foldl str = fixLast $ foldl' step [] str
    where
        isSeparator x = x `elem` "\n\t\r "

        step [] c           = if isSeparator c then [] else [[c]]
        step res c
            | isSeparator c = if null $ last res then res else res ++ [[]]
            | otherwise     = init res ++ [last res ++ [c]]

        fixLast list = if not (null list) && null (last list) then init list else list
        


-- TODO: Write your own implementation of the Data.List `unlines` function using foldr
unlines_foldr :: [String] -> String
unlines_foldr list = foldr step "" list
    where 
        step word ""    = word ++ "\n"
        step word res   = word ++ "\n" ++ res 


-- TODO: Write your own implementation of the Data.List `unlines` function using foldl
unlines_foldl :: [String] -> String
unlines_foldl list = foldl' step "" list
    where 
        step "" word    = word ++ "\n"
        step res word   = res ++ word ++ "\n" 