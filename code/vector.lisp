(in-package :sb-vm)

(defknown (sb-simd-avx2::%f64.4-vdot)
    ((simple-array double-float (*))
     (simple-array double-float (*))
     (integer 0 #.(- array-total-size-limit 16)))
    double-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx2::%f64.4-vdot)
  (:translate sb-simd-avx2::%f64.4-vdot)
  (:policy :fast-safe)
  (:args (u  :scs (descriptor-reg))
         (v  :scs (descriptor-reg))
         (n0-tn :scs (signed-reg)  :target n0))
  (:arg-types simple-array-double-float simple-array-double-float
              tagged-num)
  (:temporary (:sc signed-reg) i)
  (:temporary (:sc signed-reg :from (:argument 2)) n0)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:temporary (:sc double-avx2-reg) ymm3)
  (:temporary (:sc double-avx2-reg) ymm4)
  (:temporary (:sc double-avx2-reg) ymm5)
  (:temporary (:sc double-avx2-reg) ymm6)
  (:temporary (:sc double-avx2-reg) ymm7)
  (:temporary (:sc double-sse-reg)  xmm0)
  (:temporary (:sc double-sse-reg)  xmm1)
  (:results (result :scs (double-reg)))
  (:result-types double-float)
  (:generator 22
              (move n0 n0-tn)
              (inst vxorpd ymm4 ymm4 ymm4)
              (inst vxorpd ymm5 ymm5 ymm5)
              (inst vxorpd ymm6 ymm6 ymm6)
              (inst vxorpd ymm7 ymm7 ymm7)
              (inst xor i i)
              LOOP
              (inst vmovupd ymm0 (float-ref-ea u i 0 8 :scale 2))
              (inst vmovupd ymm1 (float-ref-ea u i 4 8 :scale 2))
              (inst vmovupd ymm2 (float-ref-ea u i 8 8 :scale 2))
              (inst vmovupd ymm3 (float-ref-ea u i 12 8 :scale 2))
              (inst vfmadd231pd ymm4 ymm0 (float-ref-ea v i 0 8 :scale 2))
              (inst vfmadd231pd ymm5 ymm1 (float-ref-ea v i 4 8 :scale 2))
              (inst vfmadd231pd ymm6 ymm2 (float-ref-ea v i 8 8 :scale 2))
              (inst vfmadd231pd ymm7 ymm3 (float-ref-ea v i 12 8 :scale 2))
              (inst add i 16)
              (inst cmp i n0)
              (inst jmp :b LOOP)
              DONE
              (inst vaddpd ymm4 ymm4 ymm5)
              (inst vaddpd ymm6 ymm6 ymm7)
              (inst vaddpd ymm4 ymm4 ymm6)
              (inst vmovapd xmm0 ymm4)
              (inst vextractf128 xmm1 ymm4 1)
              (inst vzeroupper)
              (inst vaddpd xmm0 xmm0 xmm1)
              (inst vpermilpd xmm1 xmm0 1)
              (inst vaddsd result xmm0 xmm1)))

(defknown (sb-simd-avx2::%f64.4-vdot2)
    ((simple-array double-float (*))
     (simple-array double-float (*))
     (integer 0 #.(- array-total-size-limit 8)))
    double-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx2::%f64.4-vdot2)
  (:translate sb-simd-avx2::%f64.4-vdot2)
  (:policy :fast-safe)
  (:args (u  :scs (descriptor-reg))
         (v  :scs (descriptor-reg))
         (n0-tn :scs (signed-reg) :target n0))
  (:arg-types simple-array-double-float simple-array-double-float
              tagged-num)
  (:temporary (:sc signed-reg) i)
  (:temporary (:sc signed-reg :from (:argument 2)) n0)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:temporary (:sc double-avx2-reg) ymm3)
  (:temporary (:sc double-sse-reg)  xmm0)
  (:temporary (:sc double-sse-reg)  xmm1)
  (:results (result :scs (double-reg)))
  (:result-types double-float)
  (:generator 22
              (move n0 n0-tn)
              (inst vxorpd ymm2 ymm2 ymm2)
              (inst vxorpd ymm3 ymm3 ymm3)
              (inst xor i i)
              LOOP
              (inst vmovupd ymm0 (float-ref-ea u i 0 8 :scale 2))
              (inst vmovupd ymm1 (float-ref-ea u i 4 8 :scale 2))
              (inst vfmadd231pd ymm2 ymm0 (float-ref-ea v i 0 8 :scale 2))
              (inst vfmadd231pd ymm3 ymm1 (float-ref-ea v i 4 8 :scale 2))
              (inst add i 8)
              (inst cmp i n0)
              (inst jmp :b LOOP)
              DONE
              (inst vaddpd ymm2 ymm2 ymm3)
              (inst vmovapd xmm0 ymm2)
              (inst vextractf128 xmm1 ymm2 1)
              (inst vzeroupper)
              (inst vaddpd xmm0 xmm0 xmm1)
              (inst vpermilpd xmm1 xmm0 1)
              (inst vaddsd result xmm0 xmm1)))

