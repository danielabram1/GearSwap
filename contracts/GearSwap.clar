;; GearSwap: Outdoor Equipment Sharing Platform
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-EQUIPMENT-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-LISTED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-DURATION (err u5))
(define-constant ERR-INVALID-CATEGORY (err u6))
(define-constant ERR-INVALID-CONDITION (err u7))
(define-constant ERR-INVALID-NAME (err u8))
(define-constant ERR-INVALID-DESCRIPTION (err u9))
(define-constant MIN-DURATION u1)
(define-data-var next-equipment-id uint u1)
(define-map equipment-listings
    uint
    {
        owner: principal,
        equipment-name: (string-utf8 50),
        description: (string-utf8 200),
        category: (string-utf8 15),
        condition: (string-utf8 15),
        status: (string-utf8 10),
        max-loan-days: uint
    }
)
(define-private (validate-category (category (string-utf8 15)))
    (or 
        (is-eq category u"Camping")
        (is-eq category u"Hiking")
        (is-eq category u"Climbing")
        (is-eq category u"Skiing")
        (is-eq category u"Watersports")
        (is-eq category u"Cycling")
    )
)
(define-private (validate-condition (condition (string-utf8 15)))
    (or 
        (is-eq condition u"New")
        (is-eq condition u"Excellent")
        (is-eq condition u"Good")
        (is-eq condition u"Fair")
        (is-eq condition u"Well-used")
    )
)
(define-private (validate-text-length (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (&lt;= text-length max-length)
        )
    )
)
(define-public (list-equipment 
    (equipment-name (string-utf8 50))
    (description (string-utf8 200))
    (category (string-utf8 15))
    (condition (string-utf8 15))
    (max-loan-days uint)
)
    (let
        (
            (equipment-id (var-get next-equipment-id))
        )
        (asserts! (validate-text-length equipment-name u3 u50) ERR-INVALID-NAME)
        (asserts! (validate-text-length description u10 u200) ERR-INVALID-DESCRIPTION)
        (asserts! (>= max-loan-days MIN-DURATION) ERR-INVALID-DURATION)
        (asserts! (validate-category category) ERR-INVALID-CATEGORY)
        (asserts! (validate-condition condition) ERR-INVALID-CONDITION)
        
        (map-set equipment-listings equipment-id {
            owner: tx-sender,
            equipment-name: equipment-name,
            description: description,
            category: category,
            condition: condition,
            status: u"available",
            max-loan-days: max-loan-days
        })
        (var-set next-equipment-id (+ equipment-id u1))
        (ok equipment-id)
    )
)
(define-public (remove-equipment (equipment-id uint))
    (let
        (
            (listing (unwrap! (map-get? equipment-listings equipment-id) ERR-EQUIPMENT-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get owner listing)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get status listing) u"available") ERR-INVALID-STATUS)
        (ok (map-set equipment-listings equipment-id (merge listing { status: u"unavailable" })))
    )
)
(define-read-only (get-equipment (equipment-id uint))
    (ok (map-get? equipment-listings equipment-id))
)
(define-read-only (get-owner (equipment-id uint))
    (ok (get owner (unwrap! (map-get? equipment-listings equipment-id) ERR-EQUIPMENT-NOT-FOUND)))
)