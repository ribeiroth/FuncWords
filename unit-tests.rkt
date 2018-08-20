#lang racket

(require graph)
(require rackunit "funcwords.rkt")

(require rackunit/text-ui)

;;Para testes de grafo
(define lista-grafo (list "a" "b" "c" "d" "e"))

;;para testes de centralidade/grafo
(define lista-palavras (list "palavras" "podem" "mudar" "mundo" "palavras" "controlam" "destinos"))
(define graph-of-test (unweighted-graph/undirected '(("palavras" "podem") ("podem" "mudar") ("mudar" "mundo") ("mundo" "palavras") ("palavras" "controlam") ("controlam" "destinos"))))

;;para testes de keywords
(define lista-centralidades (list (cons"a" (/ 2 3)) (cons "b" (/ 3 5)) (cons "c" (/ 6 3))))

(define graph-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-grafo))
    (check-true  (graph? graph-of-test))
    (test-case
      "Testa BuildG, que recebe uma lista de palavras e retorna um grafo não orientado"
      (define (test-BuildG)
        (graph? (BuildG lista-grafo))
        (graph? (BuildG lista-palavras))
        (equal? graph-of-test (BuildG lista-palavras))
        (equal? (get-neighbors graph-of-test "palavras") (get-neighbors (BuildG lista-palavras) "palavras"))
        (has-edge? (BuildG lista-grafo) "b" "c")
        (not (has-edge? (BuildG lista-grafo) "a" "c")))
        (check-true (test-BuildG)))))

(define centrality-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-palavras))
    (test-case
      "Testa Centrality, que recebe uma lista de palavras, chama BuildG, e a partir do resultado retorna uma lista de pares de nó - valor da centralidade"
      (define (test-centrality)
        (pair? (car (Centrality lista-palavras)))
        (string? (car (car (Centrality lista-palavras))))
        (number? (cdr (car (Centrality lista-palavras)))))
        (check-true (test-centrality)))))

(define keywords-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-centralidades))
    (check-true (pair? (car lista-centralidades)))
    (check-true (string? (car (car lista-centralidades))))
    (check-true (number? (cdr (car lista-centralidades))))
    (test-case
      "Testa Keywords, que recebe a lista de nós-centralidade, a porcentagem de palavras pra retornar e retorna uma lista com as palavras de maior ocorrencia"
      (define (test-keywords)
        (list? (Keywords lista-centralidades 0.25))
        (equal? "c" (car (Keywords lista-centralidades 0.25))))
        (check-true (test-keywords)))))

(define calc-Centrality-suite
  (test-suite
    "Testando dados usados nos testes"
    (check-true  (list? lista-centralidades))
    (check-true (pair? (car lista-centralidades)))
    (check-true (string? (car (car lista-centralidades))))
    (check-true (number? (cdr (car lista-centralidades))))
    (test-case
      "Testa Keywords, que recebe a lista de nós-centralidade, a porcentagem de palavras pra retornar e retorna uma lista com as palavras de maior ocorrencia"
      (define (test-keywords)
        (list? (Keywords lista-centralidades 0.25))
        (equal? "c" (car (Keywords lista-centralidades 0.25))))
        (check-true (test-keywords)))))

(display "Testando BuildG \n")
(run-tests graph-suite)

(display "Testando Centrality \n")
(run-tests centrality-suite)

(display "Testando Keywords \n")
(run-tests keywords-suite)