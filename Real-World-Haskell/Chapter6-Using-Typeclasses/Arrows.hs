import Control.Arrow (Arrow, arr, (>>>), first, second, (***), (&&&))

-- * Basic Arrow Example with arr and >>>

-- Define an arrow that adds 1 and then multiplies by 2
example :: Arrow a => a Int Int
example = arr (+1) >>> arr (*2)

-- Running the arrow on an input
result :: Int
result = example 3
-- Output: 8 (because (3 + 1) * 2 = 8)


-- * Working with Tuples using first and second

-- Use `first` to apply an arrow to the first element of a tuple
exampleFirst :: (Int, String) -> (Int, String)
exampleFirst = first (arr (+1))

-- Apply the arrow
resultFirst :: (Int, String)
resultFirst = exampleFirst (3, "hello")
-- Output: (4, "hello")

-- Use `second` to apply an arrow to the second element of a tuple
exampleSecond :: (Int, String) -> (Int, String)
exampleSecond = second (arr (++ " world"))

-- Apply the arrow
resultSecond :: (Int, String)
resultSecond = exampleSecond (3, "hello")
-- Output: (3, "hello world")


-- * Parallel Arrow Application with (***)

-- Apply two arrows in parallel to a tuple
exampleParallel :: (Int, String) -> (Int, String)
exampleParallel = arr (+1) *** arr (++ " world")

-- Apply the arrows
resultParallel :: (Int, String)
resultParallel = exampleParallel (3, "hello")
-- Output: (4, "hello world")


-- * Duplicating Input with (&&&)

-- Apply two arrows to the same input
exampleBoth :: Int -> (Int, Int)
exampleBoth = arr (+1) &&& arr (*2)

-- Apply the arrows to a value
resultBoth :: (Int, Int)
resultBoth = exampleBoth 3
-- Output: (4, 6)


-- * Composing More Complex Arrows

-- Define a complex arrow composition
complexExample :: (Int, String) -> (Int, String)
complexExample = first (arr (+1)) >>> second (arr (++ " world")) >>> arr (\(x, y) -> (x * 2, y))

-- Apply the arrow
resultComplex :: (Int, String)
resultComplex = complexExample (3, "hello")
-- Output: (8, "hello world")
