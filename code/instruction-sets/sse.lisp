(in-package #:sb-simd-sse)

(define-instruction-set :sse
  (:test #+x86-64 t #-x86-64 nil)
  (:include :x86-64)
  (:scalars
   (f32 32 single-float #:single-float (#:single-reg)))
  (:simd-packs
   (p128   nil 128 #:simd-pack (#:int-sse-reg #:double-sse-reg #:single-sse-reg))
   (f32.4  f32 128 #:simd-pack-single (#:single-sse-reg)))
  (:instructions
   ;; f32
   (f32!-from-p128    nil     (f32) (p128)    :cost 1 :encoding :custom :always-translatable nil)
   (two-arg-f32-and #:andps   (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32-or  #:orps    (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32-xor #:xorps   (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32-max #:maxss   (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32-min #:minss   (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32+    #:addss   (f32) (f32 f32) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32-    #:subss   (f32) (f32 f32) :cost 2 :encoding :sse)
   (two-arg-f32*    #:mulss   (f32) (f32 f32) :cost 2 :encoding :sse :commutative t)
   (two-arg-f32/    #:divss   (f32) (f32 f32) :cost 8 :encoding :sse)
   (two-arg-f32=    #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:eq) :commutative t)
   (two-arg-f32/=   #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:neq) :commutative t)
   (two-arg-f32<    #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:lt))
   (two-arg-f32<=   #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:le))
   (two-arg-f32>    #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:nle))
   (two-arg-f32>=   #:cmpss   (u32) (f32 f32) :cost 4 :encoding :custom :prefix '(:nlt))
   (f32-andc1       #:andnps  (f32) (f32 f32) :cost 1 :encoding :sse)
   (f32-not         nil       (f32) (f32)     :cost 1 :encoding :none)
   (f32-reciprocal  #:rcpss   (f32) (f32)     :cost 5)
   (f32-rsqrt       #:rsqrtss (f32) (f32)     :cost 5)
   (f32-sqrt        #:sqrtss  (f32) (f32)     :cost 15)
   ;; f32.4
   (f32.4!-from-f32   #:movups   (f32.4) (f32)         :cost 1 :encoding :move)
   (make-f32.4        nil        (f32.4) (f32 f32 f32 f32) :cost 1 :encoding :none)
   (f32.4-values      nil        (f32 f32 f32 f32) (f32.4) :cost 1 :encoding :none)
   (f32.4-broadcast   nil        (f32.4) (f32)         :cost 1 :encoding :none)
   (two-arg-f32.4-and #:andps    (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-or  #:orps     (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-xor #:xorps    (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse :commutative t)
   (two-arg-f32.4-max #:maxps    (f32.4) (f32.4 f32.4) :cost 3 :encoding :sse :commutative t)
   (two-arg-f32.4-min #:minps    (f32.4) (f32.4 f32.4) :cost 3 :encoding :sse :commutative t)
   (two-arg-f32.4+    #:addps    (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse :commutative t)
   (two-arg-f32.4-    #:subps    (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse)
   (two-arg-f32.4*    #:mulps    (f32.4) (f32.4 f32.4) :cost 2 :encoding :sse :commutative t)
   (two-arg-f32.4/    #:divps    (f32.4) (f32.4 f32.4) :cost 8 :encoding :sse)
   (f32.4-andc1       #:andnps   (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse)
   (f32.4-not         nil        (f32.4) (f32.4)       :cost 1 :encoding :none)
   (f32.4-reciprocal  #:rcpps    (f32.4) (f32.4)       :cost 5)
   (f32.4-rsqrt       #:rsqrtps  (f32.4) (f32.4)       :cost 5)
   (f32.4-sqrt        #:sqrtps   (f32.4) (f32.4)       :cost 15)
   (f32.4-shuffle     #:shufps   (f32.4) (f32.4 f32.4 sb-simd-x86-64::imm8) :cost 1 :encoding :sse)
   (f32.4-unpacklo    #:unpcklps (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse)
   (f32.4-unpackhi    #:unpckhps (f32.4) (f32.4 f32.4) :cost 1 :encoding :sse)
   (f32.4-movemask    #:movmskps (u4)    (f32.4)       :cost 1))
  (:loads
   (f32.4-load        #:movups  f32.4 f32vec f32.4-aref f32.4-row-major-aref))
  (:stores
   (f32.4-store       #:movups  f32.4 f32vec f32.4-aref f32.4-row-major-aref)
   (f32.4-ntstore     #:movntps f32.4 f32vec f32.4-non-temporal-aref f32.4-non-temporal-row-major-aref))
  (:commutatives
   (f32-and two-arg-f32-and +f32-true+)
   (f32-or  two-arg-f32-or  +f32-false+)
   (f32-xor two-arg-f32-xor +f32-false+)
   (f32-max two-arg-f32-max nil)
   (f32-min two-arg-f32-min nil)
   (f32+    two-arg-f32+ 0f0)
   (f32*    two-arg-f32* 1f0)
   (f32.4-and two-arg-f32.4-and +f32-true+)
   (f32.4-or  two-arg-f32.4-or  +f32-false+)
   (f32.4-xor two-arg-f32.4-xor +f32-false+)
   (f32.4-max two-arg-f32.4-max nil)
   (f32.4-min two-arg-f32.4-min nil)
   (f32.4+    two-arg-f32.4+ 0f0)
   (f32.4*    two-arg-f32.4* 1f0))
  (:comparisons
   (f32=  two-arg-f32=  u32-and +u32-true+)
   (f32<  two-arg-f32<  u32-and +u32-true+)
   (f32<= two-arg-f32<= u32-and +u32-true+)
   (f32>  two-arg-f32>  u32-and +u32-true+)
   (f32>= two-arg-f32>= u32-and +u32-true+))
  (:reducers
   (f32- two-arg-f32- 0f0)
   (f32/ two-arg-f32/ 1f0)
   (f32.4- two-arg-f32.4- 0f0)
   (f32.4/ two-arg-f32.4/ 1f0))
  (:unequals
   (f32/= two-arg-f32/= u32-and +u32-true+)))

