#lang racket

(require graph)
(require future-visualizer)

(provide BuildG)
(provide Centrality)
(provide Keywords)
(provide Partition)

(provide calc-Centrality)

;;Substituir pela função do Bruno
(define (BuildG words-list)
  (define g (unweighted-graph/directed '()))
  (let aux ([n (car words-list)] [r-list (cdr words-list)])
    (if (null? r-list)
        g
       (and (add-edge! g n (car r-list)) (aux (car r-list) (cdr r-list))))))
  ;;----------------

(define (Centrality words-list)
  (define nOGraph (BuildG words-list))
  (define all-vertices (get-vertices nOGraph))
  (define g-size (length all-vertices))
  (define j (Partition all-vertices))
  (define future-list (map (lambda (x) (future (lambda () (calc-Centrality nOGraph g-size x)))) j))
  (define centrality-list (append-map (lambda (x) (touch x)) future-list))
  centrality-list)

(define (Keywords ctlList percent)
  (Get-Keywords
   (sort  ctlList(lambda (x y) (> (cdr x) (cdr y))))
    percent))

;;Funções auxiliares
(define (calc-Centrality nOGraph g-size all-vertices)
  (map (lambda (x) (cons x (/ (length (get-neighbors nOGraph x)) (- g-size 1)))) all-vertices))

(define (Partition cList)
  (define f (processor-count))
  (define part (/ (length cList) f))
  (let aux ([o-list cList] [rest-list null] [n 1])
    (if (= n f)
        (cons o-list rest-list )
        (aux (drop o-list (floor part)) (cons (take o-list (floor part)) rest-list) (add1 n)))))

;;;PARTITION FOR TEST
(define (Partition-fake cList)
  (define f 1)
  (define part (/ (length cList) f))
  (let aux ([o-list cList] [rest-list null] [n 0])
    (if (= n f)
        (cons o-list rest-list )
        (aux (drop o-list (floor part)) (cons (take o-list (floor part)) rest-list) (add1 n)))))

(define (Get-Keywords list-keys percent)
  (map (lambda (x) (car x)) (take list-keys (exact-ceiling (* percent (length list-keys))))))