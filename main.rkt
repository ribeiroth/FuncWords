#lang racket
(require "funcwords.rkt")
(require trace)

(provide main)

(define (main args)
  (cond [(< (vector-length args) 3) (display "FuncWords: <arquivo-texto> <nome-arquivo-saida> <porcentagem de palavras chave desejada (Ex: 0.25)>\n" (current-error-port)) (exit 1)]
        [else (null? (file->list (vector-ref args 0))) (display "Entre com um arquivo válido, por favor\n") current-error-port)) (exit 1)])
         (define file-saida (vector-ref args 1))
         (define percent (vector-ref args 2))
         (define centrality-list (Centrality (file->list (vector-ref args 0))))
         (with-output-to-file file-saida #:exists 'replace (lambda () (write (string-join (map ~a (Keywords centrality-list percent))  ", "))))
         (display "Pronto!"))
        