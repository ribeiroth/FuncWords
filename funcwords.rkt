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
  (define (create-pair v)
    (cons centrality-list (cons v (length (get-neighbors nOGraph v)))))
  (map (lambda (x) (create-pair x)) all-vertices)
  centrality-list)