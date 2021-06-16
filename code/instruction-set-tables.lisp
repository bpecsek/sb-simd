(in-package #:sb-simd-sse)

(sb-simd::define-instruction-set #:sse
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   ;; f32.4
   (two-arg-f32.4-and #:andps   (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-or  #:orps    (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-xor #:xorps   (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-max #:maxps   (f32.4) (f32.4 f32.4) :cost 3 :encoding :sse :commutative t)
   (two-arg-f32.4-min #:minps   (f32.4) (f32.4 f32.4) :cost 3 :encoding :sse :commutative t)
   (two-arg-f32.4+    #:addps   (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse :commutative t)
   (two-arg-f32.4-    #:subps   (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse)
   (two-arg-f32.4*    #:mulps   (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse :commutative t)
   (two-arg-f32.4/    #:divps   (f32.4) (f32.4 f32.4) :cost 8 :encoding :sse)
   (two-arg-f32.4=    #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :eq :commutative t)
   (two-arg-f32.4/=   #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :neq :commutative t)
   (two-arg-f32.4<    #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :lt)
   (two-arg-f32.4<=   #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :le)
   (two-arg-f32.4>    #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :nle)
   (two-arg-f32.4>=   #:cmpps   (u32.4) (f32.4 f32.4) :cost 4 :encoding :sse :prefix :nlt)
   (f32.4-andnot      #:andnps  (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse)
   (f32.4-not         #:andnps  (f32.4) (f32.4)       :cost 1 :encoding :none)
   (f32.4-reciprocal  #:rcpps   (f32.4) (f32.4)       :cost 5)
   (f32.4-rsqrt       #:rsqrtps (f32.4) (f32.4)       :cost 5)
   (f32.4-sqrt        #:sqrtps  (f32.4) (f32.4)       :cost 15))
  (:loads
   (f32.4-load        #:movups  f32.4 f32vec f32.4-aref f32.4-row-major-aref))
  (:stores
   (f32.4-store       #:movups  f32.4 f32vec f32.4-aref f32.4-row-major-aref)
   (f32.4-ntstore     #:movntps f32.4 f32vec f32.4-non-temporal-aref f32.4-non-temporal-row-major-aref)))

(in-package #:sb-simd-sse2)

(sb-simd::define-instruction-set #:sse2
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   ;; f32.4
   (f32.4-vdot        #:andnpd (f32)   (f32vec f32vec) :cost 22 :encoding :none)
   (f32.4-vsum        #:andnpd (f32)   (f32vec)        :cost 22 :encoding :none)
   ;; f64.2
   (two-arg-f64.2-and #:andpd  (f64.2) (f64.2 f64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-f64.2-or  #:orpd   (f64.2) (f64.2 f64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-f64.2-xor #:xorpd  (f64.2) (f64.2 f64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-f64.2-max #:maxpd  (f64.2) (f64.2 f64.2) :cost 3 :encoding :sse :commutative t)
   (two-arg-f64.2-min #:minpd  (f64.2) (f64.2 f64.2) :cost 3 :encoding :sse :commutative t)
   (two-arg-f64.2+    #:addpd  (f64.2) (f64.2 f64.2) :cost 2 :encoding :sse :commutative t)
   (two-arg-f64.2-    #:subpd  (f64.2) (f64.2 f64.2) :cost 2 :encoding :sse)
   (two-arg-f64.2*    #:mulpd  (f64.2) (f64.2 f64.2) :cost 2 :encoding :sse :commutative t)
   (two-arg-f64.2/    #:divpd  (f64.2) (f64.2 f64.2) :cost 8 :encoding :sse)
   (two-arg-f64.2=    #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :eq :commutative t)
   (two-arg-f64.2/=   #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :neq :commutative t)
   (two-arg-f64.2<    #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :lt)
   (two-arg-f64.2<=   #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :le)
   (two-arg-f64.2>    #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :nle)
   (two-arg-f64.2>=   #:cmppd  (u64.2) (f64.2 f64.2) :cost 4 :encoding :sse :prefix :nlt)
   (f64.2-andnot      #:andnpd (f64.2) (f64.2 f64.2) :cost 1 :encoding :sse)
   (f64.2-not         #:andnpd (f64.2) (f64.2)       :cost 1 :encoding :none)
   (f64.2-sqrt        #:sqrtpd (f64.2) (f64.2)       :cost 20)
   (f64.2-vdot        #:andnpd (f64)   (f64vec f64vec) :cost 22 :encoding :none)
   (f64.2-vsum        #:andnpd (f64)   (f64vec)        :cost 22 :encoding :none)
   ;; u32.4
   (two-arg-u32.4-and #:pand   (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-u32.4-or  #:por    (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-u32.4-xor #:pxor   (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-u32.4+    #:paddd  (u32.4) (u32.4 u32.4) :cost 2 :encoding :sse :commutative t)
   (two-arg-u32.4-    #:psubd  (u32.4) (u32.4 u32.4) :cost 2 :encoding :sse)
   (u32.4-shiftl      #:pslld  (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse)
   (u32.4-shiftr      #:psrld  (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse)
   (u32.4-andnot      #:pandn  (u32.4) (u32.4 u32.4) :cost 1 :encoding :sse)
   (u32.4-not         #:pandn  (u32.4) (u32.4)       :cost 1 :encoding :none)
   ;; u64.2
   (two-arg-u64.2-and #:pand   (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-u64.2-or  #:por    (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-u64.2-xor #:pxor   (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-u64.2+    #:paddq  (u64.2) (u64.2 u64.2) :cost 2 :encoding :sse :commutative t)
   (two-arg-u64.2-    #:psubq  (u64.2) (u64.2 u64.2) :cost 2 :encoding :sse)
   (u64.2-shiftl      #:psllq  (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse)
   (u64.2-shiftr      #:psrlq  (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse)
   (u64.2-andnot      #:pandn  (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse)
   (u64.2-not         #:pandn  (u64.2) (u64.2)       :cost 1 :encoding :none))
  (:loads
   (f64.2-load #:movupd f64.2 f64vec f64.2-aref f64.2-row-major-aref)
   ;(u8.16-load #:movdqa u8.16 u8vec  u8.16-aref u8.16-row-major-aref)
   (u16.8-load #:movdqa u16.8 u16vec u16.8-aref u16.8-row-major-aref)
   (u32.4-load #:movdqa u32.4 u32vec u32.4-aref u32.4-row-major-aref)
   (u64.2-load #:movdqa u64.2 u64vec u64.2-aref u64.2-row-major-aref)
   ;(s8.16-load #:movdqa s8.16 s8vec  s8.16-aref s8.16-row-major-aref)
   (s16.8-load #:movdqa s16.8 s16vec s16.8-aref s16.8-row-major-aref)
   (s32.4-load #:movdqa s32.4 s32vec s32.4-aref s32.4-row-major-aref)
   (s64.2-load #:movdqa s64.2 s64vec s64.2-aref s64.2-row-major-aref))
  (:stores
   (f64.2-store #:movupd f64.2 f64vec f64.2-aref f64.2-row-major-aref)
   ;(u8.16-store #:movdqa u8.16 u8vec  u8.16-aref u8.16-row-major-aref)
   (u16.8-store #:movdqa u16.8 u16vec u16.8-aref u16.8-row-major-aref)
   (u32.4-store #:movdqa u32.4 u32vec u32.4-aref u32.4-row-major-aref)
   (u64.2-store #:movdqa u64.2 u64vec u64.2-aref u64.2-row-major-aref)
   ;(s8.16-store #:movdqa s8.16 u8vec  s8.16-aref s8.16-row-major-aref)
   (s16.8-store #:movdqa s16.8 u16vec s16.8-aref s16.8-row-major-aref)
   (s32.4-store #:movdqa s32.4 u32vec s32.4-aref s32.4-row-major-aref)
   (s64.2-store #:movdqa s64.2 u64vec s64.2-aref s64.2-row-major-aref)

   (f64.2-ntstore #:movntpd f64.2 f64vec f64.2-non-temporal-aref f64.2-non-temporal-row-major-aref)
   ;(u8.16-ntstore #:movntdq u8.16 u8vec  u8.16-non-temporal-aref u8.16-non-temporal-row-major-aref)
   (u16.8-ntstore #:movntdq u16.8 u16vec u16.8-non-temporal-aref u16.8-non-temporal-row-major-aref)
   (u32.4-ntstore #:movntdq u32.4 u32vec u32.4-non-temporal-aref u32.4-non-temporal-row-major-aref)
   (u64.2-ntstore #:movntdq u64.2 u64vec u64.2-non-temporal-aref u64.2-non-temporal-row-major-aref)
   ;(s8.16-ntstore #:movntdq s8.16 s8vec  s8.16-non-temporal-aref s8.16-non-temporal-row-major-aref)
   (s16.8-ntstore #:movntdq s16.8 s16vec s16.8-non-temporal-aref s16.8-non-temporal-row-major-aref)
   (s32.4-ntstore #:movntdq s32.4 s32vec s32.4-non-temporal-aref s32.4-non-temporal-row-major-aref)
   (s64.2-ntstore #:movntdq s64.2 s64vec s64.2-non-temporal-aref s64.2-non-temporal-row-major-aref)))

(in-package #:sb-simd-sse3)

(sb-simd::define-instruction-set #:sse3
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   (f32.4-hdup      #:movshdup (f32.4) (f32.4) :cost 1)
   (f32.4-ldup      #:movsldup (f32.4) (f32.4) :cost 1)
   (f64.2-broadcast #:movddup  (f64.2) (f64.2) :cost 1)))

(in-package #:sb-simd-ssse3)

(sb-simd::define-instruction-set #:ssse3
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   (u16.8-hadd #:phaddw (u16.8) (u16.8 u16.8) :cost 3 :encoding :sse)
   (u32.4-hadd #:phaddd (u32.4) (u32.4 u32.4) :cost 3 :encoding :sse)
   (u16.8-hsub #:phsubw (u16.8) (u16.8 u16.8) :cost 3 :encoding :sse)
   (u32.4-hsub #:phsubd (u32.4) (u32.4 u32.4) :cost 3 :encoding :sse)))

(in-package #:sb-simd-sse4.1)

(sb-simd::define-instruction-set #:sse4.1
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   (two-arg-u64.2=  #:pcmpeqq (u64.2) (u64.2 u64.2) :cost 1 :encoding :sse :commutative t)
   (two-arg-u64.2/= #:pcmpeqq (u64.2) (u64.2 u64.2) :cost 2 :encoding :none :commutative t))
  (:loads
   (f32.4-ntload #:movntdqa f32.4 f32vec f32.4-non-temporal-aref f32.4-non-temporal-row-major-aref)
   (f64.2-ntload #:movntdqa f64.2 f64vec f64.2-non-temporal-aref f64.2-non-temporal-row-major-aref)
   ;(u8.16-ntload #:movntdqa u8.16 u8vec  u8.16-non-temporal-aref u8.16-non-temporal-row-major-aref)
   (u16.8-ntload #:movntdqa u16.8 u16vec u16.8-non-temporal-aref u16.8-non-temporal-row-major-aref)
   (u32.4-ntload #:movntdqa u32.4 u32vec u32.4-non-temporal-aref u32.4-non-temporal-row-major-aref)
   (u64.2-ntload #:movntdqa u64.2 u64vec u64.2-non-temporal-aref u64.2-non-temporal-row-major-aref)
   ;(s8.16-ntload #:movntdqa s8.16 s8vec  s8.16-non-temporal-aref s8.16-non-temporal-row-major-aref)
   (s16.8-ntload #:movntdqa s16.8 s16vec s16.8-non-temporal-aref s16.8-non-temporal-row-major-aref)
   (s32.4-ntload #:movntdqa s32.4 s32vec s32.4-non-temporal-aref s32.4-non-temporal-row-major-aref)
   (s64.2-ntload #:movntdqa s64.2 s64vec s64.2-non-temporal-aref s64.2-non-temporal-row-major-aref)))

(in-package #:sb-simd-sse4.2)

(sb-simd::define-instruction-set #:sse4.2
  (:test #+x86-64 t #-x86-64 nil)
  (:primitives
   (two-arg-u64.2>  #:pcmpgtq (u64.2) (u64.2 u64.2) :cost 3 :encoding :sse)
   (two-arg-u64.2>= #:pcmpgtq (u64.2) (u64.2 u64.2) :cost 4 :encoding :none)
   (two-arg-u64.2<  #:pcmpgtq (u64.2) (u64.2 u64.2) :cost 3 :encoding :none)
   (two-arg-u64.2<= #:pcmpgtq (u64.2) (u64.2 u64.2) :cost 4 :encoding :none)))

(in-package #:sb-simd-avx)

(sb-simd::define-instruction-set #:avx
  (:test #+x86-64 (plusp (sb-alien:extern-alien "avx_supported" sb-alien:int) #-x86-64 nil))
  (:primitives
   ;; f32.4
   (f32.4-from-f64.4  #:vcvtpd2ps (f32.4) (f64.4)       :cost 5)
   (two-arg-f32.4-and #:vandps    (f32.4) (f32.4 f32.4) :cost 1 :commutative t)
   (two-arg-f32.4-or  #:vorps     (f32.4) (f32.4 f32.4) :cost 1 :commutative t)
   (two-arg-f32.4-xor #:vxorps    (f32.4) (f32.4 f32.4) :cost 1 :commutative t)
   (two-arg-f32.4-max #:vmaxps    (f32.4) (f32.4 f32.4) :cost 3 :commutative t)
   (two-arg-f32.4-min #:vminps    (f32.4) (f32.4 f32.4) :cost 3 :commutative t)
   (two-arg-f32.4+    #:vaddps    (f32.4) (f32.4 f32.4) :cost 2 :commutative t)
   (two-arg-f32.4-    #:vsubps    (f32.4) (f32.4 f32.4) :cost 2)
   (two-arg-f32.4*    #:vmulps    (f32.4) (f32.4 f32.4) :cost 2 :commutative t)
   (two-arg-f32.4/    #:vdivps    (f32.4) (f32.4 f32.4) :cost 8)
   (two-arg-f32.4=    #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :eq :commutative t)
   (two-arg-f32.4/=   #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :neq :commutative t)
   (two-arg-f32.4<    #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :lt)
   (two-arg-f32.4<=   #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :le)
   (two-arg-f32.4>    #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :gt)
   (two-arg-f32.4>=   #:vcmpps    (u32.4) (f32.4 f32.4) :cost 4 :prefix :ge)
   (f32.4-andnot      #:vandnps   (f32.4) (f32.4 f32.4) :cost 1)
   (f32.4-not         #:vandnps   (f32.4) (f32.4)       :cost 1 :encoding :none)
   (f32.4-hadd        #:vhaddps   (f32.4) (f32.8 f32.4) :cost 6)
   (f32.4-hsub        #:vhsubps   (f32.4) (f32.8 f32.4) :cost 6)
   (f32.4-reciprocal  #:vrcpps    (f32.4) (f32.4)       :cost 5)
   (f32.4-rsqrt       #:vrsqrtps  (f32.4) (f32.4)       :cost 5)
   (f32.4-sqrt        #:vsqrtps   (f32.4) (f32.4)       :cost 15)
   (f32.4-unpackhi    #:vunpckhps (f32.4) (f32.4 f32.4) :cost 1)
   (f32.4-unpacklo    #:vunpcklps (f32.4) (f32.4 f32.4) :cost 1)
   ;; f64.2
   (two-arg-f64.2-and #:vandpd    (f64.2) (f64.2 f64.2) :cost 1 :commutative t)
   (two-arg-f64.2-or  #:vorpd     (f64.2) (f64.2 f64.2) :cost 1 :commutative t)
   (two-arg-f64.2-xor #:vxorpd    (f64.2) (f64.2 f64.2) :cost 1 :commutative t)
   (two-arg-f64.2-max #:vmaxpd    (f64.2) (f64.2 f64.2) :cost 3 :commutative t)
   (two-arg-f64.2-min #:vminpd    (f64.2) (f64.2 f64.2) :cost 3 :commutative t)
   (two-arg-f64.2+    #:vaddpd    (f64.2) (f64.2 f64.2) :cost 2 :commutative t)
   (two-arg-f64.2-    #:vsubpd    (f64.2) (f64.2 f64.2) :cost 2)
   (two-arg-f64.2*    #:vmulpd    (f64.2) (f64.2 f64.2) :cost 2 :commutative t)
   (two-arg-f64.2/    #:vdivpd    (f64.2) (f64.2 f64.2) :cost 8)
   (two-arg-f64.2=    #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :eq :commutative t)
   (two-arg-f64.2/=   #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :neq :commutative t)
   (two-arg-f64.2<    #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :lt)
   (two-arg-f64.2<=   #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :le)
   (two-arg-f64.2>    #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :gt)
   (two-arg-f64.2>=   #:vcmppd    (u64.2) (f64.2 f64.2) :cost 4 :prefix :ge)
   (f64.2-andnot      #:vandnpd   (f64.2) (f64.2 f64.2) :cost 1)
   (f64.2-not         #:vandnpd   (f64.2) (f64.2)       :cost 1 :encoding :none)
   (f64.2-hadd        #:vhaddpd   (f64.2) (f64.2 f64.2) :cost 6)
   (f64.2-hsub        #:vhsubpd   (f64.2) (f64.2 f64.2) :cost 6)
   (f64.2-sqrt        #:vsqrtpd   (f64.2) (f64.2)       :cost 20)
   (f64.2-unpackhi    #:vunpckhpd (f64.2) (f64.2 f64.2) :cost 1)
   (f64.2-unpacklo    #:vunpcklpd (f64.2) (f64.2 f64.2) :cost 1)
   (f64.2-broadcast   #:movddup   (f64.2) (f64)         :cost 1)
   ;; f32.8
   (f32.8-from-u32.8  #:vcvtdq2ps (f32.8) (u32.8)       :cost 5)
   (two-arg-f32.8-and #:vandps    (f32.8) (f32.8 f32.8) :cost 1 :commutative t)
   (two-arg-f32.8-or  #:vorps     (f32.8) (f32.8 f32.8) :cost 1 :commutative t)
   (two-arg-f32.8-xor #:vxorps    (f32.8) (f32.8 f32.8) :cost 1 :commutative t)
   (two-arg-f32.8-max #:vmaxps    (f32.8) (f32.8 f32.8) :cost 3 :commutative t)
   (two-arg-f32.8-min #:vminps    (f32.8) (f32.8 f32.8) :cost 3 :commutative t)
   (two-arg-f32.8+    #:vaddps    (f32.8) (f32.8 f32.8) :cost 2 :commutative t)
   (two-arg-f32.8-    #:vsubps    (f32.8) (f32.8 f32.8) :cost 2)
   (two-arg-f32.8*    #:vmulps    (f32.8) (f32.8 f32.8) :cost 2 :commutative t)
   (two-arg-f32.8/    #:vdivps    (f32.8) (f32.8 f32.8) :cost 8)
   (two-arg-f32.8=    #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :eq :commutative t)
   (two-arg-f32.8/=   #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :neq :commutative t)
   (two-arg-f32.8<    #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :lt)
   (two-arg-f32.8<=   #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :le)
   (two-arg-f32.8>    #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :gt)
   (two-arg-f32.8>=   #:vcmpps    (u32.8) (f32.8 f32.8) :cost 4 :prefix :ge)
   (f32.8-andnot      #:vandnps   (f32.8) (f32.8 f32.8) :cost 1)
   (f32.8-not         #:vandnps   (f32.8) (f32.8)       :cost 1 :encoding :none)
   (f32.8-hadd        #:vhaddps   (f32.8) (f32.8 f32.8) :cost 6)
   (f32.8-hsub        #:vhsubps   (f32.8) (f32.8 f32.8) :cost 6)
   (f32.8-reciprocal  #:vrcpps    (f32.8) (f32.8)       :cost 5)
   (f32.8-rsqrt       #:vrsqrtps  (f32.8) (f32.8)       :cost 5)
   (f32.8-sqrt        #:vsqrtps   (f32.8) (f32.8)       :cost 15)
   (f64.4-hsum        #:vandnpd   (f64)   (f64.4)       :cost 4 :encoding :none)
   (f32.8-unpackhi    #:vunpckhps (f32.8) (f32.8 f32.8) :cost 1)
   (f32.8-unpacklo    #:vunpcklps (f32.8) (f32.8 f32.8) :cost 1)
   (f32.8-broadcast   #:vbroadcastss (f32.8) (f32)      :cost 1)
   (f32.8-vdot        #:vsqrtps   (f32)   (f32vec f32vec) :cost 22 :encoding :none)
   (f32.8-vsum        #:vsqrtps   (f32)   (f32vec)        :cost 15 :encoding :none)
   ;; f64.4
   (f64.4-from-f32.4  #:vcvtps2pd (f64.4) (f32.4)       :cost 5)
   (f64.4-from-u32.4  #:vcvtdq2pd (f64.4) (u32.4)       :cost 5)
   (two-arg-f64.4-and #:vandpd    (f64.4) (f64.4 f64.4) :cost 1 :commutative t)
   (two-arg-f64.4-or  #:vorpd     (f64.4) (f64.4 f64.4) :cost 1 :commutative t)
   (two-arg-f64.4-xor #:vxorpd    (f64.4) (f64.4 f64.4) :cost 1 :commutative t)
   (two-arg-f64.4-max #:vmaxpd    (f64.4) (f64.4 f64.4) :cost 3 :commutative t)
   (two-arg-f64.4-min #:vminpd    (f64.4) (f64.4 f64.4) :cost 3 :commutative t)
   (two-arg-f64.4+    #:vaddpd    (f64.4) (f64.4 f64.4) :cost 2 :commutative t)
   (two-arg-f64.4-    #:vsubpd    (f64.4) (f64.4 f64.4) :cost 2)
   (two-arg-f64.4*    #:vmulpd    (f64.4) (f64.4 f64.4) :cost 2 :commutative t)
   (two-arg-f64.4/    #:vdivpd    (f64.4) (f64.4 f64.4) :cost 8)
   (two-arg-f64.4=    #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :eq :commutative t)
   (two-arg-f64.4/=   #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :neq :commutative t)
   (two-arg-f64.4<    #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :lt)
   (two-arg-f64.4<=   #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :le)
   (two-arg-f64.4>    #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :gt)
   (two-arg-f64.4>=   #:vcmppd    (u64.4) (f64.4 f64.4) :cost 4 :prefix :ge)
   (f64.4-andnot      #:vandnpd   (f64.4) (f64.4 f64.4) :cost 1)
   (f64.4-not         #:vandnpd   (f64.4) (f64.4)       :cost 1 :encoding :none)
   (f64.4-hadd        #:vhaddpd   (f64.4) (f64.4 f64.4) :cost 6)
   (f64.4-hsub        #:vhsubpd   (f64.4) (f64.4 f64.4) :cost 6)
   (f64.4-sqrt        #:vsqrtpd   (f64.4) (f64.4)       :cost 20)
   (f64.4-unpackhi    #:vunpckhpd (f64.4) (f64.4 f64.4) :cost 1)
   (f64.4-unpacklo    #:vunpcklpd (f64.4) (f64.4 f64.4) :cost 1)
   (f64.4-broadcast   #:vbroadcastsd (f64.4) (f64)      :cost 1)
   (f64.4-reverse     #:vpermilpd (f64.4) (f64.4)       :cost 2 :encoding :none)
   (f64.4-rec-9       #:vpermilpd (f64.4) (f64.4)       :cost 2 :encoding :none)
   (f64.4-vdot        #:vpermilpd (f64)   (f64vec f64vec) :cost 22 :encoding :none)
   (f64.4-vsum        #:vpermilpd (f64)   (f64vec)      :cost 15 :encoding :none)
   ;; u8.16
   (two-arg-u8.16-and #:vpand     (u8.16) (u8.16 u8.16) :cost 1 :commutative t)
   (two-arg-u8.16-or  #:vpor      (u8.16) (u8.16 u8.16) :cost 1 :commutative t)
   (two-arg-u8.16-xor #:vpxor     (u8.16) (u8.16 u8.16) :cost 1 :commutative t)
   (two-arg-u8.16+    #:vpaddb    (u8.16) (u8.16 u8.16) :cost 2 :commutative t)
   (two-arg-u8.16-    #:vpsubb    (u8.16) (u8.16 u8.16) :cost 2)
   ;; u16.8
   (two-arg-u16.8-and #:vpand     (u16.8) (u16.8 u16.8) :cost 1 :commutative t)
   (two-arg-u16.8-or  #:vpor      (u16.8) (u16.8 u16.8) :cost 1 :commutative t)
   (two-arg-u16.8-xor #:vpxor     (u16.8) (u16.8 u16.8) :cost 1 :commutative t)
   (two-arg-u16.8+    #:vpaddw    (u16.8) (u16.8 u16.8) :cost 2 :commutative t)
   (two-arg-u16.8-    #:vpsubw    (u16.8) (u16.8 u16.8) :cost 2)
   (two-arg-u16.8-mullo #:vpmullw (u16.8) (u16.8 u16.8) :cost 2 :commutative t)
   ;; u32.4
   (two-arg-u32.4-and #:vpand     (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (two-arg-u32.4-or  #:vpor      (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (two-arg-u32.4-xor #:vpxor     (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (u32.4-andnot      #:vpandn    (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-not         #:vpandn    (u32.4) (u32.4)       :cost 1 :encoding :none)
   (two-arg-u32.4+    #:vpaddd    (u32.4) (u32.4 u32.4) :cost 2 :commutative t)
   (two-arg-u32.4-    #:vpsubd    (u32.4) (u32.4 u32.4) :cost 2)
   (u32.4-shiftl      #:vpslld    (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-shiftr      #:vpsrld    (u32.4) (u32.4 u32.4) :cost 1)
   ;; u64.2
   (two-arg-u64.2-and #:vpand     (u64.2) (u64.2 u64.2) :cost 1 :commutative t)
   (two-arg-u64.2-or  #:vpor      (u64.2) (u64.2 u64.2) :cost 1 :commutative t)
   (two-arg-u64.2-xor #:vpxor     (u64.2) (u64.2 u64.2) :cost 1 :commutative t)
   (u64.2-andnot      #:vpandn    (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-not         #:vpandn    (u64.2) (u64.2)       :cost 1 :encoding :none)
   (two-arg-u64.2+    #:vpaddq    (u64.2) (u64.2 u64.2) :cost 2 :commutative t)
   (two-arg-u64.2-    #:vpsubq    (u64.2) (u64.2 u64.2) :cost 2)
   (u64.2-shiftl      #:vpsllq    (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-shiftr      #:vpsrlq    (u64.2) (u64.2 u64.2) :cost 1)
   ;; u32.8
   (u32.8-from-f32.8  #:vcvtps2dq (u32.8) (f32.8)       :cost 4)
   (two-arg-u32.8-and #:vandps    (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8-or  #:vorps     (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8-xor #:vxorps    (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8+    #:vpaddq    (u32.8) (u32.8 u32.8) :cost 2 :commutative t)
   (two-arg-u32.8-    #:vpsubq    (u32.8) (u32.8 u32.8) :cost 2)
   (u32.8-andnot      #:vandnps   (u32.8) (u32.8 u32.8) :cost 1)
   (u32.8-not         #:vandnps   (u32.8) (u32.8)       :cost 1 :encoding :none)
   ;; u64.4
   (two-arg-u64.4-and #:vandpd    (u64.4) (u64.4 u64.4) :cost 1 :commutative t)
   (two-arg-u64.4-or  #:vorpd     (u64.4) (u64.4 u64.4) :cost 1 :commutative t)
   (two-arg-u64.4-xor #:vxorpd    (u64.4) (u64.4 u64.4) :cost 1 :commutative t)
   (two-arg-u64.4+    #:vpaddq    (u64.4) (u64.4 u64.4) :cost 2 :commutative t)
   (two-arg-u64.4-    #:vpsubq    (u64.4) (u64.4 u64.4) :cost 2)
   (u64.4-andnot      #:vandnpd   (u64.4) (u64.4 u64.4) :cost 1)
   (u64.4-not         #:vandnpd   (u64.4) (u64.4)       :cost 1 :encoding :none)
   ;; s8.16
   (two-arg-s8.16+    #:vpaddw    (s8.16) (s8.16 s8.16) :cost 2 :commutative t)
   (two-arg-s8.16-    #:vpsubw    (s8.16) (s8.16 s8.16) :cost 2)
   (two-arg-s8.16-mullo #:vpmullw (s8.16) (s8.16 s8.16) :cost 2 :commutative t)
   (s8.16-broadcast   #:vpbroadcastb (s8.16) (s8.16)    :cost 1)
   ;; s16.8
   (two-arg-s16.8-and #:vpand     (s16.8) (s16.8 s16.8) :cost 1 :commutative t)
   (two-arg-s16.8-or  #:vpor      (s16.8) (s16.8 s16.8) :cost 1 :commutative t)
   (two-arg-s16.8-xor #:vpxor     (s16.8) (s16.8 s16.8) :cost 1 :commutative t)
   (two-arg-s16.8+    #:vpaddw    (s16.8) (s16.8 s16.8) :cost 2 :commutative t)
   (two-arg-s16.8-    #:vpsubw    (s16.8) (s16.8 s16.8) :cost 2)
   (two-arg-s16.8-mullo #:vpmullw (s16.8) (s16.8 s16.8) :cost 2 :commutative t)
   (s16.8-broadcast   #:vpbroadcastw (s16.8) (s16.8)    :cost 1)
   ;; s32.4
   (two-arg-s32.4-and #:vpand     (s32.4) (s32.4 s32.4) :cost 1 :commutative t)
   (two-arg-s32.4-or  #:vpor      (s32.4) (s32.4 s32.4) :cost 1 :commutative t)
   (two-arg-s32.4-xor #:vpxor     (s32.4) (s32.4 s32.4) :cost 1 :commutative t)
   (two-arg-s32.4+    #:vpaddd    (s32.4) (s32.4 s32.4) :cost 2 :commutative t)
   (two-arg-s32.4-    #:vpsubd    (s32.4) (s32.4 s32.4) :cost 2)
   (two-arg-s32.4-mullo #:vpmulld (s32.4) (s32.4 s32.4) :cost 2 :commutative t)
   (s32.4-broadcast   #:vpbroadcastd (s32.4) (s32.4)    :cost 1)
   ;; s64.2
   (two-arg-s64.2-and #:vpand     (s64.2) (s64.2 s64.2) :cost 1 :commutative t)
   (two-arg-s64.2-or  #:vpor      (s64.2) (s64.2 s64.2) :cost 1 :commutative t)
   (two-arg-s64.2-xor #:vpxor     (s64.2) (s64.2 s64.2) :cost 1 :commutative t)
   (two-arg-s64.2+    #:vpaddq    (s64.2) (s64.2 s64.2) :cost 2 :commutative t)
   (two-arg-s64.2-    #:vpsubq    (s64.2) (s64.2 s64.2) :cost 2)
   (s64.2-shiftl      #:vpsllq    (s64.2) (s64.2 s64.2) :cost 1)
   (s64.2-shiftr      #:vpsrlq    (s64.2) (s64.2 s64.2) :cost 1)
   (s64.2-broadcast   #:vpbroadcastq (s64.2) (s64.2)    :cost 1)
   ;; s8.32
   (two-arg-s8.32-and #:vpand    (s8.32) (s8.32 s8.32)  :cost 1 :commutative t)
   (two-arg-s8.32-or  #:vpor     (s8.32) (s8.32 s8.32)  :cost 1 :commutative t)
   (two-arg-s8.32-xor #:vpxor    (s8.32) (s8.32 s8.32)  :cost 1 :commutative t)
   (two-arg-s8.32+    #:vpaddd   (s8.32) (s8.32 s8.32)  :cost 2 :commutative t)
   (two-arg-s8.32-    #:vpsubd   (s8.32) (s8.32 s8.32)  :cost 2)
   (s8.32-broadcast   #:vpbroadcastb (s8.32) (s8.32)    :cost 1)
   ;; s16.16
   (two-arg-s16.16-and #:vpand    (s16.16) (s16.16 s16.16) :cost 1 :commutative t)
   (two-arg-s16.16-or  #:vpor     (s16.16) (s16.16 s16.16) :cost 1 :commutative t)
   (two-arg-s16.16-xor #:vpxor    (s16.16) (s16.16 s16.16) :cost 1 :commutative t)
   (two-arg-s16.16+    #:vpaddd   (s16.16) (s16.16 s16.16) :cost 2 :commutative t)
   (two-arg-s16.16-    #:vpsubd   (s16.16) (s16.16 s16.16) :cost 2)
   (s16.16-broadcast  #:vpbroadcastw (s16.16) (s16.16)  :cost 1)
   ;; s32.8
   (two-arg-s32.8-and #:vpand     (s32.8) (s32.8 s32.8) :cost 1 :commutative t)
   (two-arg-s32.8-or  #:vpor      (s32.8) (s32.8 s32.8) :cost 1 :commutative t)
   (two-arg-s32.8-xor #:vpxor     (s32.8) (s32.8 s32.8) :cost 1 :commutative t)
   (two-arg-s32.8+    #:vpaddd    (s32.8) (s32.8 s32.8) :cost 2 :commutative t)
   (two-arg-s32.8-    #:vpsubd    (s32.8) (s32.8 s32.8) :cost 2)
   (two-arg-s32.8-mullo #:vpmulld (s32.8) (s32.8 s32.8) :cost 2 :commutative t)
   (s32.8-broadcast   #:vpbroadcastd (s32.8) (s32.8)    :cost 1)
   ;; s64.4
   (two-arg-s64.4-and #:vpand     (s64.4) (s64.4 s64.4) :cost 1 :commutative t)
   (two-arg-s64.4-or  #:vpor      (s64.4) (s64.4 s64.4) :cost 1 :commutative t)
   (two-arg-s64.4-xor #:vpxor     (s64.4) (s64.4 s64.4) :cost 1 :commutative t)
   (two-arg-s64.4+    #:vpaddq    (s64.4) (s64.4 s64.4) :cost 2 :commutative t)
   (two-arg-s64.4-    #:vpsubq    (s64.4) (s64.4 s64.4) :cost 2)
   (s64.4-shiftl      #:vpsllq    (s64.4) (s64.4 s64.4) :cost 1)
   (s64.4-shiftr      #:vpsrlq    (s64.4) (s64.4 s64.4) :cost 1)
   (s64.4-broadcast   #:vpbroadcastq (s64.4) (s64.4)    :cost 1)
   )
  (:loads
   (f32.4-load  #:vmovups f32.4  f32vec f32.4-aref f32.4-row-major-aref)
   (f64.2-load  #:vmovupd f64.2  f64vec f64.2-aref f64.2-row-major-aref)
   (f32.8-load  #:vmovups f32.8  f32vec f32.8-aref f32.8-row-major-aref)
   (f64.4-load  #:vmovupd f64.4  f64vec f64.4-aref f64.4-row-major-aref)
   ;(u8.16-load  #:vmovdqa u8.16  u8vec  u8.16-aref u8.16-row-major-aref)
   (u16.8-load  #:vmovdqa u16.8  u16vec u16.8-aref u16.8-row-major-aref)
   (u32.4-load  #:vmovdqa u32.4  u32vec u32.4-aref u32.4-row-major-aref)
   (u64.2-load  #:vmovdqa u64.2  u64vec u64.2-aref u64.2-row-major-aref)
   ;(u8.32-load  #:vmovdqu u8.32  u8vec  u8.16-aref u8.16-row-major-aref)
   (u16.16-load #:vmovdqu u16.16 u16vec u16.8-aref u16.8-row-major-aref)
   (u32.8-load  #:vmovdqu u32.8  u32vec u32.8-aref u32.8-row-major-aref)
   (u64.4-load  #:vmovdqu u64.4  u64vec u64.4-aref u64.4-row-major-aref)
   ;(s8.16-load  #:vmovdqa s8.16  s8vec  s8.16-aref s8.16-row-major-aref)
   (s16.8-load  #:vmovdqa s16.8  s16vec s16.8-aref s16.8-row-major-aref)
   (s32.4-load  #:vmovdqa s32.4  s32vec s32.4-aref s32.4-row-major-aref)
   (s64.2-load  #:vmovdqa s64.2  s64vec s64.2-aref s64.2-row-major-aref)
   ;(s8.32-load  #:vmovdqu s8.32  s8vec  s8.16-aref s8.16-row-major-aref)
   (s16.16-load #:vmovdqu s16.16 s16vec s16.8-aref s16.8-row-major-aref)
   (s32.8-load  #:vmovdqu s32.8  s32vec s32.8-aref s32.8-row-major-aref)
   (s64.4-load  #:vmovdqu s64.4  s64vec s64.4-aref s64.4-row-major-aref))
  (:stores
   (f32.4-store #:vmovups f32.4 f32vec f32.4-aref f32.4-row-major-aref)
   (f64.2-store #:vmovupd f64.2 f64vec f64.2-aref f64.2-row-major-aref)
   (f32.8-store #:vmovups f32.8 f32vec f32.8-aref f32.8-row-major-aref)
   (f64.4-store #:vmovupd f64.4 f64vec f64.4-aref f64.4-row-major-aref)
   ;(u8.16-store #:vmovdqu u8.16 u8vec  u32.4-aref u32.4-row-major-aref)
   (u16.8-store #:vmovdqu u16.8 u16vec u16.8-aref u64.2-row-major-aref)
   (u32.4-store #:vmovdqu u32.4 u32vec u32.4-aref u32.4-row-major-aref)
   (u64.2-store #:vmovdqu u64.2 u64vec u64.2-aref u64.2-row-major-aref)
   ;(s8.16-store #:vmovdqu s8.16 s8vec  s32.4-aref s32.4-row-major-aref)
   (s16.8-store #:vmovdqu s16.8 s16vec s16.8-aref s64.2-row-major-aref)
   (s32.4-store #:vmovdqu s32.4 s32vec s32.4-aref s32.4-row-major-aref)
   (s64.2-store #:vmovdqu s64.2 s64vec s64.2-aref s64.2-row-major-aref)
   
   ;(u8.32-store    #:vmovdqu  u8.32  u8vec  u8.32-aref  u8.32-row-major-aref)
   (u16.16-store   #:vmovdqu  u16.16 u16vec u16.16-aref u16.16-row-major-aref)
   (u32.8-store    #:vmovdqu  u32.8  u32vec u32.8-aref  u32.8-row-major-aref)
   (u64.4-store    #:vmovdqu  u64.4  u64vec u64.4-aref  u64.4-row-major-aref)
   ;(s8.32-store    #:vmovdqu  s8.32  s8vec  s8.32-aref  s8.32-row-major-aref)
   (s16.16-store   #:vmovdqu  s16.16 s16vec s16.16-aref s16.16-row-major-aref)
   (s32.8-store    #:vmovdqu  s32.8  s32vec s32.8-aref  s32.8-row-major-aref)
   (s64.4-store    #:vmovdqu  s64.4  s64vec s64.4-aref  s64.4-row-major-aref)
   (f32.4-ntstore  #:vmovntps f32.4  f32vec f32.4-non-temporal-aref  f32.4-non-temporal-row-major-aref)
   (f64.2-ntstore  #:vmovntpd f64.2  f64vec f64.2-non-temporal-aref  f64.2-non-temporal-row-major-aref)
   (f32.8-ntstore  #:vmovntps f32.8  f32vec f32.8-non-temporal-aref  f32.8-non-temporal-row-major-aref)
   (f64.4-ntstore  #:vmovntpd f64.4  f64vec f64.4-non-temporal-aref  f64.4-non-temporal-row-major-aref)
   ;(u8.16-ntstore  #:vmovntdq u8.16  u8vec  u8.16-non-temporal-aref  u8.16-non-temporal-row-major-aref)
   (u16.8-ntstore  #:vmovntdq u16.8  u16vec u16.8-non-temporal-aref  u16.8-non-temporal-row-major-aref)
   (u32.4-ntstore  #:vmovntdq u32.4  u32vec u32.4-non-temporal-aref  u32.4-non-temporal-row-major-aref)
   (u64.2-ntstore  #:vmovntdq u64.2  u64vec u64.2-non-temporal-aref  u64.2-non-temporal-row-major-aref)
   ;(s8.16-ntstore  #:vmovntdq s8.16  s8vec  s8.16-non-temporal-aref  s8.16-non-temporal-row-major-aref)
   (s16.8-ntstore  #:vmovntdq s16.8  s16vec s16.8-non-temporal-aref  s16.8-non-temporal-row-major-aref)
   (s32.4-ntstore  #:vmovntdq s32.4  s32vec s32.4-non-temporal-aref  s32.4-non-temporal-row-major-aref)
   (s64.2-ntstore  #:vmovntdq u64.2  s64vec s64.2-non-temporal-aref  s64.2-non-temporal-row-major-aref)
   
   ;(u8.32-ntstore  #:vmovntdq u8.32  u8vec  u8.32-non-temporal-aref  u8.32-non-temporal-row-major-aref)
   (u16.16-ntstore #:vmovntdq u16.16 u16vec u16.16-non-temporal-aref u16.16-non-temporal-row-major-aref)
   (u32.8-ntstore  #:vmovntdq u32.8  u32vec u32.8-non-temporal-aref  u32.8-non-temporal-row-major-aref)
   (u64.4-ntstore  #:vmovntdq u64.4  u64vec u64.4-non-temporal-aref  u64.4-non-temporal-row-major-aref)
   ;(s8.32-ntstore  #:vmovntdq s8.32  s8vec  s8.32-non-temporal-aref  s8.32-non-temporal-row-major-aref)
   (s16.16-ntstore #:vmovntdq s16.16 s16vec s16.16-non-temporal-aref s16.16-non-temporal-row-major-aref)
   (s32.8-ntstore  #:vmovntdq s32.8  s32vec s32.8-non-temporal-aref  s32.8-non-temporal-row-major-aref)
   (s64.4-ntstore  #:vmovntdq s64.4  s64vec s64.4-non-temporal-aref  s64.4-non-temporal-row-major-aref)))

(in-package #:sb-simd-avx2)

(sb-simd::define-instruction-set #:avx2
  (:test #+x86-64 (plusp (sb-alien:extern-alien "avx2_supported" sb-alien:int) #-x86-64 nil))
  (:primitives
   ;; f32.4
   (f32.4-broadcast   #:vbroadcastss (f32.4) (f32.4)       :cost 1)
   ;; f64.2
   ;; f32.8
   (f32.8-broadcast   #:vbroadcastss (f32.8) (f32.4)       :cost 1)
   ;; f64.4
   (f64.4-broadcast   #:vbroadcastsd (f64.4) (f64.2)       :cost 1)
   (f64.4-reverse     #:vpermilpd    (f64.4) (f64.4)       :cost 2 :encoding :none)
   ;; u32.4
   (two-arg-u32.4-max #:vpmaxud      (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (two-arg-u32.4-min #:vpminud      (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (two-arg-u32.4+    #:vpaddq       (u32.4) (u32.4 u32.4) :cost 2 :commutative t)
   (two-arg-u32.4-    #:vpsubq       (u32.4) (u32.4 u32.4) :cost 2)
   (two-arg-u32.4=    #:vpcmpeqd     (u32.4) (u32.4 u32.4) :cost 1 :commutative t)
   (two-arg-u32.4/=   #:vpcmpeqd     (u32.4) (u32.4 u32.4) :cost 2 :commutative t :encoding :none)
   (two-arg-u32.4>    #:vpcmpgtd     (u32.4) (u32.4 u32.4) :cost 1)
   (two-arg-u32.4<    #:vpcmpgtd     (u32.4) (u32.4 u32.4) :cost 1 :encoding :none)
   (two-arg-u32.4<=   #:vpcmpgtd     (u32.4) (u32.4 u32.4) :cost 2 :encoding :none)
   (two-arg-u32.4>=   #:vpcmpgtd     (u32.4) (u32.4 u32.4) :cost 2 :encoding :none)
   (u32.4-shiftl      #:vpsllvd      (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-shiftr      #:vpsrlvd      (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-unpackhi    #:vpunpckhdq   (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-unpacklo    #:vpunpckldq   (u32.4) (u32.4 u32.4) :cost 1)
   (u32.4-broadcast   #:vpbroadcastd (u32.4) (u32.4)       :cost 1)
   ;; u64.2
   (two-arg-u64.2+    #:vpaddq       (u64.2) (u64.2 u64.2) :cost 1 :commutative t)
   (two-arg-u64.2-    #:vpsubq       (u64.2) (u64.2 u64.2) :cost 1)
   (two-arg-u64.2=    #:vpcmpeqq     (u64.2) (u64.2 u64.2) :cost 1 :commutative t)
   (two-arg-u64.2/=   #:vpcmpeqq     (u64.2) (u64.2 u64.2) :cost 2 :commutative t :encoding :none)
   (two-arg-u64.2>    #:vpcmpgtq     (u64.2) (u64.2 u64.2) :cost 1)
   (two-arg-u64.2<    #:vpcmpgtq     (u64.2) (u64.2 u64.2) :cost 1 :encoding :none)
   (two-arg-u64.2>=   #:vpcmpgtq     (u64.2) (u64.2 u64.2) :cost 2 :encoding :none)
   (two-arg-u64.2<=   #:vpcmpgtq     (u64.2) (u64.2 u64.2) :cost 2 :encoding :none)
   (u64.2-shiftl      #:vpsllvq      (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-shiftr      #:vpsrlvq      (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-unpackhi    #:vpunpckhqdq  (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-unpacklo    #:vpunpcklqdq  (u64.2) (u64.2 u64.2) :cost 1)
   (u64.2-broadcast   #:vpbroadcastq (u64.2) (u64.2)       :cost 1)
   ;; u32.8
   (two-arg-u32.8-max #:vpmaxud      (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8-min #:vpminud      (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8+    #:vpaddd       (u32.8) (u32.8 u32.8) :cost 2 :commutative t)
   (two-arg-u32.8-    #:vpsubd       (u32.8) (u32.8 u32.8) :cost 2)
   (two-arg-u32.8=    #:vpcmpeqd     (u32.8) (u32.8 u32.8) :cost 1 :commutative t)
   (two-arg-u32.8/=   #:vpcmpeqd     (u32.8) (u32.8 u32.8) :cost 2 :commutative t :encoding :none)
   (two-arg-u32.8>    #:vpcmpgtd     (u32.8) (u32.8 u32.8) :cost 1)
   (two-arg-u32.8<    #:vpcmpgtd     (u32.8) (u32.8 u32.8) :cost 1 :encoding :none)
   (two-arg-u32.8>=   #:vpcmpgtd     (u32.8) (u32.8 u32.8) :cost 2 :encoding :none)
   (two-arg-u32.8<=   #:vpcmpgtd     (u32.8) (u32.8 u32.8) :cost 2 :encoding :none)
   (u32.8-shiftl      #:vpsllvd      (u32.8) (u32.8 u32.8) :cost 1)
   (u32.8-shiftr      #:vpsrlvd      (u32.8) (u32.8 u32.8) :cost 1)
   (u32.8-unpackhi    #:vpunpckhdq   (u32.8) (u32.8 u32.8) :cost 1)
   (u32.8-unpacklo    #:vpunpckldq   (u32.8) (u32.8 u32.8) :cost 1)
   (u32.8-broadcast   #:vpbroadcastd (u32.8) (u32.4)       :cost 1)
   ;; u64.4
   (two-arg-u64.4+    #:vpaddq       (u64.4) (u64.4 u64.4) :cost 1 :commutative t)
   (two-arg-u64.4-    #:vpsubq       (u64.4) (u64.4 u64.4) :cost 1)
   (two-arg-u64.4=    #:vpcmpeqq     (u64.4) (u64.4 u64.4) :cost 1 :commutative t)
   (two-arg-u64.4/=   #:vpcmpeqq     (u64.4) (u64.4 u64.4) :cost 2 :commutative t :encoding :none)
   (two-arg-u64.4>    #:vpcmpgtq     (u64.4) (u64.4 u64.4) :cost 1)
   (two-arg-u64.4<    #:vpcmpgtq     (u64.4) (u64.4 u64.4) :cost 1 :encoding :none)
   (two-arg-u64.4>=   #:vpcmpgtq     (u64.4) (u64.4 u64.4) :cost 2 :encoding :none)
   (two-arg-u64.4<=   #:vpcmpgtq     (u64.4) (u64.4 u64.4) :cost 2 :encoding :none)
   (u64.4-shiftl      #:vpsllvq      (u64.4) (u64.4 u64.4) :cost 1)
   (u64.4-shiftr      #:vpsrlvq      (u64.4) (u64.4 u64.4) :cost 1)
   (u64.4-unpackhi    #:vpunpckhqdq  (u64.4) (u64.4 u64.4) :cost 1)
   (u64.4-unpacklo    #:vpunpcklqdq  (u64.4) (u64.4 u64.4) :cost 1)
   (u64.4-broadcast   #:vpbroadcastq (u64.4) (u64.2)       :cost 1)
   ;; s8.32
   (two-arg-s8.32+    #:vpaddb       (s8.32) (s8.32 s8.32) :cost 2 :commutative t)
   (two-arg-s8.32-    #:vpsubb       (s8.32) (s8.32 s8.32) :cost 2)
   (s8.32-unpackhi    #:vpunpckhbw   (s8.32) (s8.32 s8.32) :cost 1)
   (s8.32-unpacklo    #:vpunpcklbw   (s8.32) (s8.32 s8.32) :cost 1)
   (s8.32-broadcast   #:vpbroadcastw (s8.32) (s8.32)       :cost 1)
   ;; s16.16
   (two-arg-s16.16+   #:vpaddw       (s16.16) (s16.16 s16.16) :cost 2 :commutative t)
   (two-arg-s16.16-   #:vpsubw       (s16.16) (s16.16 s16.16) :cost 2)
   (s16.16-unpackhi   #:vpunpckhbw   (s16.16) (s16.16 s16.16) :cost 1)
   (s16.16-unpacklo   #:vpunpcklbw   (s16.16) (s16.16 s16.16) :cost 1)
   (s16.16-broadcast  #:vpbroadcastw (s16.16) (s16.16)     :cost 1)
   ;; s32.8
   (two-arg-s32.8+    #:vpaddd       (s32.8) (s32.8 s32.8) :cost 2 :commutative t)
   (two-arg-s32.8-    #:vpsubd       (s32.8) (s32.8 s32.8) :cost 2)
   (s32.8-mullo       #:vpmulld      (s32.8) (s32.8 s32.8) :cost 2)
   ;; s64.4
   (two-arg-s64.4+    #:vpaddq       (s64.4) (s64.4 s64.4) :cost 1 :commutative t)
   (two-arg-s64.4-    #:vpsubq       (s64.4) (s64.4 s64.4) :cost 1)
   (two-arg-s64.4=    #:vpcmpeqq     (s64.4) (s64.4 s64.4) :cost 1 :commutative t)
   (s64.4-shiftl      #:vpsllq       (s64.4) (s64.4 s64.4) :cost 1)
   (s64.4-shiftr      #:vpsrlq       (s64.4) (s64.4 s64.4) :cost 1)
   (s64.4-unpackhi    #:vpunpckhqdq  (s64.4) (s64.4 s64.2) :cost 1)
   (s64.4-unpacklo    #:vpunpcklqdq  (s64.4) (s64.4 s64.4) :cost 1)
   (s64.4-broadcast   #:vpbroadcastq (s64.4) (s64.2)       :cost 1))
  (:load
   (f32.4-ntload #:vmovntdqa f32.4 f32vec f32.4-non-temporal-aref f32.4-non-temporal-row-major-aref)
   (f64.2-ntload #:vmovntdqa f64.2 f64vec f64.2-non-temporal-aref f64.2-non-temporal-row-major-aref)
   (f32.8-ntload #:vmovntdqa f32.8 f32vec f32.8-non-temporal-aref f32.8-non-temporal-row-major-aref)
   (f64.4-ntload #:vmovntdqa f64.4 f64vec f64.4-non-temporal-aref f64.4-non-temporal-row-major-aref)
   
   ;(u8.16-ntload #:vmovntdqa u8.16 u8vec  u8.16-non-temporal-aref u8.16-non-temporal-row-major-aref)
   (u16.8-ntload #:vmovntdqa u16.8 u16vec u16.8-non-temporal-aref u16.8-non-temporal-row-major-aref)
   (u32.4-ntload #:vmovntdqa u32.4 u32vec u32.4-non-temporal-aref u32.4-non-temporal-row-major-aref)
   (u64.2-ntload #:vmovntdqa u64.2 u64vec u64.2-non-temporal-aref u64.2-non-temporal-row-major-aref)
   ;(s8.16-ntload #:vmovntdqa s8.16 s8vec  s8.16-non-temporal-aref s8.16-non-temporal-row-major-aref)
   (s16.8-ntload #:vmovntdqa s16.2 s16vec s16.8-non-temporal-aref s16.8-non-temporal-row-major-aref)
   (s32.4-ntload #:vmovntdqa s32.4 s32vec s32.4-non-temporal-aref s32.4-non-temporal-row-major-aref)
   (s64.2-ntload #:vmovntdqa s64.2 s64vec s64.2-non-temporal-aref s64.2-non-temporal-row-major-aref)

   (u8.32-ntload  #:vmovntdqa u8.32  u8vec  u8.32-non-temporal-aref  u8.32-non-temporal-row-major-aref)
   (u16.16-ntload #:vmovntdqa u16.16 u16vec u16.16-non-temporal-aref u16.16-non-temporal-row-major-aref)
   (u32.8-ntload  #:vmovntdqa u32.8  u32vec u32.8-non-temporal-aref  u32.8-non-temporal-row-major-aref)
   (u64.4-ntload  #:vmovntdqa u64.4  u64vec u64.4-non-temporal-aref  u64.4-non-temporal-row-major-aref)
   (s8.32-ntload  #:vmovntdqa s8.32  s8vec  s8.32-non-temporal-aref  s8.32-non-temporal-row-major-aref)
   (s16.16-ntload #:vmovntdqa s16.16 s16vec s16.16-non-temporal-aref s16.16-non-temporal-row-major-aref)
   (s32.8-ntload  #:vmovntdqa s32.8  s32vec s32.8-non-temporal-aref  s32.8-non-temporal-row-major-aref)
   (s64.4-ntload  #:vmovntdqa s64.4  s64vec s64.4-non-temporal-aref  s64.4-non-temporal-row-major-aref)))
