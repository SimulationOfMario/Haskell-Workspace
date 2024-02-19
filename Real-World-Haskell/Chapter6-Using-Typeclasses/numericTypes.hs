import Data.Int (Int8, Int16, Int32, Int64)
import Data.Word (Word8, Word16, Word32, Word64) 


double :: Double
double = 8.4612837

float :: Float
float = 8.4612837

int :: Int
int = 9223372036854775807 -- (2^64 - 1)

int8 :: Int8
int8 = 127 -- (2^8 - 1)

int16 :: Int16
int16 = 32767 -- (2^16 - 1)

int32 :: Int32
int32 = 2147483647 -- (2^32 - 1)

int64 :: Int64
int64 = 9223372036854775807 -- (2^64 - 1)

integer :: Integer
integer = 10000000000000000000000000000000000000000000000000000000000

rational :: Rational
rational = 1/2 -- (shows: 1 % 2)

word :: Word
word = 9223372036854775807 * 2 -- (> 2^64 - 1)

word8 :: Word8
word8 = 127 * 2 -- (> 2^8 - 1)

word16 :: Word16
word16 = 32767 * 2 -- (> 2^16 - 1)

word32 :: Word32
word32 = 2147483647 * 2 -- (> 2^32 - 1)

word64 :: Word64
word64 = 9223372036854775807 * 2 -- (> 2^64 - 1)