(defknown (sb-simd-avx2::%f32.8-vdot)
    ((simple-array single-float (*))
     (simple-array single-float (*))
     (integer 0 #.most-positive-fixnum))
    single-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx2::%f32.8-vdot)
  (:translate sb-simd-avx2::%f32.8-vdot)
  (:policy :fast-safe)
  (:args (u  :scs (descriptor-reg))
         (v  :scs (descriptor-reg))
         (n0-tn :scs (signed-reg)))
  (:arg-types simple-array-single-float simple-array-single-float
              tagged-num)
  (:temporary (:sc signed-reg) i)
  (:temporary (:sc signed-reg) n0)
  (:temporary (:sc single-avx2-reg) ymm0)
  (:temporary (:sc single-avx2-reg) ymm1)
  (:temporary (:sc single-avx2-reg) ymm2)
  (:temporary (:sc single-avx2-reg) ymm3)
  (:temporary (:sc single-avx2-reg) ymm4)
  (:temporary (:sc single-avx2-reg) ymm5)
  (:temporary (:sc single-avx2-reg) ymm6)
  (:temporary (:sc single-avx2-reg) ymm7)
  (:temporary (:sc single-sse-reg)  xmm0)
  (:temporary (:sc single-sse-reg)  xmm1)
  (:results (result :scs (single-reg)))
  (:result-types single-float)
  (:generator 22
              (move n0 n0-tn)
              (inst vxorps ymm4 ymm4 ymm4)
              (inst vxorps ymm5 ymm5 ymm5)
              (inst vxorps ymm6 ymm6 ymm6)
              (inst vxorps ymm7 ymm7 ymm7)
              (inst xor i i)
              LOOP
              (inst vmovups ymm0 (float-ref-ea u i 0 0))
              (inst vmovups ymm1 (float-ref-ea u i 8 0))
              (inst vmovups ymm2 (float-ref-ea u i 16 0))
              (inst vmovups ymm3 (float-ref-ea u i 24 0))
              (inst vfmadd231ps ymm4 ymm0 (float-ref-ea v i 0 0))
              (inst vfmadd231ps ymm5 ymm1 (float-ref-ea v i 8 0))
              (inst vfmadd231ps ymm6 ymm2 (float-ref-ea v i 16 0))
              (inst vfmadd231ps ymm7 ymm3 (float-ref-ea v i 24 0))
              (inst add i 32)
              (inst cmp i n0)
              (inst jmp :b LOOP)
              DONE
              (inst vaddps ymm4 ymm4 ymm5)
              (inst vaddps ymm6 ymm6 ymm7)
              (inst vaddps ymm4 ymm4 ymm6)
              (inst vmovaps xmm0 ymm4)
              (inst vextractf128 xmm1 ymm4 1)
              (inst vzeroupper)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vpermilpd xmm1 xmm0 1)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vmovshdup xmm1 xmm0)
              (inst vaddss result xmm0 xmm1)))

(defknown (sb-simd-avx::%f64.4-vsum)
    ((simple-array double-float (*))
     (integer 0 #.most-positive-fixnum))
    double-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-vsum)
  (:translate sb-simd-avx::%f64.4-vsum)
  (:policy :fast-safe)
  (:args (u  :scs (descriptor-reg))
         (n0-tn :scs (signed-reg)))
  (:arg-types simple-array-double-float tagged-num)
  (:temporary (:sc unsigned-reg) i)
  (:temporary (:sc unsigned-reg) n0)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:temporary (:sc double-avx2-reg) ymm3)
  (:temporary (:sc double-sse-reg)  xmm0)
  (:temporary (:sc double-sse-reg)  xmm1)
  (:results (result :scs (double-reg)))
  (:result-types double-float)
  (:generator 16
              (move n0 n0-tn)
              (inst vxorpd ymm0 ymm0 ymm0)
              (inst vxorpd ymm1 ymm1 ymm1)
              (inst vxorpd ymm2 ymm2 ymm2)
              (inst vxorpd ymm3 ymm3 ymm3)
              (inst xor i i)
              LOOP
              (inst vaddpd ymm0 ymm0 (float-ref-ea u i 0 0 :scale 4))
              (inst vaddpd ymm1 ymm1 (float-ref-ea u i 4 0 :scale 4))
              (inst vaddpd ymm2 ymm2 (float-ref-ea u i 8 0 :scale 4))
              (inst vaddpd ymm3 ymm3 (float-ref-ea u i 12 0 :scale 4))
              (inst add i 16)
              (inst cmp i n0)
              (inst jmp :b LOOP)
              DONE
              (inst vaddpd ymm0 ymm0 ymm1)
              (inst vaddpd ymm2 ymm2 ymm3)
              (inst vaddpd ymm0 ymm0 ymm2)
              (inst vmovapd xmm0 ymm0)
              (inst vextractf128 xmm1 ymm0 1)
              (inst vzeroupper)
              (inst vaddpd xmm0 xmm0 xmm1)
              (inst vunpckhpd xmm1 xmm0 xmm0)
              (inst vaddsd result xmm0 xmm1)))

