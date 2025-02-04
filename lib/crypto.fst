(*--build-config
options:--admit_fsi FStar.Set;
other-files: set.fsi heap.fst st.fst all.fst bytes.fst;
--*)
module FStar.Crypto

open FStar.Bytes

type nbytes (n:nat) = b:bytes{length b == n} (* fixed-length bytes *)
type tag = nbytes 20

assume val sha1: bytes -> Tot tag

type hmac_key = nbytes 16
assume val hmac_sha1_keygen: unit -> Tot hmac_key
assume val hmac_sha1: hmac_key -> bytes -> Tot tag
assume val hmac_sha1_verify: hmac_key -> bytes -> tag -> Tot bool

type block  = nbytes 32
type cipher = nbytes (2 * 32)
type aes_key = nbytes 16
type aes_iv = nbytes 16

assume val aes_128_keygen: unit -> Tot aes_key
assume val aes_128_decrypt: aes_key -> cipher -> Tot block
assume val aes_128_encrypt: k:aes_key -> p:block -> c:cipher {aes_128_decrypt k c = p}

assume val aes_128_ivgen: unit -> Tot aes_iv
assume val aes_128_cbc_decrypt: aes_key -> aes_iv -> bytes -> Tot bytes
assume val aes_128_cbc_encrypt: k:aes_key -> iv:aes_iv -> p:bytes -> c:bytes {aes_128_cbc_decrypt k iv c = p}

type rsa_pkey = {modulus: bytes; exponent: bytes}
type rsa_skey = rsa_pkey * bytes

assume val rsa_keygen: unit -> Tot rsa_skey
assume val rsa_pk: rsa_skey -> Tot rsa_pkey
assume val rsa_pkcs1_encrypt: rsa_pkey -> bytes -> bytes
assume val rsa_pkcs1_decrypt: rsa_skey -> bytes -> bytes

type sigv = bytes
assume val rsa_sha1: rsa_skey -> bytes -> sigv
assume val rsa_sha1_verify: rsa_pkey -> bytes -> sigv -> bool


