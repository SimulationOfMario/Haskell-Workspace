-- Nested Let blocks
bar :: (Int, Bool)
bar =   let b = 2
            c = True
        in  let a = b
            in (a,c)

-- Nested Where blocks
foo :: Int
foo = x
    where x = y
            where y = 2