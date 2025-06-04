;; Facility Verification Contract
;; Validates and manages waste management facilities

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_FACILITY_EXISTS (err u101))
(define-constant ERR_FACILITY_NOT_FOUND (err u102))
(define-constant ERR_INVALID_STATUS (err u103))

;; Facility status types
(define-constant STATUS_PENDING u0)
(define-constant STATUS_VERIFIED u1)
(define-constant STATUS_SUSPENDED u2)
(define-constant STATUS_REVOKED u3)

;; Data structures
(define-map facilities
  { facility-id: uint }
  {
    owner: principal,
    name: (string-ascii 100),
    location: (string-ascii 200),
    facility-type: (string-ascii 50),
    capacity: uint,
    status: uint,
    verified-at: uint,
    verifier: (optional principal)
  }
)

(define-map facility-counter { id: uint } { count: uint })
(define-data-var next-facility-id uint u1)

;; Authorized verifiers
(define-map verifiers { verifier: principal } { authorized: bool })

;; Initialize contract
(map-set facility-counter { id: u0 } { count: u0 })
(map-set verifiers { verifier: CONTRACT_OWNER } { authorized: true })

;; Public functions

;; Register a new facility
(define-public (register-facility (name (string-ascii 100)) (location (string-ascii 200)) (facility-type (string-ascii 50)) (capacity uint))
  (let ((facility-id (var-get next-facility-id)))
    (asserts! (is-none (map-get? facilities { facility-id: facility-id })) ERR_FACILITY_EXISTS)
    (map-set facilities
      { facility-id: facility-id }
      {
        owner: tx-sender,
        name: name,
        location: location,
        facility-type: facility-type,
        capacity: capacity,
        status: STATUS_PENDING,
        verified-at: u0,
        verifier: none
      }
    )
    (var-set next-facility-id (+ facility-id u1))
    (ok facility-id)
  )
)

;; Verify a facility (only authorized verifiers)
(define-public (verify-facility (facility-id uint))
  (let ((facility (unwrap! (map-get? facilities { facility-id: facility-id }) ERR_FACILITY_NOT_FOUND)))
    (asserts! (default-to false (get authorized (map-get? verifiers { verifier: tx-sender }))) ERR_UNAUTHORIZED)
    (map-set facilities
      { facility-id: facility-id }
      (merge facility {
        status: STATUS_VERIFIED,
        verified-at: block-height,
        verifier: (some tx-sender)
      })
    )
    (ok true)
  )
)

;; Update facility status
(define-public (update-facility-status (facility-id uint) (new-status uint))
  (let ((facility (unwrap! (map-get? facilities { facility-id: facility-id }) ERR_FACILITY_NOT_FOUND)))
    (asserts! (default-to false (get authorized (map-get? verifiers { verifier: tx-sender }))) ERR_UNAUTHORIZED)
    (asserts! (<= new-status STATUS_REVOKED) ERR_INVALID_STATUS)
    (map-set facilities
      { facility-id: facility-id }
      (merge facility { status: new-status })
    )
    (ok true)
  )
)

;; Add authorized verifier (only contract owner)
(define-public (add-verifier (verifier principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (map-set verifiers { verifier: verifier } { authorized: true })
    (ok true)
  )
)

;; Read-only functions

;; Get facility details
(define-read-only (get-facility (facility-id uint))
  (map-get? facilities { facility-id: facility-id })
)

;; Check if facility is verified
(define-read-only (is-facility-verified (facility-id uint))
  (match (map-get? facilities { facility-id: facility-id })
    facility (is-eq (get status facility) STATUS_VERIFIED)
    false
  )
)

;; Check if principal is authorized verifier
(define-read-only (is-authorized-verifier (verifier principal))
  (default-to false (get authorized (map-get? verifiers { verifier: verifier })))
)