(defknown (sb-simd-avx::%f32.8-vsum)
    ((simple-array single-float (*))
     (integer 0 #.most-positive-fixnum))
    single-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f32.8-vsum)
  (:translate sb-simd-avx::%f32.8-vsum)
  (:policy :fast-safe)
  (:args (u  :scs (descriptor-reg))
         (n0-tn :scs (signed-reg)))
  (:arg-types simple-array-single-float tagged-num)
  (:temporary (:sc signed-reg) i)
  (:temporary (:sc signed-reg) n0)
  (:temporary (:sc single-avx2-reg) ymm0)
  (:temporary (:sc single-avx2-reg) ymm1)
  (:temporary (:sc single-avx2-reg) ymm2)
  (:temporary (:sc single-avx2-reg) ymm3)
  (:temporary (:sc single-sse-reg)  xmm0)
  (:temporary (:sc single-sse-reg)  xmm1)
  (:results (result :scs (single-reg)))
  (:result-types single-float)
  (:generator 22
              (move n0 n0-tn)
              (inst vxorps ymm0 ymm0 ymm0)
              (inst vxorps ymm1 ymm1 ymm1)
              (inst vxorps ymm2 ymm2 ymm2)
              (inst vxorps ymm3 ymm3 ymm3)
              (inst xor i i)
              LOOP
              (inst vaddps ymm0 ymm0 (float-ref-ea u i 0 0))
              (inst vaddps ymm1 ymm1 (float-ref-ea u i 8 0))
              (inst vaddps ymm2 ymm2 (float-ref-ea u i 16 0))
              (inst vaddps ymm3 ymm3 (float-ref-ea u i 24 0))
              (inst add i 32)
              (inst cmp i n0)
              (inst jmp :b LOOP)
              DONE
              (inst vaddps ymm0 ymm0 ymm1)
              (inst vaddps ymm2 ymm2 ymm3)
              (inst vaddps ymm0 ymm0 ymm2)
              (inst vmovaps xmm0 ymm0)
              (inst vextractf128 xmm1 ymm0 1)
              (inst vzeroupper)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vmovshdup xmm1 xmm0)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vmovhlps xmm0 xmm0 xmm1)
              (inst vaddss result xmm1 xmm0)))

(defknown (sb-simd-avx::%f64.4-hsum)
    ((simd-pack-256 double-float))
    double-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-hsum)
  (:translate sb-simd-avx::%f64.4-hsum)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm1)
  (:results (result :scs (double-reg)))
  (:result-types double-float)
  (:generator 4 ;; what should be the cost?
              (inst vmovapd xmm0 x)
              (inst vextractf128 xmm1 x 1)
              (inst vzeroupper)
              (inst vaddpd xmm0 xmm0 xmm1)
              (inst vunpckhpd xmm1 xmm0 xmm0)
              (inst vaddsd result xmm0 xmm1)))

(defknown (sb-simd-avx::%f32.8-hsum)
    ((simd-pack-256 single-float))
    single-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f32.8-hsum)
  (:translate sb-simd-avx::%f32.8-hsum)
  (:policy :fast-safe)
  (:args (x :scs (single-avx2-reg)))
  (:arg-types simd-pack-256-single)
  (:temporary (:sc single-sse-reg) xmm0)
  (:temporary (:sc single-sse-reg) xmm1)
  (:results (result :scs (single-reg)))
  (:result-types single-float)
  (:generator 4 ;; what should be the cost?
              (inst vmovaps xmm0 x)
              (inst vextractf128 xmm1 x 1)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vmovshdup xmm1 xmm0)
              (inst vaddps xmm0 xmm0 xmm1)
              (inst vmovhlps xmm0 xmm0 xmm1)
              (inst vaddss result xmm1 xmm0)))

(defknown (sb-simd-avx::%f64.2-hsum)
    ((simd-pack double-float))
    double-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.2-hsum)
  (:translate sb-simd-avx::%f64.2-hsum)
  (:policy :fast-safe)
  (:args (x :scs (double-sse-reg)))
  (:arg-types simd-pack-double)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm1)
  (:results (result :scs (double-reg)))
  (:result-types double-float)
  (:generator 4 ;; what should be the cost?
              (inst vmovapd xmm0 x)
              (inst vextractf128 xmm1 x 1)
              (inst vzeroupper)
              (inst vaddpd xmm0 xmm0 xmm1)
              (inst vunpckhpd xmm1 xmm0 xmm0)
              (inst vaddsd result xmm0 xmm1)))

(defknown (sb-simd-sse3::%f32.4-hsum)
    ((simd-pack single-float))
    single-float
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-sse3::%f32.4-hsum)
  (:translate sb-simd-sse3::%f32.4-hsum)
  (:policy :fast-safe)
  (:args (xmm0 :scs (single-sse-reg)))
  (:arg-types simd-pack-single)
  (:temporary (:sc single-sse-reg) xmm1)
  (:results (result :scs (single-reg)))
  (:result-types single-float)
  (:generator 4 ;; what should be the cost?
              (inst movshdup xmm1 xmm0)
              (inst addps xmm0 xmm1)
              (inst movhlps xmm1 xmm0)
              (inst addps result xmm1)))

(defknown (sb-simd-avx::%f64.4-rec13)
    ((simd-pack-256 double-float)
     (simd-pack-256 double-float))
    (simd-pack-256 double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-rec13)
  (:translate sb-simd-avx::%f64.4-rec13)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg))
         (two :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double simd-pack-256-double)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:results (dest :scs (double-avx2-reg)))
  (:result-types simd-pack-256-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd ymm0 x)
              (inst vcvtpd2ps ymm0 ymm0)
              (inst vrcpps ymm0 ymm0)
              (inst vcvtps2pd ymm0 ymm0)
              (inst vmulpd ymm2 two ymm0)
              (inst vmulpd ymm0 ymm0 ymm0)
              (inst vmulpd ymm1 x ymm0)
              (inst vsubpd ymm0 ymm2 ymm1)
              (inst vmulpd ymm2 two ymm0)
              (inst vmulpd ymm0 ymm0 ymm0)
              (inst vmulpd ymm1 x ymm0)
              (inst vsubpd dest ymm2 ymm1)))

