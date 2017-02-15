module Actors

%default total


data Request = Add Nat Nat

Response: Request -> Type
Response (Add x y ) = Nat

adder: ServerLoop Response ()
adder = do Action(PutStrLn "Waiting...")
           Accept( \msg => case msg of
                           Add x y => Pure ( x + y ))
           Loop adder

client: Server Response -> Client ()
client addServer = do Action(PutStr "Number :")
                      num <- Action getLine
                      answer <- Send addServer (cast num Nat) 94
                      Action(PutStrLn answer)



-- TODO define actor possible states as data type....
data Actor = Ready | Done



