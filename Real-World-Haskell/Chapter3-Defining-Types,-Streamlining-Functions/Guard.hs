-- Example of Case-Of structure (Switch)
fromMaybe :: p -> Maybe p -> p
fromMaybe defval wrapped =
 case wrapped of
    Nothing     -> defval
    Just value  -> value
    -- * We can use _ as another case to refer us to the "default case", if we not use it, the default case is a runtime error
