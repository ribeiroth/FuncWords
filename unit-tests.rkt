#lang racket

(require graph)
(require rackunit "funcwords.rkt")

(require rackunit/text-ui)

;;Para testes de entrada
(define lista-entrada (list "Cahorrinhos" "são" "fofinhos"))
(define lista-entrada1 (list "Bom" "dia" "jovens"))

;;Para testes de grafo
(define lista-grafo (list "a" "b" "c"))

;;para testes de centralidade
(define graph-of-test (unweighted-graph/undirected '((a b) (c d))))

;;para testes de keywords
(define lista-centralidaes (list '(a 2) '(b 5) '(c 1)))

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
        (check-true (test-BuildG))))))

(define centrality-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (graph? graph-of-test))
    (test-case
      "Testa Centrality, que recebe um grafo e retorna uma lista de pares de nós e valor da centralidade"
      (define (test-centrality)
        (pair? (car (Centrality graph-of-test)))
        (string? (car (car (Centrality graph-of-test))))
        (number? (cdr (car (Centrality graph-of-test))))
        (check-true (test-centrality))))))

(define keywords-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-centralidaes))
    (check-true (pair? (car lista-centralidaes)))
    (check-true (string? (car (car lista-centralidaes))))
    (check-true (number? (cdr (car lista-centralidaes))))
    (test-case
      "Testa Keywords, que recebe a lista de nós-centralidade e ordena as maiores"
      (define (test-keywords)
        (list? (Keywords lista-centralidaes))
        (check-true (test-keywords))))))


(run-tests centrality-suite)