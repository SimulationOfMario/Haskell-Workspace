-- * Cycle funtion
-- Ties a finite list into a circular one, or equivalently, the infinite repetition of the original list. It is the identity on infinite lists.
-- ? cycle :: [a] -> [a]

-- ? Examples:
-- input:  cycle [26]
-- output: [26,26,26,26...]

-- input:  cycle []
-- output: Exception

-- input:  cycle [1,2,3]
-- output: [1,2,3,1,2,3,1,2,3...]

-- ! You should this function carefully, because its output is an infinite list.
-- * You can use it for example with functions like `take`

-- ? Examples:
-- input:  take 6 (cycle [8])
-- output: [8,8,8,8,8,8]

-- input:  take 10 (cycle [1,2])
-- output: [1,2,1,2,1,2,1,2,1,2]