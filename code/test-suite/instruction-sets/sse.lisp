(in-package #:sb-simd-sse)

(sb-simd-test-suite:define-simple-simd-test f32.4-and (f32.4) (&rest f32.4) f32-and)
(sb-simd-test-suite:define-simple-simd-test f32.4-or (f32.4) (&rest f32.4) f32-or)
(sb-simd-test-suite:define-simple-simd-test f32.4-xor (f32.4) (&rest f32.4) f32-xor)
(sb-simd-test-suite:define-simple-simd-test f32.4-andc1 (f32.4) (f32.4 f32.4) f32-andc1)
(sb-simd-test-suite:define-simple-simd-test f32.4-not (f32.4) (f32.4) f32-not)
(sb-simd-test-suite:define-simple-simd-test f32.4-max (f32.4) (f32.4 &rest f32.4) f32-max)
(sb-simd-test-suite:define-simple-simd-test f32.4-min (f32.4) (f32.4 &rest f32.4) f32-min)
(sb-simd-test-suite:define-simple-simd-test f32.4+ (f32.4) (&rest f32.4) f32+)
(sb-simd-test-suite:define-simple-simd-test f32.4- (f32.4) (f32.4 &rest f32.4) f32-)
(sb-simd-test-suite:define-simple-simd-test f32.4* (f32.4) (&rest f32.4) f32*)
(sb-simd-test-suite:define-simple-simd-test f32.4/ (f32.4) (f32.4 &rest f32.4) f32/)
