#lang racket

(require rackunit "funcwords.rkt")

(require rackunit/text-ui)

(define lista-entrada (list "Cahorrinhos" "são" "fofinhos"))
(define lista-entrada1 (list "Bom" "dia" "jovens"))

(define lista-grafo (list "a" "b" "c"))

(define e-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-entrada))
    (check-true  (list? lista-entrada1))
    (test-case
      "Testa GetFile, que recebe um arquivo e devolve uma lista com as palavras dele"
      (define (test-getFile)
        (equal? (GetFile "teste.txt") lista-entrada)
        (not equal? (GetFile "teste.txt") lista-entrada1))
      (check-true (test-getFile)))))

(define graph-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-grafo))
    ;;(check-true  (list? lista-entrada1))
    (test-case
      "Testa BuildG, que recebe uma lista de palavras e retorna um grafo"
      (define (test-BuildG)
        (graph? (BuildG lista-grafo))
        ;;(not equal? (GetFile "teste.txt") lista-entrada1))
      (check-true (test-getFile)))))


(run-tests e-suite)