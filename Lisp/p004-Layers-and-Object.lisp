;;
; Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
;;

; Numpy randn
(defun randn (width height factor)
	(let ((array (make-array (list width height) )))
		(loop for i below width
			do (loop for j below height
				do (setf (aref array i j) (* (random 1.0) factor))
			)
		)
	array)
)

; Numpy zeros
(defun zeros (width height)
	(let ((array (make-array (list width height) )))
		(loop for i below width
			do (loop for j below height
				do (setf (aref array i j) 0.0)
			)
		)
	array)
)

; Python zip builtin
(defun zip (a1 a2)
	(let (
		(zipped (make-array (list (array-dimension a1 0) 2) ) )
		(a1-height (array-dimension a1 0))
		(a1-width (array-dimension a1 1))
		(a2-width (array-dimension a2 1))
	     )
	(loop for i below a1-height
		do (setf (aref zipped i 0) (make-array a1-width :displaced-to a1 :displaced-index-offset (* i a1-width)))
		do (setf (aref zipped i 1) (make-array a2-width :displaced-to a2 :displaced-index-offset (* i a2-width)))
	)
	zipped
	)
)

(defun inner-dot (inputs zipped-weights-and-biases output)
	(loop for i below (array-dimension inputs 0)
	do (let (
	      (inputRow (make-array (array-dimension inputs 1) :displaced-to inputs :displaced-index-offset (* i (array-dimension inputs 1)) ))
	      )
		(loop for j below (array-dimension zipped-weights-and-biases 0)
		do (let (
			(weightRow (aref  zipped-weights-and-biases j 0)))
			(setf (aref output i j) (+ (apply #'+ (mapcar #'* (coerce inputRow 'list) (coerce weightRow 'list))) (aref (aref zipped-weights-and-biases j 1) 0)))
		)
		)
		

	))
)

; Numpy dot
(defun dot (inputs weights biases)
  	(let 	((output (make-array (list (array-dimension inputs 0) (array-dimension weights 0) )))
	 	(zipped-weights-and-biases (zip weights biases))
	      )

		(inner-dot inputs zipped-weights-and-biases output)
	output)
)

(defclass dense-layer ()
(
	(weights :accessor weights :initarg :weights)
	(biases :accessor biases :initarg :biases)
	(outputs :accessor outputs)
))


(defun make-layer (inputs-width inputs-height n-neurons)
	(make-instance 'dense-layer :weights (randn n-neurons inputs-width 0.10) :biases (zeros n-neurons 1))
)

(defmethod forward ((layer dense-layer) inputs)
	(setf (slot-value layer 'outputs) (dot inputs (slot-value layer 'weights) (slot-value layer 'biases)))
)

(defvar inputs (make-array '(3 4)
			   :initial-contents 
				'(( 1.0 2.0 3.0 2.5)
				( 2.0 5.0 -1.0 2.0)
				( -1.5 2.7 3.3 -0.8))))


(defvar *dense-layer-1* (make-layer 4 3 5))
(write-line (format nil "D1 Weights : ~A" (slot-value *dense-layer-1* 'weights)))
(write-line (format nil "D1 Biases : ~A" (slot-value *dense-layer-1* 'biases)))
(write-line (format nil "D1 Inputs : ~A" inputs))
(forward *dense-layer-1* inputs)
(write-line (format nil "D1 Outputs : ~A" (slot-value *dense-layer-1* 'outputs)))

(write-line "")

(defvar *dense-layer-2* (make-layer 5 3 2))
(write-line (format nil "D2 Weights : ~A" (slot-value *dense-layer-2* 'weights)))
(write-line (format nil "D2 Biases : ~A" (slot-value *dense-layer-2* 'biases)))
(write-line (format nil "D2 Inputs : ~A" (slot-value *dense-layer-1* 'outputs)))
(forward *dense-layer-2* (slot-value *dense-layer-1* 'outputs))
(write-line (format nil "D2 Outputs : ~A" (slot-value *dense-layer-2* 'outputs)))
