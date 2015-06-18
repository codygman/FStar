(*--build-config
    variables:LIB=../../lib;
    other-files:$LIB/ext.fst $LIB/set.fsi
  --*)
module MachineWord

(*copied fro examples/maths/bijection.fst, because that file doesn't compile*)
type inverseLR (#a:Type) (#b:Type) (fab:(a -> Tot b)) (fba:(b -> Tot a)) =
       (forall (x:a). fba (fab x) = x) /\ (forall (y:b). fab (fba y) = y)

let bitsize:nat = 32

assume val nexp : nat -> nat -> Tot nat


type wordNat = (n:int{0 < n /\ n < (nexp bitsize bitsize)})

type word = (n:nat{n<bitsize}) -> Tot bool

assume val toNat : word -> Tot wordNat
assume val fromNat : f:(wordNat -> Tot word){inverseLR f toNat}

(*when compiled, it will be mapped to a SINGLE CPU instruction.
  This definition is for reasoning purposes, if any*)
val complement : word -> Tot word
let complement w = (fun n -> (not (w n)))

val xor : bool -> bool -> Tot bool
let xor a b = (a || b) && ((not a) || (not b))

val bitwiseXOR : word -> word ->  Tot word
let bitwiseXOR w1 w2 = (fun n -> (xor (w1 n) (w2 n)))

val bitwiseAnd : word -> word -> Tot word
let bitwiseAnd w1 w2 = (fun n -> ((w1 n) && (w2 n)))

val bitwiseOr : word -> word -> Tot word
let bitwiseOr w1 w2 = (fun n -> ((w1 n) || (w2 n)))


assume val fromHex : string -> Tot word

assume val modAddNat : wordNat -> wordNat -> Tot wordNat

val wmodAdd : word -> word -> Tot word
let wmodAdd w1 w2 =  fromNat (modAddNat (toNat w1) (toNat w2))
