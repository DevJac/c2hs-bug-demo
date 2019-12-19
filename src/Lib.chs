module Lib where
import Data.Word (Word8)
import Foreign.Marshal.Utils
import Foreign.Storable

data Color = Color !Word8 !Word8 !Word8 !Word8 deriving (Show, Eq)

instance Storable Color where
  -- These type holes would crash at runtime,
  -- but we're never going to reach runtime
  -- because of a C2HS bug that causes a type error
  -- at compile time.
  sizeOf = _DEMO
  alignment = _DEMO
  peek = _DEMO
  poke = _DEMO

#include "foo.h"

{# fun unsafe ClearBackground as ^ {with* %`Color'} -> `()' #}

helloWorld :: IO ()
helloWorld = showStorable $ Color 1 2 3 4

-- We'll call this just to prove that Color is Storable
showStorable :: (Storable a, Show a) => a -> IO ()
showStorable = putStrLn . show
