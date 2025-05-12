;; 01. Promoción 24 msi en compra de iPhone 16 con tarjeta Banamex
(defrule promo-iphone-16-banamex
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
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

;; 02. Promoción 12 msi en compra de Samsung Note 21 con tarjeta Liverpool Visa
(defrule promo-note-21-liverpool-visa
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
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

;; 03. Promoción 100 pesos en vales por cada 1000 pesos de compra al comprar una MacBook Air y un iPhone 16 de contado
(defrule promo-vales-macbook-iphone
    ?orden <- (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?line-items))
    =>
    (bind ?total (total-orden ?line-items))
    (printout t "El total de la compraasdasdas: " ?total crlf)
)

;; 04. Promoción 15% en accesorios al comprar un smartphone
(defrule promo-accesorios-smartphone
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?))
    (line-item 
        (id ?li-id)
        (product-tipo smartphone))
    =>
    (printout t "Promoción: El cliente " ?cliente-id
                " califica para 15% de descuento en una funda o mica por compra de smartphone en la orden: " ?numero-orden crlf)
)

;; 05. Determinar si un cliente es mayorista o menudista (WIP)
(defrule cliente-mayorista-minorista
    (orden-compra 
        (order-number ?numero-orden) 
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?))
    (line-item 
        (id ?li-id)
        (cantidad ?cantidad))
    (test (> ?cantidad 10))
    (cliente
        (id ?cliente-id)
        (nombre ?cliente-nombre))
    =>
    (printout t "El cliente " ?cliente-nombre " es mayorista" crlf)
)

;; 06. Actualizar e imprimir el stock
;; TODO

;; 07. Promoción 100 pesos en vales al comprar un Redmi Note 13
(defrule promo-redmi-note-13
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?))
    (line-item 
        (id ?li-id) 
        (product-id sm003))
    =>
    (printout t "Promoción: El cliente " ?cliente-id 
                " califica para un vale de 100 pesos en la compra Redmi Note 13 por su orden: " ?numero-orden crlf)
    (assert (vale (cliente-id ?cliente-id) (cantidad 100)))
)

;; 08. Promoción 5% en smartphones al comprar una xps 13 a 6 meses
(defrule promo-macbook-pro-smartphone
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?)
        (parcialidades 6)) ;; pago a 6 meses
    (line-item 
        (id ?li-id)
        (product-id pc001)) ;; ID de xps 13
    =>
    (printout t "Promoción: El cliente " ?cliente-id
                " califica para 15% de descuento en una funda o mica por compra de smartphone en la orden: " ?numero-orden crlf)
)

;; 09. Promoción 250 pesos en vales al comprar una computadora
(defrule promo-computadora-vale
    (orden-compra 
        (order-number ?numero-orden) 
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?))
    (line-item 
        (id ?li-id)
        (product-tipo computadora))
    =>
    (printout t "Promoción: El cliente " ?cliente-id
                " califica un vale de 250 pesos por compra de computadora en la orden: " ?numero-orden crlf)
    (assert (vale (cliente-id ?cliente-id) (cantidad 250)))
)

;; 10. Promoción 10% en compra realizada con tarjeta de credito BBVA Visa
(defrule promo-bbva-visa-10
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (tarjeta-credito ?tc-num))
    (tarjeta-credito 
        (numero ?tc-num) 
        (banco BBVA)
        (grupo Visa))
    =>
    (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 10% de descuento al pagar con tarjeta de credito BBVA Visa por su orden: " ?numero-orden crlf)
)

;; 11. Calcula el total de la compra
(defrule total-compra
    ?orden <- (orden-compra 
        (order-number ?numero-orden)
        (line-item $?line-items))
    =>
    (bind ?total (total-orden ?line-items))
    (printout t "El total de la compra " ?numero-orden " es: " ?total crlf)
)

;; 12. En compras mayores a 12,000, se da un vale de 1,000 al pagar con BBVA Visa
(defrule promo-bbva-vale-1000
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?line-items)
        (tarjeta-credito ?tc-num))
    (tarjeta-credito
        (numero ?tc-num)
        (banco BBVA)
        (grupo Visa))
    =>
    (bind ?total (total-orden ?line-items))
    (if (> ?total 12000) then
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para un vale de 1,000 pesos por compra mayor a 12,000 al pagar con tarjeta de credito BBVA Visa por su orden: " ?numero-orden crlf)
        (assert (vale (cliente-id ?cliente-id) (cantidad 1000)))
    )
)

;; 13. 