(defknown (sb-simd-avx::%f64.4-rec9)
    ((simd-pack-256 double-float)
     (simd-pack-256 double-float))
    (simd-pack-256 double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-rec9)
  (:translate sb-simd-avx::%f64.4-rec9)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg))
         (three :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double simd-pack-256-double)
  (:temporary (:sc single-avx2-reg) xmm1)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:results (dest :scs (double-avx2-reg)))
  (:result-types simd-pack-256-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd ymm0 x)
              (inst vcvtpd2ps xmm1 x)
              (inst vrcpps xmm1 xmm1)
              (inst vcvtps2pd ymm1 xmm1)
              (inst vmulpd ymm0 x ymm1)
              (inst vmulpd ymm2 ymm1 ymm0)
              (inst vsubpd ymm0 ymm0 three)
              (inst vmulpd ymm1 ymm1 three)
              (inst vmulpd ymm0 ymm2 ymm0)
              (inst vaddpd dest ymm0 ymm1)))

(defknown (sb-simd-avx::%f64.2-rec13)
    ((simd-pack double-float)
     (simd-pack double-float))
    (simd-pack double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.2-rec13)
  (:translate sb-simd-avx::%f64.2-rec13)
  (:policy :fast-safe)
  (:args (x :scs (double-sse-reg))
         (two :scs (double-sse-reg)))
  (:arg-types simd-pack-double simd-pack-double)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm1)
  (:temporary (:sc double-sse-reg) xmm2)
  (:results (dest :scs (double-sse-reg)))
  (:result-types simd-pack-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd xmm0 x)
              (inst vcvtpd2ps xmm0 xmm0)
              (inst vrcpps xmm0 xmm0)
              (inst vcvtps2pd xmm0 xmm0)
              (inst vmulpd xmm2 two xmm0)
              (inst vmulpd xmm0 xmm0 xmm0)
              (inst vmulpd xmm1 x xmm0)
              (inst vsubpd xmm0 xmm2 xmm1)
              (inst vmulpd xmm2 two xmm0)
              (inst vmulpd xmm0 xmm0 xmm0)
              (inst vmulpd xmm1 x xmm0)
              (inst vsubpd dest xmm2 xmm1)))

(defknown (sb-simd-avx::%f64.2-rec9)
    ((simd-pack double-float)
     (simd-pack double-float))
    (simd-pack double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.2-rec9)
  (:translate sb-simd-avx::%f64.2-rec9)
  (:policy :fast-safe)
  (:args (x :scs (double-sse-reg))
         (three :scs (double-sse-reg)))
  (:arg-types simd-pack-double simd-pack-double)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm1)
  (:temporary (:sc double-sse-reg) xmm2)
  (:results (dest :scs (double-sse-reg)))
  (:result-types simd-pack-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd xmm0 x)
              (inst vcvtpd2ps xmm1 x)
              (inst vrcpps xmm1 xmm1)
              (inst vcvtps2pd xmm1 xmm1)
              (inst vmulpd xmm0 x xmm1)
              (inst vmulpd xmm2 xmm1 xmm0)
              (inst vsubpd xmm0 xmm0 three)
              (inst vmulpd xmm1 xmm1 three)
              (inst vmulpd xmm0 xmm2 xmm0)
              (inst vaddpd dest xmm0 xmm1)))

(defknown (sb-simd-avx::%f64.4-rsqrt13)
    ((simd-pack-256 double-float)
     (simd-pack-256 double-float)
     (simd-pack-256 double-float))
    (simd-pack-256 double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-rsqrt13)
  (:translate sb-simd-avx::%f64.4-rsqrt13)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg))
         (half :scs (double-avx2-reg))
         (threehalfs :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double simd-pack-256-double simd-pack-256-double)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:temporary (:sc double-avx2-reg) ymm3)
  (:results (dest :scs (double-avx2-reg)))
  (:result-types simd-pack-256-double)
  (:generator 8 ;; what should be the cost?
              (inst vcvtpd2ps ymm0 x)
              (inst vrsqrtps ymm0 ymm0)
              (inst vcvtps2pd ymm0 ymm0)
              (inst vmulpd ymm2 threehalfs ymm0)
              (inst vmulpd ymm3 ymm0 ymm0)
              (inst vmulpd ymm1 x ymm0)
              (inst vmulpd ymm0 ymm1 ymm3)
              (inst vmulpd ymm0 half ymm0)
              (inst vsubpd ymm0 ymm2 ymm0)
              (inst vmulpd ymm2 threehalfs ymm0)
              (inst vmulpd ymm3 ymm0 ymm0)
              (inst vmulpd ymm1 x ymm0)
              (inst vmulpd ymm0 ymm1 ymm3)
              (inst vmulpd ymm0 half ymm0)
              (inst vsubpd dest ymm2 ymm0)))

