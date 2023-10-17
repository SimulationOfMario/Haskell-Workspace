-- Using Let block
lend :: (Ord a, Num a) => a -> a -> Maybe a
lend amount balance =   let reserve    = 100
                            newBalance = balance - amount
                        in if balance < reserve
                           then Nothing
                           else Just newBalance

-- Using Where block
lend2 :: (Ord a, Fractional a) => a -> a -> Maybe a
lend2 amount balance = if amount < reserve * 0.5 
                       then Just newBalance 
                       else Nothing
    where 
        reserve     = 100
        newBalance  = balance - amount 
