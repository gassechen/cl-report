# Build a binary.
build:
	sbcl --load cl-report.asd \
	     --eval '(ql:quickload :cl-report)' \
	     --eval '(asdf:make :cl-report)' \
	     --eval '(quit)'
