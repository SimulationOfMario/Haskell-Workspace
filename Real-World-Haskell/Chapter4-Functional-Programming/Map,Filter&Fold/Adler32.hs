import Data.Char (ord)
import Data.Bits (shiftL, (.&.), (.|.))

-- ? shiftL function implements a logical shift left
-- ? (.&.) operator provides a bitwise "and"
-- ? (.|.) operator provides a bitwise "or"

base :: Int
base = 65521

-- * The classic adler32 checksum
-- * It concatenates two 16-bit checksums into a single 32-bit checksum
adler32 :: [Char] -> Int
adler32 xs = helper 1 0 xs
    where
        helper a b (x:xs) = let 
                               a' = (a + (ord x .&. 0xff)) `mod` base
                               b' = (a' + b) `mod` base
                            in 
                                helper a' b' xs
        helper a b _      = (b `shiftL` 16) .|. a 


-- * We can use a pair as the acumulator in the loop
adler32_try2 :: [Char] -> Int
adler32_try2 xs = helper (1,0) xs
    where
        helper (a,b) (x:xs) =   let 
                                    a' = (a + (ord x .&. 0xff)) `mod` base
                                    b' = (a' + b) `mod` base
                                in 
                                    helper (a',b') xs 
        helper (a,b) _      = (b `shiftL` 16) .|. a 


-- * As well as Filter and Map function are the equivalent and efficient fucntions of its respectives purposes
-- * It exists a function for this kind of work we have done with adler32 (in relation of using a loop with accumulators)
-- * It is call the Fold function, rather: foldl and foldr functions
-- ? Watch the file: Fold.hs