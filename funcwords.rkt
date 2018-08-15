#lang racket

(require graph)

(provide GetFile)
(provide BuildG)
(provide Centrality)

(define (GetFile file) #t)

(define (BuildG l-palavras) #t)

(define (Centrality nOGraph)
  (define all-vertices (get-vertices nOGraph))
  (define g-size (length all-vertices))
  (define centrality-list '())
  (map (lambda (x) (cons centrality-list (cons x (/ (length (get-neighbors nOGraph x)) (- g-size 1))))) all-vertices))

(define (Keywords ctlList)
  (sort  ctlList
        (lambda (x y) (> (cdr x) (cdr y)))))
  