(defknown (sb-simd-avx::%f64.4-rsqrt9)
    ((simd-pack-256 double-float)
     (simd-pack-256 double-float)
     (simd-pack-256 double-float)
     (simd-pack-256 double-float))
    (simd-pack-256 double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.4-rsqrt9)
  (:translate sb-simd-avx::%f64.4-rsqrt9)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg))
         (%0375 :scs (double-avx2-reg))
         (%1250 :scs (double-avx2-reg))
         (%1875 :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double simd-pack-256-double
              simd-pack-256-double simd-pack-256-double)
  (:temporary (:sc double-avx2-reg) xmm1)
  (:temporary (:sc double-avx2-reg) ymm0)
  (:temporary (:sc double-avx2-reg) ymm1)
  (:temporary (:sc double-avx2-reg) ymm2)
  (:results (dest :scs (double-avx2-reg)))
  (:result-types simd-pack-256-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd ymm0 x)
              (inst vcvtpd2ps xmm1 x)
              (inst vrsqrtps xmm1 xmm1)
              (inst vcvtps2pd ymm1 xmm1)
              (inst vmulpd ymm0 ymm1 ymm0)
              (inst vmulpd ymm0 ymm0 ymm1)
              (inst vmulpd ymm2 ymm0 %0375)
              (inst vmulpd ymm2 ymm0 ymm2)
              (inst vmulpd ymm0 ymm0 %1250)
              (inst vaddpd ymm0 ymm0 %1875)
              (inst vsubpd ymm0 ymm2 ymm0)
              (inst vmulpd dest ymm0 ymm1)))

(defknown (sb-simd-avx::%f64.2-rsqrt13)
    ((simd-pack double-float)
     (simd-pack double-float)
     (simd-pack double-float))
    (simd-pack double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.2-rsqrt13)
  (:translate sb-simd-avx::%f64.2-rsqrt13)
  (:policy :fast-safe)
  (:args (x :scs (double-sse-reg))
         (half :scs (double-sse-reg))
         (threehalfs :scs (double-sse-reg)))
  (:arg-types simd-pack-double simd-pack-double
              simd-pack-double)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm1)
  (:temporary (:sc double-sse-reg) xmm2)
  (:temporary (:sc double-sse-reg) xmm3)
  (:results (dest :scs (double-sse-reg)))
  (:result-types simd-pack-double)
  (:generator 8 ;; what should be the cost?
              (inst vcvtpd2ps xmm0 x)
              (inst vrsqrtps xmm0 xmm0)
              (inst vcvtps2pd xmm0 xmm0)
              (inst vmulpd xmm2 threehalfs xmm0)
              (inst vmulpd xmm3 xmm0 xmm0)
              (inst vmulpd xmm1 x xmm0)
              (inst vmulpd xmm0 xmm1 xmm3)
              (inst vmulpd xmm0 half xmm0)
              (inst vsubpd xmm0 xmm2 xmm0)
              (inst vmulpd xmm2 threehalfs xmm0)
              (inst vmulpd xmm3 xmm0 xmm0)
              (inst vmulpd xmm1 x xmm0)
              (inst vmulpd xmm0 xmm1 xmm3)
              (inst vmulpd xmm0 half xmm0)
              (inst vsubpd dest xmm2 xmm0)))

(defknown (sb-simd-avx::%f64.2-rsqrt9)
    ((simd-pack double-float)
     (simd-pack double-float)
     (simd-pack double-float)
     (simd-pack double-float))
    (simd-pack double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx::%f64.2-rsqrt9)
  (:translate sb-simd-avx::%f64.2-rsqrt9)
  (:policy :fast-safe)
  (:args (x :scs (double-sse-reg))
         (%0375 :scs (double-sse-reg))
         (%1250 :scs (double-sse-reg))
         (%1875 :scs (double-sse-reg)))
  (:arg-types simd-pack-double simd-pack-double
              simd-pack-double simd-pack-double)
  (:temporary (:sc double-sse-reg) xmm1)
  (:temporary (:sc double-sse-reg) xmm0)
  (:temporary (:sc double-sse-reg) xmm2)
  (:results (dest :scs (double-sse-reg)))
  (:result-types simd-pack-double)
  (:generator 8 ;; what should be the cost?
              (inst vmovapd xmm0 x)
              (inst vcvtpd2ps xmm1 x)
              (inst vrsqrtps xmm1 xmm1)
              (inst vcvtps2pd xmm1 xmm1)
              (inst vmulpd xmm0 xmm1 xmm0)
              (inst vmulpd xmm0 xmm0 xmm1)
              (inst vmulpd xmm2 xmm0 %0375)
              (inst vmulpd xmm2 xmm0 xmm2)
              (inst vmulpd xmm0 xmm0 %1250)
              (inst vaddpd xmm0 xmm0 %1875)
              (inst vsubpd xmm0 xmm2 xmm0)
              (inst vmulpd dest xmm0 xmm1)))

(defknown (sb-simd-avx2::%f64.4-fmadd231)
    ((simd-pack-256 double-float)
     (simd-pack-256 double-float)
     (simd-pack-256 double-float))
    (simd-pack-256 double-float)
    (movable flushable always-translatable)
  :overwrite-fndb-silently t)
