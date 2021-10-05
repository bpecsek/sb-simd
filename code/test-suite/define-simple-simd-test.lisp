(in-package #:sb-simd-test-suite)

(defmacro define-simple-simd-test (simd-foo result-types argtypes foo)
  `(define-test ,simd-foo
     ,@(loop for argtype-variant in (argtypes-variants argtypes)
             collect `(test-simple-simd-function ,simd-foo ,result-types ,argtype-variant ,foo))))

(defmacro test-simple-simd-function (simd-foo result-types simplified-argtypes foo)
  (let* ((result-infos (mapcar #'simd-info result-types))
         (argument-infos (mapcar #'simd-info simplified-argtypes))
         (argument-symbols (prefixed-symbols "ARGUMENT-" (length argument-infos)))
         (result-symbols (prefixed-symbols "RESULT-" (length result-infos)))
         (output-symbols (prefixed-symbols "OUTPUT-" (length result-infos)))
         (simd-width (the integer (second (first result-infos)))))
    (assert (apply #'= (append (mapcar #'second result-infos) (mapcar #'second argument-infos))))
    `(loop repeat ,(min (expt 99 (length argument-infos)) 10000) do
      (multiple-value-bind (inputs outputs)
          (find-valid-simd-call
           (lambda ,argument-symbols
             (declare ,@(loop for argument-symbol in argument-symbols
                              for argument-type in (mapcar #'first argument-infos)
                              collect `(type ,argument-type ,argument-symbol)))
             (,foo ,@argument-symbols))
           ',(mapcar #'find-generator (mapcar #'first argument-infos))
           ,simd-width
           ',(mapcar #'third argument-infos)
           ',(mapcar #'third result-infos))
        (destructuring-bind ,argument-symbols inputs
          (destructuring-bind ,output-symbols outputs
            (multiple-value-bind ,result-symbols (,simd-foo ,@argument-symbols)
              ,@(loop for result-type in result-types
                      for result-symbol in result-symbols
                      for output-symbol in output-symbols
                      collect
                      `(is (simd= ,result-symbol ,output-symbol))))))))))

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

(in-package #:sb-simd-sse2)

(sb-simd-test-suite:define-simple-simd-test f32.4= (u32.4) (f32.4 &rest f32.4) f32=)
(sb-simd-test-suite:define-simple-simd-test f32.4/= (u32.4) (f32.4 &rest f32.4) f32/=)
(sb-simd-test-suite:define-simple-simd-test f32.4< (u32.4) (f32.4 &rest f32.4) f32<)
(sb-simd-test-suite:define-simple-simd-test f32.4<= (u32.4) (f32.4 &rest f32.4) f32<=)
(sb-simd-test-suite:define-simple-simd-test f32.4> (u32.4) (f32.4 &rest f32.4) f32>)
(sb-simd-test-suite:define-simple-simd-test f32.4>= (u32.4) (f32.4 &rest f32.4) f32>=)

(sb-simd-test-suite:define-simple-simd-test f64.2-and (f64.2) (&rest f64.2) f64-and)
(sb-simd-test-suite:define-simple-simd-test f64.2-or (f64.2) (&rest f64.2) f64-or)
(sb-simd-test-suite:define-simple-simd-test f64.2-xor (f64.2) (&rest f64.2) f64-xor)
(sb-simd-test-suite:define-simple-simd-test f64.2-andc1 (f64.2) (f64.2 f64.2) f64-andc1)
(sb-simd-test-suite:define-simple-simd-test f64.2-not (f64.2) (f64.2) f64-not)
(sb-simd-test-suite:define-simple-simd-test f64.2-max (f64.2) (f64.2 &rest f64.2) f64-max)
(sb-simd-test-suite:define-simple-simd-test f64.2-min (f64.2) (f64.2 &rest f64.2) f64-min)
(sb-simd-test-suite:define-simple-simd-test f64.2+ (f64.2) (&rest f64.2) f64+)
(sb-simd-test-suite:define-simple-simd-test f64.2- (f64.2) (f64.2 &rest f64.2) f64-)
(sb-simd-test-suite:define-simple-simd-test f64.2* (f64.2) (&rest f64.2) f64*)
(sb-simd-test-suite:define-simple-simd-test f64.2/ (f64.2) (f64.2 &rest f64.2) f64/)
(sb-simd-test-suite:define-simple-simd-test f64.2= (u64.2) (f64.2 &rest f64.2) f64=)
(sb-simd-test-suite:define-simple-simd-test f64.2/= (u64.2) (f64.2 &rest f64.2) f64/=)
(sb-simd-test-suite:define-simple-simd-test f64.2< (u64.2) (f64.2 &rest f64.2) f64<)
(sb-simd-test-suite:define-simple-simd-test f64.2<= (u64.2) (f64.2 &rest f64.2) f64<=)
(sb-simd-test-suite:define-simple-simd-test f64.2> (u64.2) (f64.2 &rest f64.2) f64>)
(sb-simd-test-suite:define-simple-simd-test f64.2>= (u64.2) (f64.2 &rest f64.2) f64>=)

(sb-simd-test-suite:define-simple-simd-test u8.16-and (u8.16) (&rest u8.16) u8-and)
(sb-simd-test-suite:define-simple-simd-test u8.16-or (u8.16) (&rest u8.16) u8-or)
(sb-simd-test-suite:define-simple-simd-test u8.16-xor (u8.16) (&rest u8.16) u8-xor)
(sb-simd-test-suite:define-simple-simd-test u8.16-andc1 (u8.16) (u8.16 u8.16) u8-andc1)
(sb-simd-test-suite:define-simple-simd-test u8.16-not (u8.16) (u8.16) u8-not)
(sb-simd-test-suite:define-simple-simd-test u8.16+ (u8.16) (&rest u8.16) u8+)
(sb-simd-test-suite:define-simple-simd-test u8.16- (u8.16) (u8.16 &rest u8.16) u8-)
(sb-simd-test-suite:define-simple-simd-test u8.16= (u8.16) (u8.16 &rest u8.16) u8=)
(sb-simd-test-suite:define-simple-simd-test u8.16/= (u8.16) (u8.16 &rest u8.16) u8/=)
(sb-simd-test-suite:define-simple-simd-test u8.16< (u8.16) (u8.16 &rest u8.16) u8<)
(sb-simd-test-suite:define-simple-simd-test u8.16<= (u8.16) (u8.16 &rest u8.16) u8<=)
(sb-simd-test-suite:define-simple-simd-test u8.16> (u8.16) (u8.16 &rest u8.16) u8>)
(sb-simd-test-suite:define-simple-simd-test u8.16>= (u8.16) (u8.16 &rest u8.16) u8>=)

(sb-simd-test-suite:define-simple-simd-test u16.8-and (u16.8) (&rest u16.8) u16-and)
(sb-simd-test-suite:define-simple-simd-test u16.8-or (u16.8) (&rest u16.8) u16-or)
(sb-simd-test-suite:define-simple-simd-test u16.8-xor (u16.8) (&rest u16.8) u16-xor)
(sb-simd-test-suite:define-simple-simd-test u16.8-andc1 (u16.8) (u16.8 u16.8) u16-andc1)
(sb-simd-test-suite:define-simple-simd-test u16.8-not (u16.8) (u16.8) u16-not)
(sb-simd-test-suite:define-simple-simd-test u16.8+ (u16.8) (&rest u16.8) u16+)
(sb-simd-test-suite:define-simple-simd-test u16.8- (u16.8) (u16.8 &rest u16.8) u16-)
(sb-simd-test-suite:define-simple-simd-test u16.8= (u16.8) (u16.8 &rest u16.8) u16=)
(sb-simd-test-suite:define-simple-simd-test u16.8/= (u16.8) (u16.8 &rest u16.8) u16/=)
(sb-simd-test-suite:define-simple-simd-test u16.8< (u16.8) (u16.8 &rest u16.8) u16<)
(sb-simd-test-suite:define-simple-simd-test u16.8<= (u16.8) (u16.8 &rest u16.8) u16<=)
(sb-simd-test-suite:define-simple-simd-test u16.8> (u16.8) (u16.8 &rest u16.8) u16>)
(sb-simd-test-suite:define-simple-simd-test u16.8>= (u16.8) (u16.8 &rest u16.8) u16>=)

(sb-simd-test-suite:define-simple-simd-test u32.4-and (u32.4) (&rest u32.4) u32-and)
(sb-simd-test-suite:define-simple-simd-test u32.4-or (u32.4) (&rest u32.4) u32-or)
(sb-simd-test-suite:define-simple-simd-test u32.4-xor (u32.4) (&rest u32.4) u32-xor)
(sb-simd-test-suite:define-simple-simd-test u32.4-andc1 (u32.4) (u32.4 u32.4) u32-andc1)
(sb-simd-test-suite:define-simple-simd-test u32.4-not (u32.4) (u32.4) u32-not)
(sb-simd-test-suite:define-simple-simd-test u32.4+ (u32.4) (&rest u32.4) u32+)
(sb-simd-test-suite:define-simple-simd-test u32.4- (u32.4) (u32.4 &rest u32.4) u32-)
(sb-simd-test-suite:define-simple-simd-test u32.4= (u32.4) (u32.4 &rest u32.4) u32=)
(sb-simd-test-suite:define-simple-simd-test u32.4/= (u32.4) (u32.4 &rest u32.4) u32/=)
(sb-simd-test-suite:define-simple-simd-test u32.4< (u32.4) (u32.4 &rest u32.4) u32<)
(sb-simd-test-suite:define-simple-simd-test u32.4<= (u32.4) (u32.4 &rest u32.4) u32<=)
(sb-simd-test-suite:define-simple-simd-test u32.4> (u32.4) (u32.4 &rest u32.4) u32>)
(sb-simd-test-suite:define-simple-simd-test u32.4>= (u32.4) (u32.4 &rest u32.4) u32>=)

(sb-simd-test-suite:define-simple-simd-test u64.2-and (u64.2) (&rest u64.2) u64-and)
(sb-simd-test-suite:define-simple-simd-test u64.2-or (u64.2) (&rest u64.2) u64-or)
(sb-simd-test-suite:define-simple-simd-test u64.2-xor (u64.2) (&rest u64.2) u64-xor)
(sb-simd-test-suite:define-simple-simd-test u64.2-andc1 (u64.2) (u64.2 u64.2) u64-andc1)
(sb-simd-test-suite:define-simple-simd-test u64.2-not (u64.2) (u64.2) u64-not)
(sb-simd-test-suite:define-simple-simd-test u64.2+ (u64.2) (&rest u64.2) u64+)
(sb-simd-test-suite:define-simple-simd-test u64.2- (u64.2) (u64.2 &rest u64.2) u64-)

(sb-simd-test-suite:define-simple-simd-test s8.16-and (s8.16) (&rest s8.16) s8-and)
(sb-simd-test-suite:define-simple-simd-test s8.16-or (s8.16) (&rest s8.16) s8-or)
(sb-simd-test-suite:define-simple-simd-test s8.16-xor (s8.16) (&rest s8.16) s8-xor)
(sb-simd-test-suite:define-simple-simd-test s8.16-andc1 (s8.16) (s8.16 s8.16) s8-andc1)
(sb-simd-test-suite:define-simple-simd-test s8.16-not (s8.16) (s8.16) s8-not)
(sb-simd-test-suite:define-simple-simd-test s8.16+ (s8.16) (&rest s8.16) s8+)
(sb-simd-test-suite:define-simple-simd-test s8.16- (s8.16) (s8.16 &rest s8.16) s8-)
(sb-simd-test-suite:define-simple-simd-test s8.16= (u8.16) (s8.16 &rest s8.16) s8=)
(sb-simd-test-suite:define-simple-simd-test s8.16/= (u8.16) (s8.16 &rest s8.16) s8/=)
(sb-simd-test-suite:define-simple-simd-test s8.16< (u8.16) (s8.16 &rest s8.16) s8<)
(sb-simd-test-suite:define-simple-simd-test s8.16<= (u8.16) (s8.16 &rest s8.16) s8<=)
(sb-simd-test-suite:define-simple-simd-test s8.16> (u8.16) (s8.16 &rest s8.16) s8>)
(sb-simd-test-suite:define-simple-simd-test s8.16>= (u8.16) (s8.16 &rest s8.16) s8>=)

(sb-simd-test-suite:define-simple-simd-test s16.8-and (s16.8) (&rest s16.8) s16-and)
(sb-simd-test-suite:define-simple-simd-test s16.8-or (s16.8) (&rest s16.8) s16-or)
(sb-simd-test-suite:define-simple-simd-test s16.8-xor (s16.8) (&rest s16.8) s16-xor)
(sb-simd-test-suite:define-simple-simd-test s16.8-andc1 (s16.8) (s16.8 s16.8) s16-andc1)
(sb-simd-test-suite:define-simple-simd-test s16.8-not (s16.8) (s16.8) s16-not)
(sb-simd-test-suite:define-simple-simd-test s16.8+ (s16.8) (&rest s16.8) s16+)
(sb-simd-test-suite:define-simple-simd-test s16.8- (s16.8) (s16.8 &rest s16.8) s16-)
(sb-simd-test-suite:define-simple-simd-test s16.8= (u16.8) (s16.8 &rest s16.8) s16=)
(sb-simd-test-suite:define-simple-simd-test s16.8/= (u16.8) (s16.8 &rest s16.8) s16/=)
(sb-simd-test-suite:define-simple-simd-test s16.8< (u16.8) (s16.8 &rest s16.8) s16<)
(sb-simd-test-suite:define-simple-simd-test s16.8<= (u16.8) (s16.8 &rest s16.8) s16<=)
(sb-simd-test-suite:define-simple-simd-test s16.8> (u16.8) (s16.8 &rest s16.8) s16>)
(sb-simd-test-suite:define-simple-simd-test s16.8>= (u16.8) (s16.8 &rest s16.8) s16>=)

(sb-simd-test-suite:define-simple-simd-test s32.4-and (s32.4) (&rest s32.4) s32-and)
(sb-simd-test-suite:define-simple-simd-test s32.4-or (s32.4) (&rest s32.4) s32-or)
(sb-simd-test-suite:define-simple-simd-test s32.4-xor (s32.4) (&rest s32.4) s32-xor)
(sb-simd-test-suite:define-simple-simd-test s32.4-andc1 (s32.4) (s32.4 s32.4) s32-andc1)
(sb-simd-test-suite:define-simple-simd-test s32.4-not (s32.4) (s32.4) s32-not)
(sb-simd-test-suite:define-simple-simd-test s32.4+ (s32.4) (&rest s32.4) s32+)
(sb-simd-test-suite:define-simple-simd-test s32.4- (s32.4) (s32.4 &rest s32.4) s32-)
(sb-simd-test-suite:define-simple-simd-test s32.4= (u32.4) (s32.4 &rest s32.4) s32=)
(sb-simd-test-suite:define-simple-simd-test s32.4/= (u32.4) (s32.4 &rest s32.4) s32/=)
(sb-simd-test-suite:define-simple-simd-test s32.4< (u32.4) (s32.4 &rest s32.4) s32<)
(sb-simd-test-suite:define-simple-simd-test s32.4<= (u32.4) (s32.4 &rest s32.4) s32<=)
(sb-simd-test-suite:define-simple-simd-test s32.4> (u32.4) (s32.4 &rest s32.4) s32>)
(sb-simd-test-suite:define-simple-simd-test s32.4>= (u32.4) (s32.4 &rest s32.4) s32>=)

(sb-simd-test-suite:define-simple-simd-test s64.2-and (s64.2) (&rest s64.2) s64-and)
(sb-simd-test-suite:define-simple-simd-test s64.2-or (s64.2) (&rest s64.2) s64-or)
(sb-simd-test-suite:define-simple-simd-test s64.2-xor (s64.2) (&rest s64.2) s64-xor)
(sb-simd-test-suite:define-simple-simd-test s64.2-andc1 (s64.2) (s64.2 s64.2) s64-andc1)
(sb-simd-test-suite:define-simple-simd-test s64.2-not (s64.2) (s64.2) s64-not)
(sb-simd-test-suite:define-simple-simd-test s64.2+ (s64.2) (&rest s64.2) s64+)
(sb-simd-test-suite:define-simple-simd-test s64.2- (s64.2) (s64.2 &rest s64.2) s64-)

(in-package #:sb-simd-sse4.1)

(sb-simd-test-suite:define-simple-simd-test f32.4-if (f32.4) (u32.4 f32.4 f32.4) f32-if)
(sb-simd-test-suite:define-simple-simd-test f64.2-if (f64.2) (u64.2 f64.2 f64.2) f64-if)
(sb-simd-test-suite:define-simple-simd-test u8.16-if (u8.16) (u8.16 u8.16 u8.16) u8-if)
(sb-simd-test-suite:define-simple-simd-test u16.8-if (u16.8) (u16.8 u16.8 u16.8) u16-if)
(sb-simd-test-suite:define-simple-simd-test u32.4-if (u32.4) (u32.4 u32.4 u32.4) u32-if)
(sb-simd-test-suite:define-simple-simd-test u64.2-if (u64.2) (u64.2 u64.2 u64.2) u64-if)
(sb-simd-test-suite:define-simple-simd-test s8.16-if (s8.16) (u8.16 s8.16 s8.16) s8-if)
(sb-simd-test-suite:define-simple-simd-test s16.8-if (s16.8) (u16.8 s16.8 s16.8) s16-if)
(sb-simd-test-suite:define-simple-simd-test s32.4-if (s32.4) (u32.4 s32.4 s32.4) s32-if)
(sb-simd-test-suite:define-simple-simd-test s64.2-if (s64.2) (u64.2 s64.2 s64.2) s64-if)

(sb-simd-test-suite:define-simple-simd-test u64.2= (u64.2) (u64.2 &rest u64.2) u64=)
(sb-simd-test-suite:define-simple-simd-test u64.2/= (u64.2) (u64.2 &rest u64.2) u64/=)

(sb-simd-test-suite:define-simple-simd-test s64.2= (u64.2) (s64.2 &rest s64.2) s64=)
(sb-simd-test-suite:define-simple-simd-test s64.2/= (u64.2) (s64.2 &rest s64.2) s64/=)

(in-package #:sb-simd-sse4.2)

(sb-simd-test-suite:define-simple-simd-test u64.2< (u64.2) (u64.2 &rest u64.2) u64<)
(sb-simd-test-suite:define-simple-simd-test u64.2<= (u64.2) (u64.2 &rest u64.2) u64<=)
(sb-simd-test-suite:define-simple-simd-test u64.2> (u64.2) (u64.2 &rest u64.2) u64>)
(sb-simd-test-suite:define-simple-simd-test u64.2>= (u64.2) (u64.2 &rest u64.2) u64>=)

(sb-simd-test-suite:define-simple-simd-test s64.2< (u64.2) (s64.2 &rest s64.2) s64<)
(sb-simd-test-suite:define-simple-simd-test s64.2<= (u64.2) (s64.2 &rest s64.2) s64<=)
(sb-simd-test-suite:define-simple-simd-test s64.2> (u64.2) (s64.2 &rest s64.2) s64>)
(sb-simd-test-suite:define-simple-simd-test s64.2>= (u64.2) (s64.2 &rest s64.2) s64>=)

(in-package #:sb-simd-avx)

(sb-simd-test-suite:define-simple-simd-test f32.4-if (f32.4) (u32.4 f32.4 f32.4) f32-if)
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
(sb-simd-test-suite:define-simple-simd-test f32.4= (u32.4) (f32.4 &rest f32.4) f32=)
(sb-simd-test-suite:define-simple-simd-test f32.4/= (u32.4) (f32.4 &rest f32.4) f32/=)
(sb-simd-test-suite:define-simple-simd-test f32.4< (u32.4) (f32.4 &rest f32.4) f32<)
(sb-simd-test-suite:define-simple-simd-test f32.4<= (u32.4) (f32.4 &rest f32.4) f32<=)
(sb-simd-test-suite:define-simple-simd-test f32.4> (u32.4) (f32.4 &rest f32.4) f32>)
(sb-simd-test-suite:define-simple-simd-test f32.4>= (u32.4) (f32.4 &rest f32.4) f32>=)

(sb-simd-test-suite:define-simple-simd-test f32.8-if (f32.8) (u32.8 f32.8 f32.8) f32-if)
(sb-simd-test-suite:define-simple-simd-test f32.8-and (f32.8) (&rest f32.8) f32-and)
(sb-simd-test-suite:define-simple-simd-test f32.8-or (f32.8) (&rest f32.8) f32-or)
(sb-simd-test-suite:define-simple-simd-test f32.8-xor (f32.8) (&rest f32.8) f32-xor)
(sb-simd-test-suite:define-simple-simd-test f32.8-andc1 (f32.8) (f32.8 f32.8) f32-andc1)
(sb-simd-test-suite:define-simple-simd-test f32.8-not (f32.8) (f32.8) f32-not)
(sb-simd-test-suite:define-simple-simd-test f32.8-max (f32.8) (f32.8 &rest f32.8) f32-max)
(sb-simd-test-suite:define-simple-simd-test f32.8-min (f32.8) (f32.8 &rest f32.8) f32-min)
(sb-simd-test-suite:define-simple-simd-test f32.8+ (f32.8) (&rest f32.8) f32+)
(sb-simd-test-suite:define-simple-simd-test f32.8- (f32.8) (f32.8 &rest f32.8) f32-)
(sb-simd-test-suite:define-simple-simd-test f32.8* (f32.8) (&rest f32.8) f32*)
(sb-simd-test-suite:define-simple-simd-test f32.8/ (f32.8) (f32.8 &rest f32.8) f32/)
(sb-simd-test-suite:define-simple-simd-test f32.8= (u32.8) (f32.8 &rest f32.8) f32=)
(sb-simd-test-suite:define-simple-simd-test f32.8/= (u32.8) (f32.8 &rest f32.8) f32/=)
(sb-simd-test-suite:define-simple-simd-test f32.8< (u32.8) (f32.8 &rest f32.8) f32<)
(sb-simd-test-suite:define-simple-simd-test f32.8<= (u32.8) (f32.8 &rest f32.8) f32<=)
(sb-simd-test-suite:define-simple-simd-test f32.8> (u32.8) (f32.8 &rest f32.8) f32>)
(sb-simd-test-suite:define-simple-simd-test f32.8>= (u32.8) (f32.8 &rest f32.8) f32>=)

(sb-simd-test-suite:define-simple-simd-test f64.2-if (f64.2) (u64.2 f64.2 f64.2) f64-if)
(sb-simd-test-suite:define-simple-simd-test f64.2-and (f64.2) (&rest f64.2) f64-and)
(sb-simd-test-suite:define-simple-simd-test f64.2-or (f64.2) (&rest f64.2) f64-or)
(sb-simd-test-suite:define-simple-simd-test f64.2-xor (f64.2) (&rest f64.2) f64-xor)
(sb-simd-test-suite:define-simple-simd-test f64.2-andc1 (f64.2) (f64.2 f64.2) f64-andc1)
(sb-simd-test-suite:define-simple-simd-test f64.2-not (f64.2) (f64.2) f64-not)
(sb-simd-test-suite:define-simple-simd-test f64.2-max (f64.2) (f64.2 &rest f64.2) f64-max)
(sb-simd-test-suite:define-simple-simd-test f64.2-min (f64.2) (f64.2 &rest f64.2) f64-min)
(sb-simd-test-suite:define-simple-simd-test f64.2+ (f64.2) (&rest f64.2) f64+)
(sb-simd-test-suite:define-simple-simd-test f64.2- (f64.2) (f64.2 &rest f64.2) f64-)
(sb-simd-test-suite:define-simple-simd-test f64.2* (f64.2) (&rest f64.2) f64*)
(sb-simd-test-suite:define-simple-simd-test f64.2/ (f64.2) (f64.2 &rest f64.2) f64/)
(sb-simd-test-suite:define-simple-simd-test f64.2= (u64.2) (f64.2 &rest f64.2) f64=)
(sb-simd-test-suite:define-simple-simd-test f64.2/= (u64.2) (f64.2 &rest f64.2) f64/=)
(sb-simd-test-suite:define-simple-simd-test f64.2< (u64.2) (f64.2 &rest f64.2) f64<)
(sb-simd-test-suite:define-simple-simd-test f64.2<= (u64.2) (f64.2 &rest f64.2) f64<=)
(sb-simd-test-suite:define-simple-simd-test f64.2> (u64.2) (f64.2 &rest f64.2) f64>)
(sb-simd-test-suite:define-simple-simd-test f64.2>= (u64.2) (f64.2 &rest f64.2) f64>=)

(sb-simd-test-suite:define-simple-simd-test f64.4-if (f64.4) (u64.4 f64.4 f64.4) f64-if)
(sb-simd-test-suite:define-simple-simd-test f64.4-and (f64.4) (&rest f64.4) f64-and)
(sb-simd-test-suite:define-simple-simd-test f64.4-or (f64.4) (&rest f64.4) f64-or)
(sb-simd-test-suite:define-simple-simd-test f64.4-xor (f64.4) (&rest f64.4) f64-xor)
(sb-simd-test-suite:define-simple-simd-test f64.4-andc1 (f64.4) (f64.4 f64.4) f64-andc1)
(sb-simd-test-suite:define-simple-simd-test f64.4-not (f64.4) (f64.4) f64-not)
(sb-simd-test-suite:define-simple-simd-test f64.4-max (f64.4) (f64.4 &rest f64.4) f64-max)
(sb-simd-test-suite:define-simple-simd-test f64.4-min (f64.4) (f64.4 &rest f64.4) f64-min)
(sb-simd-test-suite:define-simple-simd-test f64.4+ (f64.4) (&rest f64.4) f64+)
(sb-simd-test-suite:define-simple-simd-test f64.4- (f64.4) (f64.4 &rest f64.4) f64-)
(sb-simd-test-suite:define-simple-simd-test f64.4* (f64.4) (&rest f64.4) f64*)
(sb-simd-test-suite:define-simple-simd-test f64.4/ (f64.4) (f64.4 &rest f64.4) f64/)
(sb-simd-test-suite:define-simple-simd-test f64.4= (u64.4) (f64.4 &rest f64.4) f64=)
(sb-simd-test-suite:define-simple-simd-test f64.4/= (u64.4) (f64.4 &rest f64.4) f64/=)
(sb-simd-test-suite:define-simple-simd-test f64.4< (u64.4) (f64.4 &rest f64.4) f64<)
(sb-simd-test-suite:define-simple-simd-test f64.4<= (u64.4) (f64.4 &rest f64.4) f64<=)
(sb-simd-test-suite:define-simple-simd-test f64.4> (u64.4) (f64.4 &rest f64.4) f64>)
(sb-simd-test-suite:define-simple-simd-test f64.4>= (u64.4) (f64.4 &rest f64.4) f64>=)

(sb-simd-test-suite:define-simple-simd-test u8.16-if (u8.16) (u8.16 u8.16 u8.16) u8-if)
(sb-simd-test-suite:define-simple-simd-test u8.16-and (u8.16) (&rest u8.16) u8-and)
(sb-simd-test-suite:define-simple-simd-test u8.16-or (u8.16) (&rest u8.16) u8-or)
(sb-simd-test-suite:define-simple-simd-test u8.16-xor (u8.16) (&rest u8.16) u8-xor)
(sb-simd-test-suite:define-simple-simd-test u8.16-andc1 (u8.16) (u8.16 u8.16) u8-andc1)
(sb-simd-test-suite:define-simple-simd-test u8.16-not (u8.16) (u8.16) u8-not)
(sb-simd-test-suite:define-simple-simd-test u8.16+ (u8.16) (&rest u8.16) u8+)
(sb-simd-test-suite:define-simple-simd-test u8.16- (u8.16) (u8.16 &rest u8.16) u8-)
(sb-simd-test-suite:define-simple-simd-test u8.16= (u8.16) (u8.16 &rest u8.16) u8=)
(sb-simd-test-suite:define-simple-simd-test u8.16/= (u8.16) (u8.16 &rest u8.16) u8/=)
(sb-simd-test-suite:define-simple-simd-test u8.16< (u8.16) (u8.16 &rest u8.16) u8<)
(sb-simd-test-suite:define-simple-simd-test u8.16<= (u8.16) (u8.16 &rest u8.16) u8<=)
(sb-simd-test-suite:define-simple-simd-test u8.16> (u8.16) (u8.16 &rest u8.16) u8>)
(sb-simd-test-suite:define-simple-simd-test u8.16>= (u8.16) (u8.16 &rest u8.16) u8>=)

(sb-simd-test-suite:define-simple-simd-test u16.8-if (u16.8) (u16.8 u16.8 u16.8) u16-if)
(sb-simd-test-suite:define-simple-simd-test u16.8-and (u16.8) (&rest u16.8) u16-and)
(sb-simd-test-suite:define-simple-simd-test u16.8-or (u16.8) (&rest u16.8) u16-or)
(sb-simd-test-suite:define-simple-simd-test u16.8-xor (u16.8) (&rest u16.8) u16-xor)
(sb-simd-test-suite:define-simple-simd-test u16.8-andc1 (u16.8) (u16.8 u16.8) u16-andc1)
(sb-simd-test-suite:define-simple-simd-test u16.8-not (u16.8) (u16.8) u16-not)
(sb-simd-test-suite:define-simple-simd-test u16.8+ (u16.8) (&rest u16.8) u16+)
(sb-simd-test-suite:define-simple-simd-test u16.8- (u16.8) (u16.8 &rest u16.8) u16-)
(sb-simd-test-suite:define-simple-simd-test u16.8= (u16.8) (u16.8 &rest u16.8) u16=)
(sb-simd-test-suite:define-simple-simd-test u16.8/= (u16.8) (u16.8 &rest u16.8) u16/=)
(sb-simd-test-suite:define-simple-simd-test u16.8< (u16.8) (u16.8 &rest u16.8) u16<)
(sb-simd-test-suite:define-simple-simd-test u16.8<= (u16.8) (u16.8 &rest u16.8) u16<=)
(sb-simd-test-suite:define-simple-simd-test u16.8> (u16.8) (u16.8 &rest u16.8) u16>)
(sb-simd-test-suite:define-simple-simd-test u16.8>= (u16.8) (u16.8 &rest u16.8) u16>=)

(sb-simd-test-suite:define-simple-simd-test u32.4-if (u32.4) (u32.4 u32.4 u32.4) u32-if)
(sb-simd-test-suite:define-simple-simd-test u32.4-and (u32.4) (&rest u32.4) u32-and)
(sb-simd-test-suite:define-simple-simd-test u32.4-or (u32.4) (&rest u32.4) u32-or)
(sb-simd-test-suite:define-simple-simd-test u32.4-xor (u32.4) (&rest u32.4) u32-xor)
(sb-simd-test-suite:define-simple-simd-test u32.4-andc1 (u32.4) (u32.4 u32.4) u32-andc1)
(sb-simd-test-suite:define-simple-simd-test u32.4-not (u32.4) (u32.4) u32-not)
(sb-simd-test-suite:define-simple-simd-test u32.4+ (u32.4) (&rest u32.4) u32+)
(sb-simd-test-suite:define-simple-simd-test u32.4- (u32.4) (u32.4 &rest u32.4) u32-)
(sb-simd-test-suite:define-simple-simd-test u32.4= (u32.4) (u32.4 &rest u32.4) u32=)
(sb-simd-test-suite:define-simple-simd-test u32.4/= (u32.4) (u32.4 &rest u32.4) u32/=)
(sb-simd-test-suite:define-simple-simd-test u32.4< (u32.4) (u32.4 &rest u32.4) u32<)
(sb-simd-test-suite:define-simple-simd-test u32.4<= (u32.4) (u32.4 &rest u32.4) u32<=)
(sb-simd-test-suite:define-simple-simd-test u32.4> (u32.4) (u32.4 &rest u32.4) u32>)
(sb-simd-test-suite:define-simple-simd-test u32.4>= (u32.4) (u32.4 &rest u32.4) u32>=)

(sb-simd-test-suite:define-simple-simd-test u64.2-if (u64.2) (u64.2 u64.2 u64.2) u64-if)
(sb-simd-test-suite:define-simple-simd-test u64.2-and (u64.2) (&rest u64.2) u64-and)
(sb-simd-test-suite:define-simple-simd-test u64.2-or (u64.2) (&rest u64.2) u64-or)
(sb-simd-test-suite:define-simple-simd-test u64.2-xor (u64.2) (&rest u64.2) u64-xor)
(sb-simd-test-suite:define-simple-simd-test u64.2-andc1 (u64.2) (u64.2 u64.2) u64-andc1)
(sb-simd-test-suite:define-simple-simd-test u64.2-not (u64.2) (u64.2) u64-not)
(sb-simd-test-suite:define-simple-simd-test u64.2+ (u64.2) (&rest u64.2) u64+)
(sb-simd-test-suite:define-simple-simd-test u64.2- (u64.2) (u64.2 &rest u64.2) u64-)
(sb-simd-test-suite:define-simple-simd-test u64.2= (u64.2) (u64.2 &rest u64.2) u64=)
(sb-simd-test-suite:define-simple-simd-test u64.2/= (u64.2) (u64.2 &rest u64.2) u64/=)
(sb-simd-test-suite:define-simple-simd-test u64.2< (u64.2) (u64.2 &rest u64.2) u64<)
(sb-simd-test-suite:define-simple-simd-test u64.2<= (u64.2) (u64.2 &rest u64.2) u64<=)
(sb-simd-test-suite:define-simple-simd-test u64.2> (u64.2) (u64.2 &rest u64.2) u64>)
(sb-simd-test-suite:define-simple-simd-test u64.2>= (u64.2) (u64.2 &rest u64.2) u64>=)

(sb-simd-test-suite:define-simple-simd-test s8.16-if (s8.16) (u8.16 s8.16 s8.16) s8-if)
(sb-simd-test-suite:define-simple-simd-test s8.16-and (s8.16) (&rest s8.16) s8-and)
(sb-simd-test-suite:define-simple-simd-test s8.16-or (s8.16) (&rest s8.16) s8-or)
(sb-simd-test-suite:define-simple-simd-test s8.16-xor (s8.16) (&rest s8.16) s8-xor)
(sb-simd-test-suite:define-simple-simd-test s8.16-andc1 (s8.16) (s8.16 s8.16) s8-andc1)
(sb-simd-test-suite:define-simple-simd-test s8.16-not (s8.16) (s8.16) s8-not)
(sb-simd-test-suite:define-simple-simd-test s8.16+ (s8.16) (&rest s8.16) s8+)
(sb-simd-test-suite:define-simple-simd-test s8.16- (s8.16) (s8.16 &rest s8.16) s8-)
(sb-simd-test-suite:define-simple-simd-test s8.16= (u8.16) (s8.16 &rest s8.16) s8=)
(sb-simd-test-suite:define-simple-simd-test s8.16/= (u8.16) (s8.16 &rest s8.16) s8/=)
(sb-simd-test-suite:define-simple-simd-test s8.16< (u8.16) (s8.16 &rest s8.16) s8<)
(sb-simd-test-suite:define-simple-simd-test s8.16<= (u8.16) (s8.16 &rest s8.16) s8<=)
(sb-simd-test-suite:define-simple-simd-test s8.16> (u8.16) (s8.16 &rest s8.16) s8>)
(sb-simd-test-suite:define-simple-simd-test s8.16>= (u8.16) (s8.16 &rest s8.16) s8>=)

(sb-simd-test-suite:define-simple-simd-test s16.8-if (s16.8) (u16.8 s16.8 s16.8) s16-if)
(sb-simd-test-suite:define-simple-simd-test s16.8-and (s16.8) (&rest s16.8) s16-and)
(sb-simd-test-suite:define-simple-simd-test s16.8-or (s16.8) (&rest s16.8) s16-or)
(sb-simd-test-suite:define-simple-simd-test s16.8-xor (s16.8) (&rest s16.8) s16-xor)
(sb-simd-test-suite:define-simple-simd-test s16.8-andc1 (s16.8) (s16.8 s16.8) s16-andc1)
(sb-simd-test-suite:define-simple-simd-test s16.8-not (s16.8) (s16.8) s16-not)
(sb-simd-test-suite:define-simple-simd-test s16.8+ (s16.8) (&rest s16.8) s16+)
(sb-simd-test-suite:define-simple-simd-test s16.8- (s16.8) (s16.8 &rest s16.8) s16-)
(sb-simd-test-suite:define-simple-simd-test s16.8= (u16.8) (s16.8 &rest s16.8) s16=)
(sb-simd-test-suite:define-simple-simd-test s16.8/= (u16.8) (s16.8 &rest s16.8) s16/=)
(sb-simd-test-suite:define-simple-simd-test s16.8< (u16.8) (s16.8 &rest s16.8) s16<)
(sb-simd-test-suite:define-simple-simd-test s16.8<= (u16.8) (s16.8 &rest s16.8) s16<=)
(sb-simd-test-suite:define-simple-simd-test s16.8> (u16.8) (s16.8 &rest s16.8) s16>)
(sb-simd-test-suite:define-simple-simd-test s16.8>= (u16.8) (s16.8 &rest s16.8) s16>=)

(sb-simd-test-suite:define-simple-simd-test s32.4-if (s32.4) (u32.4 s32.4 s32.4) s32-if)
(sb-simd-test-suite:define-simple-simd-test s32.4-and (s32.4) (&rest s32.4) s32-and)
(sb-simd-test-suite:define-simple-simd-test s32.4-or (s32.4) (&rest s32.4) s32-or)
(sb-simd-test-suite:define-simple-simd-test s32.4-xor (s32.4) (&rest s32.4) s32-xor)
(sb-simd-test-suite:define-simple-simd-test s32.4-andc1 (s32.4) (s32.4 s32.4) s32-andc1)
(sb-simd-test-suite:define-simple-simd-test s32.4-not (s32.4) (s32.4) s32-not)
(sb-simd-test-suite:define-simple-simd-test s32.4+ (s32.4) (&rest s32.4) s32+)
(sb-simd-test-suite:define-simple-simd-test s32.4- (s32.4) (s32.4 &rest s32.4) s32-)
(sb-simd-test-suite:define-simple-simd-test s32.4= (u32.4) (s32.4 &rest s32.4) s32=)
(sb-simd-test-suite:define-simple-simd-test s32.4/= (u32.4) (s32.4 &rest s32.4) s32/=)
(sb-simd-test-suite:define-simple-simd-test s32.4< (u32.4) (s32.4 &rest s32.4) s32<)
(sb-simd-test-suite:define-simple-simd-test s32.4<= (u32.4) (s32.4 &rest s32.4) s32<=)
(sb-simd-test-suite:define-simple-simd-test s32.4> (u32.4) (s32.4 &rest s32.4) s32>)
(sb-simd-test-suite:define-simple-simd-test s32.4>= (u32.4) (s32.4 &rest s32.4) s32>=)

(sb-simd-test-suite:define-simple-simd-test s64.2-if (s64.2) (u64.2 s64.2 s64.2) s64-if)
(sb-simd-test-suite:define-simple-simd-test s64.2-and (s64.2) (&rest s64.2) s64-and)
(sb-simd-test-suite:define-simple-simd-test s64.2-or (s64.2) (&rest s64.2) s64-or)
(sb-simd-test-suite:define-simple-simd-test s64.2-xor (s64.2) (&rest s64.2) s64-xor)
(sb-simd-test-suite:define-simple-simd-test s64.2-andc1 (s64.2) (s64.2 s64.2) s64-andc1)
(sb-simd-test-suite:define-simple-simd-test s64.2-not (s64.2) (s64.2) s64-not)
(sb-simd-test-suite:define-simple-simd-test s64.2+ (s64.2) (&rest s64.2) s64+)
(sb-simd-test-suite:define-simple-simd-test s64.2- (s64.2) (s64.2 &rest s64.2) s64-)
(sb-simd-test-suite:define-simple-simd-test s64.2= (u64.2) (s64.2 &rest s64.2) s64=)
(sb-simd-test-suite:define-simple-simd-test s64.2< (u64.2) (s64.2 &rest s64.2) s64<)
(sb-simd-test-suite:define-simple-simd-test s64.2<= (u64.2) (s64.2 &rest s64.2) s64<=)
(sb-simd-test-suite:define-simple-simd-test s64.2> (u64.2) (s64.2 &rest s64.2) s64>)
(sb-simd-test-suite:define-simple-simd-test s64.2>= (u64.2) (s64.2 &rest s64.2) s64>=)

(in-package #:sb-simd-avx2)

(sb-simd-test-suite:define-simple-simd-test u8.32-if (u8.32) (u8.32 u8.32 u8.32) u8-if)
(sb-simd-test-suite:define-simple-simd-test u8.32-and (u8.32) (&rest u8.32) u8-and)
(sb-simd-test-suite:define-simple-simd-test u8.32-or (u8.32) (&rest u8.32) u8-or)
(sb-simd-test-suite:define-simple-simd-test u8.32-xor (u8.32) (&rest u8.32) u8-xor)
(sb-simd-test-suite:define-simple-simd-test u8.32-andc1 (u8.32) (u8.32 u8.32) u8-andc1)
(sb-simd-test-suite:define-simple-simd-test u8.32-not (u8.32) (u8.32) u8-not)
(sb-simd-test-suite:define-simple-simd-test u8.32+ (u8.32) (&rest u8.32) u8+)
(sb-simd-test-suite:define-simple-simd-test u8.32- (u8.32) (u8.32 &rest u8.32) u8-)
(sb-simd-test-suite:define-simple-simd-test u8.32= (u8.32) (u8.32 &rest u8.32) u8=)
(sb-simd-test-suite:define-simple-simd-test u8.32/= (u8.32) (u8.32 &rest u8.32) u8/=)
(sb-simd-test-suite:define-simple-simd-test u8.32< (u8.32) (u8.32 &rest u8.32) u8<)
(sb-simd-test-suite:define-simple-simd-test u8.32<= (u8.32) (u8.32 &rest u8.32) u8<=)
(sb-simd-test-suite:define-simple-simd-test u8.32> (u8.32) (u8.32 &rest u8.32) u8>)
(sb-simd-test-suite:define-simple-simd-test u8.32>= (u8.32) (u8.32 &rest u8.32) u8>=)

(sb-simd-test-suite:define-simple-simd-test u16.16-if (u16.16) (u16.16 u16.16 u16.16) u16-if)
(sb-simd-test-suite:define-simple-simd-test u16.16-and (u16.16) (&rest u16.16) u16-and)
(sb-simd-test-suite:define-simple-simd-test u16.16-or (u16.16) (&rest u16.16) u16-or)
(sb-simd-test-suite:define-simple-simd-test u16.16-xor (u16.16) (&rest u16.16) u16-xor)
(sb-simd-test-suite:define-simple-simd-test u16.16-andc1 (u16.16) (u16.16 u16.16) u16-andc1)
(sb-simd-test-suite:define-simple-simd-test u16.16-not (u16.16) (u16.16) u16-not)
(sb-simd-test-suite:define-simple-simd-test u16.16+ (u16.16) (&rest u16.16) u16+)
(sb-simd-test-suite:define-simple-simd-test u16.16- (u16.16) (u16.16 &rest u16.16) u16-)
(sb-simd-test-suite:define-simple-simd-test u16.16= (u16.16) (u16.16 &rest u16.16) u16=)
(sb-simd-test-suite:define-simple-simd-test u16.16/= (u16.16) (u16.16 &rest u16.16) u16/=)
(sb-simd-test-suite:define-simple-simd-test u16.16< (u16.16) (u16.16 &rest u16.16) u16<)
(sb-simd-test-suite:define-simple-simd-test u16.16<= (u16.16) (u16.16 &rest u16.16) u16<=)
(sb-simd-test-suite:define-simple-simd-test u16.16> (u16.16) (u16.16 &rest u16.16) u16>)
(sb-simd-test-suite:define-simple-simd-test u16.16>= (u16.16) (u16.16 &rest u16.16) u16>=)

(sb-simd-test-suite:define-simple-simd-test u32.8-if (u32.8) (u32.8 u32.8 u32.8) u32-if)
(sb-simd-test-suite:define-simple-simd-test u32.8-and (u32.8) (&rest u32.8) u32-and)
(sb-simd-test-suite:define-simple-simd-test u32.8-or (u32.8) (&rest u32.8) u32-or)
(sb-simd-test-suite:define-simple-simd-test u32.8-xor (u32.8) (&rest u32.8) u32-xor)
(sb-simd-test-suite:define-simple-simd-test u32.8-andc1 (u32.8) (u32.8 u32.8) u32-andc1)
(sb-simd-test-suite:define-simple-simd-test u32.8-not (u32.8) (u32.8) u32-not)
(sb-simd-test-suite:define-simple-simd-test u32.8+ (u32.8) (&rest u32.8) u32+)
(sb-simd-test-suite:define-simple-simd-test u32.8- (u32.8) (u32.8 &rest u32.8) u32-)
(sb-simd-test-suite:define-simple-simd-test u32.8= (u32.8) (u32.8 &rest u32.8) u32=)
(sb-simd-test-suite:define-simple-simd-test u32.8/= (u32.8) (u32.8 &rest u32.8) u32/=)
(sb-simd-test-suite:define-simple-simd-test u32.8< (u32.8) (u32.8 &rest u32.8) u32<)
(sb-simd-test-suite:define-simple-simd-test u32.8<= (u32.8) (u32.8 &rest u32.8) u32<=)
(sb-simd-test-suite:define-simple-simd-test u32.8> (u32.8) (u32.8 &rest u32.8) u32>)
(sb-simd-test-suite:define-simple-simd-test u32.8>= (u32.8) (u32.8 &rest u32.8) u32>=)

(sb-simd-test-suite:define-simple-simd-test u64.4-if (u64.4) (u64.4 u64.4 u64.4) u64-if)
(sb-simd-test-suite:define-simple-simd-test u64.4-and (u64.4) (&rest u64.4) u64-and)
(sb-simd-test-suite:define-simple-simd-test u64.4-or (u64.4) (&rest u64.4) u64-or)
(sb-simd-test-suite:define-simple-simd-test u64.4-xor (u64.4) (&rest u64.4) u64-xor)
(sb-simd-test-suite:define-simple-simd-test u64.4-andc1 (u64.4) (u64.4 u64.4) u64-andc1)
(sb-simd-test-suite:define-simple-simd-test u64.4-not (u64.4) (u64.4) u64-not)
(sb-simd-test-suite:define-simple-simd-test u64.4+ (u64.4) (&rest u64.4) u64+)
(sb-simd-test-suite:define-simple-simd-test u64.4- (u64.4) (u64.4 &rest u64.4) u64-)
(sb-simd-test-suite:define-simple-simd-test u64.4= (u64.4) (u64.4 &rest u64.4) u64=)
(sb-simd-test-suite:define-simple-simd-test u64.4/= (u64.4) (u64.4 &rest u64.4) u64/=)
(sb-simd-test-suite:define-simple-simd-test u64.4< (u64.4) (u64.4 &rest u64.4) u64<)
(sb-simd-test-suite:define-simple-simd-test u64.4<= (u64.4) (u64.4 &rest u64.4) u64<=)
(sb-simd-test-suite:define-simple-simd-test u64.4> (u64.4) (u64.4 &rest u64.4) u64>)
(sb-simd-test-suite:define-simple-simd-test u64.4>= (u64.4) (u64.4 &rest u64.4) u64>=)

(sb-simd-test-suite:define-simple-simd-test s8.32-if (s8.32) (u8.32 s8.32 s8.32) s8-if)
(sb-simd-test-suite:define-simple-simd-test s8.32-and (s8.32) (&rest s8.32) s8-and)
(sb-simd-test-suite:define-simple-simd-test s8.32-or (s8.32) (&rest s8.32) s8-or)
(sb-simd-test-suite:define-simple-simd-test s8.32-xor (s8.32) (&rest s8.32) s8-xor)
(sb-simd-test-suite:define-simple-simd-test s8.32-andc1 (s8.32) (s8.32 s8.32) s8-andc1)
(sb-simd-test-suite:define-simple-simd-test s8.32-not (s8.32) (s8.32) s8-not)
(sb-simd-test-suite:define-simple-simd-test s8.32+ (s8.32) (&rest s8.32) s8+)
(sb-simd-test-suite:define-simple-simd-test s8.32- (s8.32) (s8.32 &rest s8.32) s8-)
(sb-simd-test-suite:define-simple-simd-test s8.32= (u8.32) (s8.32 &rest s8.32) s8=)
(sb-simd-test-suite:define-simple-simd-test s8.32/= (u8.32) (s8.32 &rest s8.32) s8/=)
(sb-simd-test-suite:define-simple-simd-test s8.32< (u8.32) (s8.32 &rest s8.32) s8<)
(sb-simd-test-suite:define-simple-simd-test s8.32<= (u8.32) (s8.32 &rest s8.32) s8<=)
(sb-simd-test-suite:define-simple-simd-test s8.32> (u8.32) (s8.32 &rest s8.32) s8>)
(sb-simd-test-suite:define-simple-simd-test s8.32>= (u8.32) (s8.32 &rest s8.32) s8>=)

(sb-simd-test-suite:define-simple-simd-test s16.16-if (s16.16) (u16.16 s16.16 s16.16) s16-if)
(sb-simd-test-suite:define-simple-simd-test s16.16-and (s16.16) (&rest s16.16) s16-and)
(sb-simd-test-suite:define-simple-simd-test s16.16-or (s16.16) (&rest s16.16) s16-or)
(sb-simd-test-suite:define-simple-simd-test s16.16-xor (s16.16) (&rest s16.16) s16-xor)
(sb-simd-test-suite:define-simple-simd-test s16.16-andc1 (s16.16) (s16.16 s16.16) s16-andc1)
(sb-simd-test-suite:define-simple-simd-test s16.16-not (s16.16) (s16.16) s16-not)
(sb-simd-test-suite:define-simple-simd-test s16.16+ (s16.16) (&rest s16.16) s16+)
(sb-simd-test-suite:define-simple-simd-test s16.16- (s16.16) (s16.16 &rest s16.16) s16-)
(sb-simd-test-suite:define-simple-simd-test s16.16= (u16.16) (s16.16 &rest s16.16) s16=)
(sb-simd-test-suite:define-simple-simd-test s16.16/= (u16.16) (s16.16 &rest s16.16) s16/=)
(sb-simd-test-suite:define-simple-simd-test s16.16< (u16.16) (s16.16 &rest s16.16) s16<)
(sb-simd-test-suite:define-simple-simd-test s16.16<= (u16.16) (s16.16 &rest s16.16) s16<=)
(sb-simd-test-suite:define-simple-simd-test s16.16> (u16.16) (s16.16 &rest s16.16) s16>)
(sb-simd-test-suite:define-simple-simd-test s16.16>= (u16.16) (s16.16 &rest s16.16) s16>=)

(sb-simd-test-suite:define-simple-simd-test s32.8-if (s32.8) (u32.8 s32.8 s32.8) s32-if)
(sb-simd-test-suite:define-simple-simd-test s32.8-and (s32.8) (&rest s32.8) s32-and)
(sb-simd-test-suite:define-simple-simd-test s32.8-or (s32.8) (&rest s32.8) s32-or)
(sb-simd-test-suite:define-simple-simd-test s32.8-xor (s32.8) (&rest s32.8) s32-xor)
(sb-simd-test-suite:define-simple-simd-test s32.8-andc1 (s32.8) (s32.8 s32.8) s32-andc1)
(sb-simd-test-suite:define-simple-simd-test s32.8-not (s32.8) (s32.8) s32-not)
(sb-simd-test-suite:define-simple-simd-test s32.8+ (s32.8) (&rest s32.8) s32+)
(sb-simd-test-suite:define-simple-simd-test s32.8- (s32.8) (s32.8 &rest s32.8) s32-)
(sb-simd-test-suite:define-simple-simd-test s32.8= (u32.8) (s32.8 &rest s32.8) s32=)
(sb-simd-test-suite:define-simple-simd-test s32.8/= (u32.8) (s32.8 &rest s32.8) s32/=)
(sb-simd-test-suite:define-simple-simd-test s32.8< (u32.8) (s32.8 &rest s32.8) s32<)
(sb-simd-test-suite:define-simple-simd-test s32.8<= (u32.8) (s32.8 &rest s32.8) s32<=)
(sb-simd-test-suite:define-simple-simd-test s32.8> (u32.8) (s32.8 &rest s32.8) s32>)
(sb-simd-test-suite:define-simple-simd-test s32.8>= (u32.8) (s32.8 &rest s32.8) s32>=)

(sb-simd-test-suite:define-simple-simd-test s64.4-if (s64.4) (u64.4 s64.4 s64.4) s64-if)
(sb-simd-test-suite:define-simple-simd-test s64.4-and (s64.4) (&rest s64.4) s64-and)
(sb-simd-test-suite:define-simple-simd-test s64.4-or (s64.4) (&rest s64.4) s64-or)
(sb-simd-test-suite:define-simple-simd-test s64.4-xor (s64.4) (&rest s64.4) s64-xor)
(sb-simd-test-suite:define-simple-simd-test s64.4-andc1 (s64.4) (s64.4 s64.4) s64-andc1)
(sb-simd-test-suite:define-simple-simd-test s64.4-not (s64.4) (s64.4) s64-not)
(sb-simd-test-suite:define-simple-simd-test s64.4+ (s64.4) (&rest s64.4) s64+)
(sb-simd-test-suite:define-simple-simd-test s64.4- (s64.4) (s64.4 &rest s64.4) s64-)
(sb-simd-test-suite:define-simple-simd-test s64.4= (u64.4) (s64.4 &rest s64.4) s64=)
(sb-simd-test-suite:define-simple-simd-test s64.4< (u64.4) (s64.4 &rest s64.4) s64<)
(sb-simd-test-suite:define-simple-simd-test s64.4<= (u64.4) (s64.4 &rest s64.4) s64<=)
(sb-simd-test-suite:define-simple-simd-test s64.4> (u64.4) (s64.4 &rest s64.4) s64>)
(sb-simd-test-suite:define-simple-simd-test s64.4>= (u64.4) (s64.4 &rest s64.4) s64>=)
