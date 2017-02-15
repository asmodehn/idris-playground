module Lukasiewicz

import Prelude.Bool

%access public export

%default total

-- ||| Three values for Kleene logic as type
-- ||| Also interpretable as a Fuzzy Boolean
-- ||| Also intrepretable in the context of Map Theory
-- data Fool = T True | U Unknown | F False

||| Fuzzy Bool Representation
Fool : Type
Fool = Maybe Bool  -- Fuzzy Logic | Quantum Logic | Category Theory | Map Theory
-- TODO : -> Lazy Bool ?

-- useful aliases for lazy people
T : Fool
T = Just True

F : Fool
F = Just False

U : Fool
U = Nothing

||| Kleene NOT
||| Ref https://en.wikipedia.org/wiki/Three-valued_logic#Kleene_and_Priest_logics
not : Fool -> Fool
not Nothing = Nothing
not (Just b) = (Just (not b))

imp: Fool -> Fool -> Fool
imp (Just False) _ = (Just True)
imp Nothing False = Nothing
imp Nothing _ = (Just True)
imp (Just True) b = b