(define-vop (sb-simd-avx2::%f64.4-fmadd231)
  (:translate sb-simd-avx2::%f64.4-fmadd231)
  (:policy :fast-safe)
  (:args (x :scs (double-avx2-reg) :target result)
         (y :scs (double-avx2-reg))
         (z :scs (double-avx2-reg)))
  (:arg-types simd-pack-256-double simd-pack-256-double simd-pack-256-double)
  (:results (result :scs (double-avx2-reg) :from (:argument 0)))
  (:result-types simd-pack-256-double)
  (:generator 2 ;; what should be the cost?
              (move result x)
              (inst vfmadd231pd result y z)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; SSE3

(in-package :sb-simd-sse3)

(declaim (ftype (function (f32.4) f32) f32.4-hsum)
         (inline f32.4-hsum))
(defun f32.4-hsum (%x)
  (declare (optimize (speed 3)))
  (%f32.4-hsum %x))

(declaim (ftype (function (f32vec f32vec) f32) f32.4-vdot)
         (inline f32.4-vdot))
(defun f32.4-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 16)) (+ index 16)))
       (acc1 (f32.4 0) (f32.4-incf acc1 (f32.4* (f32.4-aref u (+ index 0))
                                                (f32.4-aref v (+ index 0)))))
       (acc2 (f32.4 0) (f32.4-incf acc2 (f32.4* (f32.4-aref u (+ index 4))
                                                (f32.4-aref v (+ index 4)))))
       (acc3 (f32.4 0) (f32.4-incf acc3 (f32.4* (f32.4-aref u (+ index 8))
                                                (f32.4-aref v (+ index 8)))))
       (acc4 (f32.4 0) (f32.4-incf acc4 (f32.4* (f32.4-aref u (+ index 12))
                                                (f32.4-aref v (+ index 12))))))
      ((>= index (- n 16))
       (do ((result (f32.4-hsum (f32.4+ acc1 acc2 acc3 acc4))
                    (+ result (* (row-major-aref u index)
                                 (row-major-aref v index))))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f32vec) f32) f32.4-vsum)
         (inline f32.4-vsum))
(defun f32.4-vsum (u &aux (n (array-total-size u)))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 16)) (+ index 16)))
       (acc1 (f32.4 0) (f32.4-incf acc1 (f32.4-aref u (+ index 0))))
       (acc2 (f32.4 0) (f32.4-incf acc2 (f32.4-aref u (+ index 4))))
       (acc3 (f32.4 0) (f32.4-incf acc3 (f32.4-aref u (+ index 8))))
       (acc4 (f32.4 0) (f32.4-incf acc4 (f32.4-aref u (+ index 12)))))
      ((>= index (- n 16))
       (do ((result (f32.4-hsum (f32.4+ acc1 acc2 acc3 acc4))
                    (+ result (row-major-aref u index)))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f64vec f64vec) f64) f64.2-vdot)
         (inline f64.2-vdot))
(defun f64.2-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 8)) (+ index 8)))
       (acc1 (f64.2 0) (f64.2-incf acc1 (f64.2* (f64.2-aref u (+ index 0))
                                                (f64.2-aref v (+ index 0)))))
       (acc2 (f64.2 0) (f64.2-incf acc2 (f64.2* (f64.2-aref u (+ index 2))
                                                (f64.2-aref v (+ index 2)))))
       (acc3 (f64.2 0) (f64.2-incf acc3 (f64.2* (f64.2-aref u (+ index 4))
                                                (f64.2-aref v (+ index 4)))))
       (acc4 (f64.2 0) (f64.2-incf acc4 (f64.2* (f64.2-aref u (+ index 6))
                                                (f64.2-aref v (+ index 6))))))
      ((>= index (- n 8))
       (do ((result (multiple-value-call #'+ (f64.2-values (f64.2+ acc1 acc2 acc3 acc4)))
                    (+ result (* (row-major-aref u index)
                                 (row-major-aref v index))))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f64vec) f64) f64.2-vsum)
         (inline f64.2-vsum))
