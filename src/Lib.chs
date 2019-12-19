module Lib where
import Data.Word (Word8)
import Foreign.Marshal.Utils
import Foreign.Storable

data Color = Color !Word8 !Word8 !Word8 !Word8 deriving (Show, Eq)

instance Storable Color where
  sizeOf = undefined
  alignment = undefined
  peek = undefined
  poke = undefined

#include "foo.h"

{# fun unsafe ClearBackground as ^ {with* %`Color'} -> `()' #}

helloWorld :: IO ()
helloWorld = showStorable $ Color 1 2 3 4

-- We'll call thise just to prove that Color is Storable
showStorable :: (Storable a, Show a) => a -> IO ()
showStorable = putStrLn . show
