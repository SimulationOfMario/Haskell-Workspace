{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use sum" #-}

import Data.Char (ord)
import Data.Bits (shiftL, (.&.), (.|.))
import Data.List (foldl')

-- * Definition of foldl
-- ? foldl :: (a -> b -> a) -> a -> [b] -> a
-- ? foldl step zero (x:xs) = foldl step (step zero x) xs
-- ? foldl _    zero []     = zero

-- * This is the rewrite SumAllElemList but using foldl
foldlSum :: [Integer] -> Integer
foldlSum xs = foldl step 0 xs
    where
        step acc x = acc + x 


-- * Without using the where clause
niceSum :: [Integer] -> Integer
niceSum xs = foldl (+) 0 xs


-- * Rewriting Adler32 with foldl
adler32_foldl :: [Char] -> Int
adler32_foldl xs =  let
                        (a,b) = foldl step (1,0) xs
                    in
                        (b `shiftL` 16) .|. a
    where 
        base :: Int
        base = 65521

        step (a,b) x =  let 
                            a' = a + (ord x .&. 0xff)
                        in
                            (a' `mod` base, (a' + b) `mod` base)


-- * Definition of foldr
-- ? foldr :: (a -> b -> b) -> b -> [a] -> b
-- ? foldr step zero (x:xs) = step x (foldr step zero xs)
-- ? foldr _    zero []     = zero

-- * The same sum but with foldr
foldrSum :: [Integer] -> Integer
foldrSum xs = foldr (+) 0 xs

-- * Uses of foldr
-- We can write filter function using foldr
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p xs = foldr step [] xs
    where
        step x ys 
            | p x       = x:ys
            | otherwise = ys

-- ! The class of functions that we can express using foldr is called Primitive Recursive

-- * More examples
-- Map function using foldr
myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr step [] xs
    where
        step x ys = f x : ys

-- Foldl function using foldr
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f z xs = foldr step id xs z
    where
        step x g a = g (f a x)

-- ? id function returns the input value
-- ? id :: a -> a
-- ? id x = x

-- * Example of fold with the identity operator (:)
identity :: [a] -> [a]
identity xs = foldr (:) [] xs
-- ? It transform the list into a copy of itself

-- * Example of fold with the append operator but without it (using identity instead)
append :: [a] -> [a] -> [a]
append xs ys = foldr (:) ys xs
-- ? append [1,9] [0,8] == [1,9] ++ [0,8]

-- ! foldl is never used in practice, this is because it creates thunk expressions that costs more than immediately arithmetic evaluation
-- * Example: foldl (+) 0 [1..1000000] 
-- * Output: Stack overflow
-- ! This problem, (the invisible thunking) is called Space Leak
-- ! One way to solve this is importing: Data.List (foldl')

-- ? foldl' (+) 0 [1..1000] == foldl (+) 0 [1..1000]
-- ? foldl' (+) 0 [1..10000000] not crashes
