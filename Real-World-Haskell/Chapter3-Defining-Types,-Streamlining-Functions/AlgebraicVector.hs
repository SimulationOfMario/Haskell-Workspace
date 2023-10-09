-- Defines x and y coordinates or lengths
data Cartesian2D = Cartesian2D Double Double
                    deriving (Eq, Show)

-- Defines r and θ (distance and angle magnitude)
data Polar2D = Polar2D Double Double
                deriving (Eq, Show)

-- Cartesian2D (sqrt 2) (sqrt 2) == Polar2D (pi/4) 2
-- Is true but it can not be compared because there are different data types
