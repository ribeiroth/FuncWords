#lang racket

(require graph)
(require future-visualizer)

(provide GetFile)
(provide BuildG)
(provide Centrality)

(define (GetFile file) #t)

(define (BuildG l-palavras) #t)

(define (Centrality nOGraph)
  (define all-vertices (get-vertices nOGraph))
  (define g-size (length all-vertices))
  (define j (Partition all-vertices))
  (define future-list (map (lambda (x) (future (lambda () (calc-Centrality nOGraph g-size x)))) j))
  (define centrality-list (map (lambda (x) (touch x)) future-list))
  centrality-list)

(define (Keywords ctlList)
  (sort  ctlList
        (lambda (x y) (> (cdr x) (cdr y)))))

;;Funções auxiliares
(define (calc-Centrality nOGraph g-size all-vertices)
  (map (lambda (x) (cons x (/ (length (get-neighbors nOGraph x)) (- g-size 1)))) all-vertices))

(define (Partition cList)
  (define f (processor-count))
  (define part (/ (length cList) f))
  (let aux ([o-list cList] [rest-list null] [n 0])
    (if (= n f)
        (cons o-list rest-list )
        (aux (drop o-list (floor part)) (cons (take o-list (floor part)) rest-list) (add1 n))))) 