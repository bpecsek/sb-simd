(in-package #:sb-simd-internals)

(defmacro define-reducer (name binary-operation initial-element)
  (with-accessors ((result-records primitive-record-result-records)
                   (argument-records primitive-record-argument-records))
      (find-instruction-record binary-operation)
    (destructuring-bind ((value-record) (arg1-record arg2-record))
        (list result-records argument-records)
      (assert (eq value-record arg1-record))
      (assert (eq value-record arg2-record))
      (let ((type (value-record-name value-record)))
        `(progn
           (defun ,name (arg &rest more-args)
             (if (null more-args)
                 (,binary-operation (,type ,initial-element) (,type arg))
                 (let ((result (,type arg)))
                   (declare (,type result))
                   (loop for arg in more-args
                         do (setf result (,binary-operation result (,type arg))))
                   result)))
           (define-compiler-macro ,name (arg &rest more-args)
             (cond ((null more-args)
                    `(,',binary-operation ,',initial-element (,',type ,arg)))
                   (t (reduce
                       (lambda (a b) `(,',binary-operation (,',type ,a) (,',type ,b)))
                       more-args
                       :initial-value `(,',type ,arg))))))))))

(in-package #:sb-simd-common)

(define-reducer f32- two-arg-f32- 0f0)
(define-reducer f32/ two-arg-f32/ 1f0)

(define-reducer f64- two-arg-f64- 0d0)
(define-reducer f64/ two-arg-f64/ 1d0)

(define-reducer u8- two-arg-u8- 0)
(define-reducer u16- two-arg-u16- 0)
(define-reducer u32- two-arg-u32- 0)
(define-reducer u64- two-arg-u64- 0)

(define-reducer s8- two-arg-s8- 0)
(define-reducer s16- two-arg-s16- 0)
(define-reducer s32- two-arg-s32- 0)
(define-reducer s64- two-arg-s64- 0)

(in-package #:sb-simd-sse)

(define-reducer f32- two-arg-f32- 0f0)
(define-reducer f32/ two-arg-f32/ 1f0)

(define-reducer f32.4- two-arg-f32.4- 0f0)
(define-reducer f32.4/ two-arg-f32.4/ 1f0)

(in-package #:sb-simd-sse2)

(define-reducer f64- two-arg-f64- 0d0)
(define-reducer f64/ two-arg-f64/ 1d0)

(define-reducer f64.2- two-arg-f64.2- 0d0)
(define-reducer f64.2/ two-arg-f64.2/ 1d0)

(define-reducer u8.16- two-arg-u8.16- 0)
(define-reducer u16.8- two-arg-u16.8- 0)
(define-reducer u32.4- two-arg-u32.4- 0)
(define-reducer u64.2- two-arg-u64.2- 0)

(define-reducer s8.16- two-arg-s8.16- 0)
(define-reducer s16.8- two-arg-s16.8- 0)
(define-reducer s32.4- two-arg-s32.4- 0)
(define-reducer s64.2- two-arg-s64.2- 0)

(in-package #:sb-simd-avx)

(define-reducer f32- two-arg-f32- 0f0)
(define-reducer f32/ two-arg-f32/ 1f0)

(define-reducer f64- two-arg-f64- 0d0)
(define-reducer f64/ two-arg-f64/ 1d0)

(define-reducer f32.4- two-arg-f32.4- 0f0)
(define-reducer f32.4/ two-arg-f32.4/ 1f0)

(define-reducer f64.2- two-arg-f64.2- 0d0)
(define-reducer f64.2/ two-arg-f64.2/ 1d0)

(define-reducer f32.8- two-arg-f32.8- 0f0)
(define-reducer f32.8/ two-arg-f32.8/ 1f0)

(define-reducer f64.4- two-arg-f64.4- 0d0)
(define-reducer f64.4/ two-arg-f64.4/ 1d0)

(define-reducer u8.16- two-arg-u8.16- 0)
(define-reducer u16.8- two-arg-u16.8- 0)
(define-reducer u32.4- two-arg-u32.4- 0)
(define-reducer u64.2- two-arg-u64.2- 0)

(define-reducer s8.16- two-arg-s8.16- 0)
(define-reducer s16.8- two-arg-s16.8- 0)
(define-reducer s32.4- two-arg-s32.4- 0)
(define-reducer s64.2- two-arg-s64.2- 0)

(in-package #:sb-simd-avx2)

(define-reducer u8.32- two-arg-u8.32- 0)
(define-reducer u16.16- two-arg-u16.16- 0)
(define-reducer u32.8- two-arg-u32.8- 0)
(define-reducer u64.4- two-arg-u64.4- 0)

(define-reducer s8.32- two-arg-s8.32- 0)
(define-reducer s16.16- two-arg-s16.16- 0)
(define-reducer s32.8- two-arg-s32.8- 0)
(define-reducer s64.4- two-arg-s64.4- 0)
