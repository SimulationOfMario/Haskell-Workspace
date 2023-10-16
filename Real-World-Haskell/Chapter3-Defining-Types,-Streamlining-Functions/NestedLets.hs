-- Multiple Let blocks
foo :: Integer
foo = let a = 1
      in let b = 2
         in a + b

-- Shadowing a variable (both x have the same name but have different type and value)
bar :: (String, Integer)
bar = let x = 1
      in ((let x = "foo" in x), x)

-- a argument is never used, is shadowed
quux :: t -> [Char]
quux a = let a = "foo"
         in a ++ "eek!"

-- GHC & GHCI has a helpful option: -fwarn-name-shadowing
-- When enabled, GHC will print a warning message any time we shadow a name