(defun f64.2-vsum (u  &aux (n (array-total-size u)))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 8)) (+ index 8)))
       (acc1 (f64.2 0) (f64.2-incf acc1 (f64.2-aref u (+ index 0))))
       (acc2 (f64.2 0) (f64.2-incf acc2 (f64.2-aref u (+ index 2))))
       (acc3 (f64.2 0) (f64.2-incf acc3 (f64.2-aref u (+ index 4))))
       (acc4 (f64.2 0) (f64.2-incf acc4 (f64.2-aref u (+ index 6)))))
      ((>= index (- n 8))
       (do ((result (multiple-value-call #'+ (f64.2-values (f64.2+ acc1 acc2 acc3 acc4)))
                    (+ result (row-major-aref u index)))
            (index index (1+ index)))
           ((>= index n) result)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; AVX

(in-package :sb-simd-avx)

(declaim (ftype (function (f64.2) f64) f64.2-hsum)
         (inline f64.2-hsum))
(defun f64.2-hsum (%x)
  (declare (optimize (speed 3)))
  (%f64.2-hsum %x))

(declaim (ftype (function (f64.4) f64) f64.4-hsum)
         (inline f64.4-hsum))
(defun f64.4-hsum (%x)
  (declare (optimize speed))
  (%f64.4-hsum %x))

(declaim (ftype (function (f32.8) f32) f32.8-hsum)
         (inline f32.8-hsum))
(defun f32.8-hsum (%x)
  (declare (optimize speed))
  (%f32.8-hsum %x))

(declaim (ftype (function (f64.4) f64.4) f64.4-rec13)
         (inline f64.4-rec13))
(defun f64.4-rec13 (%x)
  (declare (optimize speed))
  (%f64.4-rec13 %x (f64.4 2)))

(declaim (ftype (function (f64.4) f64.4) f64.4-rec9)
         (inline f64.4-rec9))
(defun f64.4-rec9 (%x)
  (declare (optimize speed))
  (%f64.4-rec9 %x (f64.4 3)))

(declaim (ftype (function (f64.4) f64.4))
         (inline f64.4-rec-9))
(defun f64.4-rec-9 (%x)
  (declare (optimize speed (safety 0) (debug 0))
           (type f64.4 %x))
  (let* ((x (f64.4-from-f32.4 (f32.4-reciprocal (f32.4-from-f64.4 %x))))
         (w (f64.4* x %x))
         (three (f64.4 3))
         (z (f64.4* w x))
         (w (f64.4- w three))
         (x (f64.4* x three))
         (z (f64.4* z w)))
    (f64.4+ z x)))

(declaim (ftype (function (f64.2) f64.2) f64.2-rec13)
         (inline f64.2-rec13))
(defun f64.2-rec13 (%x)
  (declare (optimize speed))
  (%f64.2-rec13 %x (f64.2 2)))

(declaim (ftype (function (f64.2) f64.2) f64.2-rec9)
         (inline f64.2-rec9))
(defun f64.2-rec9 (%x)
  (declare (optimize speed))
  (%f64.2-rec9 %x (f64.2 3)))

(declaim (ftype (function (f64.4) f64.4) f64.4-rsqrt13)
         (inline f64.4-rsqrt13))
(defun f64.4-rsqrt13 (%x)
  (declare (optimize speed))
  (%f64.4-rsqrt13 %x (f64.4 0.5)
                     (f64.4 1.5)))

(declaim (ftype (function (f64.4) f64.4) f64.4-rsqrt9)
         (inline f64.4-rsqrt9))
(defun f64.4-rsqrt9 (%x)
  (declare (optimize speed))
  (%f64.4-rsqrt9 %x (f64.4 0.375)
                    (f64.4 1.250)
                    (f64.4 -1.875)))

;; utilize vrsqrtps to compute an approximation of 1/sqrt(x) with float,
;; cast back to double and refine using a variation of
;; Goldschmidt’s algorithm to get < 1e-9 error
(declaim (ftype (function (f64.4) f64.4))
         (inline f64.4-rsqrt-9))
(defun f64.4-rsqrt-9 (s)
  (declare (optimize speed))
  (let* ((x (f64.4-from-f32.4 (f32.4-rsqrt (f32.4-from-f64.4 s))))
         (y (f64.4* x x s))
         (a (f64.4* y (f64.4 0.375)))
         (a (f64.4* a y))
         (b (f64.4* y (f64.4 1.250)))
         (b (f64.4- b (f64.4 1.875))))
    (f64.4* x (f64.4- a b))))

(declaim (ftype (function (f64.2) f64.2) f64.2-rsqrt13)
         (inline f64.2-rsqrt13))
(defun f64.2-rsqrt13 (%x)
  (declare (optimize speed))
  (%f64.2-rsqrt13 %x (f64.2 0.5) (f64.2 1.5)))

(declaim (ftype (function (f64.2) f64.2) f64.2-rsqrt9)
         (inline f64.2-rsqrt9))
(defun f64.2-rsqrt9 (%x)
  (declare (optimize speed))
  (%f64.2-rsqrt9 %x (f64.2 0.375) (f64.2 1.250) (f64.2 -1.875)))

(declaim (ftype (function (f64vec f64vec) f64) f64.2-vdot)
         (inline f64.2-vdot))
(defun f64.2-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 8)) (+ index 8)))
       (acc1 (f64.2 0) (f64.2-incf acc1 (f64.2* (f64.2-aref u (+ index 0))
                                                (f64.2-aref v (+ index 0)))))
       (acc2 (f64.2 0) (f64.2-incf acc2 (f64.2* (f64.2-aref u (+ index 4))
                                                (f64.2-aref v (+ index 4)))))
       (acc3 (f64.2 0) (f64.2-incf acc3 (f64.2* (f64.2-aref u (+ index 8))
                                                (f64.2-aref v (+ index 8)))))
       (acc4 (f64.2 0) (f64.2-incf acc4 (f64.2* (f64.2-aref u (+ index 12))
                                                (f64.2-aref v (+ index 12))))))
      ((>= index (- n 16))
       (do ((result (multiple-value-call #'+ (f64.2-values (f64.2+ acc1 acc2 acc3 acc4)))
                    (+ result (* (row-major-aref u index)
                                 (row-major-aref v index))))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f64vec f64vec) f64) f64.4-vdot)
         (inline f64.4-vdot))
(defun f64.4-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 16)) (+ index 16)))
       (acc1 (f64.4 0) (f64.4-incf acc1 (f64.4* (f64.4-aref u (+ index 0))
                                                (f64.4-aref v (+ index 0)))))
       (acc2 (f64.4 0) (f64.4-incf acc2 (f64.4* (f64.4-aref u (+ index 4))
                                                (f64.4-aref v (+ index 4)))))
       (acc3 (f64.4 0) (f64.4-incf acc3 (f64.4* (f64.4-aref u (+ index 8))
                                                (f64.4-aref v (+ index 8)))))
       (acc4 (f64.4 0) (f64.4-incf acc4 (f64.4* (f64.4-aref u (+ index 12))
                                                (f64.4-aref v (+ index 12))))))
      ((>= index (- n 16))
       (do ((result (multiple-value-call #'+ (f64.4-values (f64.4+ acc1 acc2 acc3 acc4)))
                    (+ result (* (row-major-aref u index)
                                 (row-major-aref v index))))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f32vec f32vec) f32) f32.8-vdot)
         (inline f32.8-vdot))
