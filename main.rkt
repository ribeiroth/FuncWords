#lang racket
(require "funcwords.rkt")

(define (main args)
  (cond [(< (vector-length args) 2) (display "FuncWords: <arquivo-texto> <nome-arquivo-saida>\n" (current-error-port)) (exit 1)])
         (define file-saida (vector-ref args 1))
         (define centrality-list (Centrality (file->list (vector-ref args 0))))
         (with-output-to-file file-saida #:exists 'replace (lambda () (write (Keywords centrality-list)))))
        