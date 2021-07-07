(in-package #:sb-simd)

(define-scalar-records
  ;; Numbers
  (u8      8   (unsigned-byte  8)                        #:unsigned-num         (#:unsigned-reg))
  (u16     16  (unsigned-byte 16)                        #:unsigned-num         (#:unsigned-reg))
  (u32     32  (unsigned-byte 32)                        #:unsigned-num         (#:unsigned-reg))
  (u64     64  (unsigned-byte 64)                        #:unsigned-num         (#:unsigned-reg))
  (s8      8   (signed-byte  8)                          #:signed-num           (#:signed-reg))
  (s16     16  (signed-byte 16)                          #:signed-num           (#:signed-reg))
  (s32     32  (signed-byte 32)                          #:signed-num           (#:signed-reg))
  (s64     64  (signed-byte 64)                          #:signed-num           (#:signed-reg))
  (f32     32  single-float                              #:single-float         (#:single-reg))
  (f64     64  double-float                              #:double-float         (#:double-reg))
  ;; Vectors
  (u8vec   64  (simple-array (unsigned-byte 8) (*))      #:simple-array-unsigned-byte-8)
  (u16vec  64  (simple-array (unsigned-byte 16) (*))     #:simple-array-unsigned-byte-16)
  (u32vec  64  (simple-array (unsigned-byte 32) (*))     #:simple-array-unsigned-byte-32)
  (u64vec  64  (simple-array (unsigned-byte 64) (*))     #:simple-array-unsigned-byte-64)
  (s8vec   64  (simple-array (signed-byte 8) (*))        #:simple-array-signed-byte-8)
  (s16vec  64  (simple-array (signed-byte 16) (*))       #:simple-array-signed-byte-16)
  (s32vec  64  (simple-array (signed-byte 32) (*))       #:simple-array-signed-byte-32)
  (s64vec  64  (simple-array (signed-byte 64) (*))       #:simple-array-signed-byte-64)
  (f32vec  64  (simple-array single-float (*))           #:simple-array-single-float)
  (f64vec  64  (simple-array double-float (*))           #:simple-array-double-float)
  ;; Immediates
  (imm1 1 (unsigned-byte 1) (:constant (unsigned-byte 1)))
  (imm2 2 (unsigned-byte 2) (:constant (unsigned-byte 2)))
  (imm3 3 (unsigned-byte 3) (:constant (unsigned-byte 3)))
  (imm4 4 (unsigned-byte 4) (:constant (unsigned-byte 4)))
  (imm5 5 (unsigned-byte 5) (:constant (unsigned-byte 5)))
  (imm6 6 (unsigned-byte 6) (:constant (unsigned-byte 6)))
  (imm7 7 (unsigned-byte 7) (:constant (unsigned-byte 7)))
  (imm8 8 (unsigned-byte 8) (:constant (unsigned-byte 8))))

(define-simd-records
  (sb-simd-sse:p128   nil 128 #:simd-pack (#:int-sse-reg #:double-sse-reg #:single-sse-reg))
  (sb-simd-sse:f32.4  f32 128 #:simd-pack-single (#:single-sse-reg))
  (sb-simd-sse2:f64.2 f64 128 #:simd-pack-double (#:double-sse-reg))
  (sb-simd-sse2:u8.16 u8  128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:u16.8 u16 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:u32.4 u32 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:u64.2 u64 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:s8.16 s8  128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:s16.8 s16 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:s32.4 s32 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-sse2:s64.2 s64 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:p128   nil 128 #:simd-pack (#:int-sse-reg #:double-sse-reg #:single-sse-reg))
  (sb-simd-avx:f32.4  f32 128 #:simd-pack-single (#:single-sse-reg))
  (sb-simd-avx:f64.2  f64 128 #:simd-pack-double (#:double-sse-reg))
  (sb-simd-avx:u8.16  u8  128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:u16.8  u16 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:u32.4  u32 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:u64.2  u64 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:s8.16  s8  128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:s16.8  s16 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:s32.4  s32 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:s64.2  s64 128 #:simd-pack-int (#:int-sse-reg))
  (sb-simd-avx:p256   nil 256 #:simd-pack-256 (#:int-avx2-reg #:double-avx2-reg #:single-avx2-reg))
  (sb-simd-avx:f32.8  f32 256 #:simd-pack-256-single (#:single-avx2-reg))
  (sb-simd-avx:f64.4  f64 256 #:simd-pack-256-double (#:double-avx2-reg))
  (sb-simd-avx:u8.32  u8  256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:u16.16 u16 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:u32.8  u32 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:u64.4  u64 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:s8.32  s8  256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:s16.16 s16 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:s32.8  s32 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx:s64.4  s64 256 #:simd-pack-256-int (#:int-avx2-reg))
  ;; You may wonder why we define these packs twice both for AVX and AVX2.
  ;; The reason is that each of these instruction sets provides its own
  ;; version of the constructor for integer SIMD packs.  And since the
  ;; constructor has the same name as the pack, AVX2 cannot inherit them
  ;; from AVX.  Luckily, defining SIMD records is cheap, so we can simply
  ;; define them again with a different name (or rather, with the same name
  ;; but in a different package).
  (sb-simd-avx2:u8.32  u8  256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:u16.16 u16 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:u32.8  u32 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:u64.4  u64 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:s8.32  s8  256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:s16.16 s16 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:s32.8  s32 256 #:simd-pack-256-int (#:int-avx2-reg))
  (sb-simd-avx2:s64.4  s64 256 #:simd-pack-256-int (#:int-avx2-reg)))