(defun f32.8-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 32)) (+ index 32)))
       (acc1 (f32.8 0) (f32.8-incf acc1 (f32.8* (f32.8-aref u (+ index 0))
                                                (f32.8-aref v (+ index 0)))))
       (acc2 (f32.8 0) (f32.8-incf acc2 (f32.8* (f32.8-aref u (+ index 8))
                                                (f32.8-aref v (+ index 8)))))
       (acc3 (f32.8 0) (f32.8-incf acc3 (f32.8* (f32.8-aref u (+ index 16))
                                                (f32.8-aref v (+ index 16)))))
       (acc4 (f32.8 0) (f32.8-incf acc4 (f32.8* (f32.8-aref u (+ index 24))
                                                (f32.8-aref v (+ index 24))))))
      ((>= index (- n 32))
       (do ((result (multiple-value-call #'+ (f32.8-values (f32.8+ acc1 acc2 acc3 acc4)))
                    (+ result (* (row-major-aref u index)
                                 (row-major-aref v index))))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f64vec) f64) f64.4-vsum)
         (inline f64.4-vsum))
(defun f64.4-vsum (v &aux (n (array-total-size v)))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 16)) (+ index 16)))
       (acc1 (f64.4 0) (f64.4-incf acc1 (f64.4-aref v (+ index 0))))
       (acc2 (f64.4 0) (f64.4-incf acc2 (f64.4-aref v (+ index 4))))
       (acc3 (f64.4 0) (f64.4-incf acc3 (f64.4-aref v (+ index 8))))
       (acc4 (f64.4 0) (f64.4-incf acc4 (f64.4-aref v (+ index 12)))))
      ((>= index (- n 16))
       (do ((result (multiple-value-call #'+ (f64.4-values (f64.4+ acc1 acc2 acc3 acc4)))
                    (+ result (row-major-aref v index)))
            (index index (1+ index)))
           ((>= index n) result)))))

(declaim (ftype (function (f32vec) f32) f32.8-vsum)
         (inline f32.8-vsum))
(defun f32.8-vsum (v &aux (n (array-total-size v)))
  (do ((index 0 (the (integer 0 #.(- array-total-size-limit 32)) (+ index 32)))
       (acc1 (f32.8 0) (f32.8-incf acc1 (f32.8-aref v (+ index 0))))
       (acc2 (f32.8 0) (f32.8-incf acc2 (f32.8-aref v (+ index 8))))
       (acc3 (f32.8 0) (f32.8-incf acc3 (f32.8-aref v (+ index 16))))
       (acc4 (f32.8 0) (f32.8-incf acc4 (f32.8-aref v (+ index 24)))))
      ((>= index (- n 32))
       (do ((result (multiple-value-call #'+
                      (f32.8-values (f32.8+ acc1 acc2 acc3 acc4)))
                    (+ result (row-major-aref v index)))
            (index index (1+ index)))
           ((>= index n) result)))))

(in-package :sb-simd-avx2)

(declaim (ftype (function (f64.4 f64.4 f64.4) f64.4) f64.4-fmadd231)
         (inline f64.4-fmadd231))
(defun f64.4-fmadd231 (%x %y %z)
  (declare (optimize (speed 3) (safety 0)))
  (%f64.4-fmadd231 %x %y %z))

(declaim (ftype (function (f64vec f64vec) f64) f64.4-vdot)
         (inline f64.4-vdot))
(defun f64.4-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (declare (optimize (speed 3) (safety 0) (debug 0))
           (type f64vec u v))
  (let ((n0 (- n (mod n 16))))
    (if (< n 16)
        (loop for i of-type fixnum below n
              summing (* (aref u i) (aref v i))
                into sum of-type f64
              finally (return sum))
        (+ (%f64.4-vdot u v n0)
           (loop for i of-type fixnum from n0 below n
                 summing (* (aref u i) (aref v i))
                   into sum of-type f64
                 finally (return sum))))))

(declaim (ftype (function (f64vec f64vec) f64) f64.4-vdot2)
         (inline f64.4-vdot2))
(defun f64.4-vdot2 (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (declare (optimize (speed 3) (safety 0) (debug 0))
           (type f64vec u v))
  (let ((n0 (- n (mod n 8))))
    (if (< n 8)
        (loop for i of-type fixnum below n
              summing (* (aref u i) (aref v i))
                into sum of-type f64
              finally (return sum))
        (+ (%f64.4-vdot2 u v n0)
           (loop for i of-type fixnum from n0 below n
                 summing (* (aref u i) (aref v i))
                   into sum of-type f64
                 finally (return sum))))))

(declaim (ftype (function (f32vec f32vec) f32) f32.8-vdot)
         (inline f32.8-vdot))
(defun f32.8-vdot (u v &aux (n (min (array-total-size u) (array-total-size v))))
  (declare (optimize speed (safety 0))
           (type f32vec u v))
  (let ((n0 (- n (mod n 32))))
    (if (< n 32)
        (loop for i of-type fixnum below n
              summing (* (aref u i) (aref v i))
                into sum of-type f32
              finally (return sum))
        (+ (%f32.8-vdot u v n0)
           (loop for i of-type fixnum from n0 below n
                 summing (* (aref u i) (aref v i))
                   into sum of-type f32
                 finally (return sum))))))
