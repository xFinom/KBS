;; Promoción 24 msi en compra de iPhone 16 con tarjeta Banamex
(defrule promo-iphone-16-banamx
    (orden-compra 
        (order-number ?numero-orden)
        (customer-id ?cliente-id)
        (line-item $? ?li-id $?)
        (tarjeta-credito ?tc-num))
    (line-item 
        (id ?li-id) 
        (product-id sm001))
    (tarjeta-credito 
        (numero ?tc-num) 
        (banco Banamex))
    =>
    (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 24 meses sin intereses al comprar un iPhone 16 con Tarjeta de Credito Banamex por su orden: " ?numero-orden crlf)
)

;; Promoción 12 msi en compra de Samsung Note 21 con tarjeta Liverpool Visa
(defrule promo-note-21-liverpool-visa
    (orden-compra 
        (order-number ?numero-orden)
        (customer-id ?cliente-id)
        (line-item $? ?li-id $?)
        (tarjeta-credito ?tc-num))
    (line-item 
        (id ?li-id) 
        (product-id sm002))
    (tarjeta-credito 
        (numero ?tc-num) 
        (banco Liverpool)
        (grupo Visa))
    =>
    (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 12 meses sin intereses al comprar un Samsung Note 21 con Tarjeta de Credito Liverpool Visa por su orden: " ?numero-orden crlf)
)

;; Promoción 100 pesos en vales por cada 1000 pesos de compra el comprar una MacBook Air y un iPhone 16 de contado
;; TODO

;; Promoción 15% en accesorios al comprar de contado una MacBook Air y un iPhone 16
(defrule promo-accesorios-smartphone
    (orden-compra 
        (order-number ?numero-orden) 
        (line-item $? ?li-id $?))
    (line-item 
        (id ?li-id)
        (product-tipo smartphone))
    =>
    (printout t "Promoción: El cliente " ?numero-orden 
                " califica para 15% de descuento en una funda o mica por compra de smartphone en la orden: " ?numero-orden crlf)
)

;; Determinar si un cliente es mayorista o menudista
;; TODO

;; Actualizar e imprimir el stock
;; TODO