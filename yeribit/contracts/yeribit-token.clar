;; Yeribit fungible token (basic SIP-010-compatible interface)

(define-fungible-token yeri)

(define-data-var contract-owner principal tx-sender)

(define-data-var token-name (string-utf8 32) u"Yeribit Token")
(define-data-var token-symbol (string-utf8 10) u"YERI")
(define-data-var token-decimals uint u6)
(define-data-var token-uri (optional (string-utf8 256)) none)

(define-constant ERR_UNAUTHORIZED u1000)

;; SIP-010 read-only interface
(define-read-only (get-name)
  (ok (var-get token-name))
)

(define-read-only (get-symbol)
  (ok (var-get token-symbol))
)

(define-read-only (get-decimals)
  (ok (var-get token-decimals))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply yeri))
)

(define-read-only (get-balance (who principal))
  (ok (ft-get-balance yeri who))
)

(define-read-only (get-token-uri)
  (ok (var-get token-uri))
)

;; Public functions
(define-public (transfer (recipient principal) (amount uint) (memo (optional (buff 34))))
  (begin
    (try! (ft-transfer? yeri amount tx-sender recipient))
    (ok true)
  )
)

(define-public (mint (recipient principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR_UNAUTHORIZED))
    (try! (ft-mint? yeri amount recipient))
    (ok true)
  )
)

(define-public (burn (amount uint))
  (begin
    (try! (ft-burn? yeri amount tx-sender))
    (ok true)
  )
)

(define-public (set-token-uri (new-uri (optional (string-utf8 256))))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR_UNAUTHORIZED))
    (var-set token-uri new-uri)
    (ok true)
  )
)

(define-public (set-owner (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR_UNAUTHORIZED))
    (var-set contract-owner new-owner)
    (ok true)
  )
)
