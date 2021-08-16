(in-package #:sb-simd-test-suite)

(defun shuffle (list)
  (let ((result (copy-seq list)))
    (loop for tail on result
          for tail-length from (length result) downto 2
          do (rotatef (first tail)
                      (nth (random tail-length) tail)))
    result))

(defun simd-info (name)
  "Returns, as list:

 1. The element type of the SIMD pack.

 2. The number of elements of the SIMD pack.

 3. The name of the function for creating the SIMD pack from individual
    elements.

 4. The name of the function for returning the elements of the SIMD pack as
    multiple values."
  (with-accessors ((scalar-record simd-record-scalar-record)
                   (size simd-record-size))
      (find-value-record name)
    (list
     (scalar-record-name scalar-record)
     size
     (or (find-symbol (format nil "MAKE-~A" (symbol-name name))
                      (symbol-package name))
         (error "No constructor found for ~S." name))
     (or (find-symbol (format nil "~A-VALUES" (symbol-name name))
                      (symbol-package name))
         (error "No unpacker found for ~S." name)))))

(defun simd= (a b)
  (typecase a
    (sb-ext:simd-pack
     (when (sb-ext:simd-pack-p b)
       (multiple-value-bind (a0 a1) (sb-ext:%simd-pack-ub64s a)
         (multiple-value-bind (b0 b1) (sb-ext:%simd-pack-ub64s b)
           (and (= a0 b0) (= a1 b1))))))
    (sb-ext:simd-pack-256
     (when (sb-ext:simd-pack-256-p b)
       (multiple-value-bind (a0 a1 a2 a3) (sb-ext:%simd-pack-256-ub64s a)
         (multiple-value-bind (b0 b1 b2 b3) (sb-ext:%simd-pack-256-ub64s b)
           (and (= a0 b0) (= a1 b1) (= a2 b2) (= a3 b3))))))
    (otherwise nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Argument Type Specifications

(defun parse-argtypes (argtypes)
  "Returns, as multiple values:

 1. The list of mandatory argtypes.

 2. The list of optional argtypes.

 3. The argtype of the rest argument, or NIL if there is no &rest argtype."
  (labels ((fail ()
             (error "Malformed argtypes list: ~S" argtypes))
           (process-mandatory (argtypes mandatory)
             (if (null argtypes)
                 (values (reverse mandatory) '() nil)
                 (case (first argtypes)
                   ((&optional)
                    (process-optional (rest argtypes) mandatory '()))
                   ((&rest)
                    (process-rest (rest argtypes) mandatory '()))
                   (#.(set-difference lambda-list-keywords '(&optional &rest))
                    (fail))
                   (otherwise
                    (process-mandatory (rest argtypes) (cons (first argtypes) mandatory))))))
           (process-optional (argtypes mandatory optional)
             (if (null argtypes)
                 (values (reverse mandatory) (reverse optional) nil)
                 (case (first argtypes)
                   ((&rest)
                    (process-rest (rest argtypes) mandatory optional))
                   (#.(set-difference lambda-list-keywords '(&rest))
                    (fail))
                   (otherwise
                    (process-optional (rest argtypes) mandatory (cons (first argtypes) optional))))))
           (process-rest (argtypes mandatory optional)
             (if (or (endp argtypes)
                     (not (endp (rest argtypes))))
                 (fail)
                 (values (reverse mandatory) (reverse optional) (first argtypes)))))
    (process-mandatory argtypes '())))

(defun argtypes-variants (argtypes)
  "Returns a list of lists of type specifiers such that each list of type
specifiers satisfies the argument type specification given by ARGTYPES."
  (multiple-value-bind (mandatory optional rest)
      (parse-argtypes argtypes)
    (let ((result '()))
      (loop for n-optional to (length optional) do
        (loop for n-rest below (if (not rest) 0 4) do
          (push (append mandatory
                        (subseq optional 0 n-optional)
                        (make-list n-rest :initial-element rest))
                result)))
      (reverse result))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generators

(defun find-generator (type)
  (intern (format nil "RANDOM-~A" (symbol-name type))
          #.*package*))

(macrolet ((define-generators ()
             `(progn
                ,@(loop for (type name)
                          in '((sb-simd-common:f32 random-f32)
                               (sb-simd-common:f64 random-f64)
                               (sb-simd-common:u8 random-u8)
                               (sb-simd-common:u16 random-u16)
                               (sb-simd-common:u32 random-u32)
                               (sb-simd-common:u64 random-u64)
                               (sb-simd-common:s8 random-s8)
                               (sb-simd-common:s16 random-s16)
                               (sb-simd-common:s32 random-s32)
                               (sb-simd-common:s64 random-s64))
                        collect
                        (let ((numbers (numbers-of-type type)))
                          `(defun ,name ()
                             (aref ,(coerce numbers `(simple-array ,type (*)))
                                   (random ,(length numbers)))))))))
  (define-generators))
