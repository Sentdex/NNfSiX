module Util

import public Effects
import public Effect.Random

import public Data.Vect
import public Data.Matrix
import public Data.Matrix.Numeric

%access public export

infixl 5 <+ -- add a vector to each row of a matrix

||| Maximum size of the integer distribution
RAND_MAX : Integer
RAND_MAX = 32767

||| Generate a random Double in the range of  [0.0, 1.0]
rndUnitDouble : Eff Double [RND]
rndUnitDouble =
  pure $ (fromInteger !(rndInt 0 RAND_MAX)) / fromInteger RAND_MAX

||| Generate a randome Double in the range of [min, max]
rndDouble : (min : Double) -> (max : Double) -> Eff Double [RND]
rndDouble min max =
  pure $ (min + (max - min) * !rndUnitDouble)

||| Generate a random vector of length n of Doubles in the range of [min, max]
rndVect : (n : Nat) ->
          (min: Double) ->
          (max: Double) ->
          Eff (Vect n Double) [RND]
rndVect Z _ _ = pure []
rndVect (S k) min max = pure (!(rndDouble min max) :: !(rndVect k min max))

||| Generate an n x m matrix of random Doubles in the range of [min, max]
rndMat : (n : Nat) ->
         (m : Nat) ->
         (min : Double) ->
         (max: Double) ->
         Eff (Matrix n m Double) [RND]
rndMat Z _ _ _ = pure []
rndMat (S k) m min max = pure (!(rndVect m min max) :: !(rndMat k m min max))

||| Generate a vector of length n of Doubles initialized to 0.0
zeroVect : (n : Nat) -> Vect n Double
zeroVect Z = []
zeroVect (S k) = 0.0 :: zeroVect k

||| Generate an n x m matrix of random Doubles initialized to 0.0
zeroMat : (n : Nat) -> (m : Nat) -> Matrix n m Double
zeroMat Z _ = []
zeroMat (S k) m = zeroVect m :: zeroMat k m

||| Add a vector to each row of a matrix
(<+) : Matrix n m Double -> Vect m Double -> Matrix n m Double
(<+) [] _ = []
(<+) (x :: xs) v = (x + v) :: (xs <+ v)
