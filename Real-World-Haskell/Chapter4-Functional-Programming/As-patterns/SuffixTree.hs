import Data.List (tails)

-- * Data.List `tails` function returns all the tails of a list
-- ? tails :: [a] -> [[a]]

-- ? Examples:
-- input: tails "foobar"
-- output: ["foobar", "oobar", "obar", "bar", "ar", "r", ""]

-- input: tails []
-- output: [[]]

-- * Now we want a function like `tails` but only returns the nonempty suffixes
-- * We will use a new piece of notation: the @ symbol

suffixes :: [a] -> [[a]]
suffixes xs@(_:xs') = xs : suffixes xs'
suffixes _          = []

-- ? The notation xs@(_:xs') is called as-pattern
-- ? It means "bind the variable xs to the value that matches the right side of the @ symbol"

-- * Let us compare a definition that lacks an as-pattern
noAsPattern :: [a] -> [[a]]
noAsPattern (x:xs) = (x:xs) : noAsPattern xs
noAsPattern _      = []
-- ! Using (x:xs) in the body function causes to allocate a new list node at runtime
-- ! That may be cheap, but not is not free
-- * Using as-pattern we reuse an existing value, that means we avoid a little allocation
