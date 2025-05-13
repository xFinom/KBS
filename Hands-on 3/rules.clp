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
(defrule promo-vales-combo-apple-funcion
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?lineItems)
        (tarjeta-credito nil))
    (line-item (id ?itemId1) (product-id pc002))
    (line-item (id ?itemId2) (product-id sm001))
    (test (member$ ?itemId1 ?lineItems))
    (test (member$ ?itemId2 ?lineItems))

    =>
    (bind ?total (total-orden ?lineItems))
    (if (>= ?total 1000) then
        (bind ?vales (* (div ?total 1000) 100))
        (printout t "Promocion: El cliente " ?cliente-id " recibirá " ?vales " pesos en vales de descuento por su orden: " ?numero-orden crlf)
        (assert (vale (cliente-id ?cliente-id) (cantidad ?vales)))
    )
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

;; 05. Determinar si un cliente es mayorista o menudista
(defrule clasificar-cliente-por-volumen
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?lineItems))
    =>
    (bind ?total (total-productos-orden $?lineItems))
    (if (>= ?total 10) then
        (printout t "El cliente " ?cliente-id " es mayorista" crlf)
    else
        (printout t "El cliente " ?cliente-id " es menudista" crlf)
    )
)

;; 06. Actualizar e imprimir el stock
(defrule actualizar-stock-post-orden
    (orden-compra 
        (order-number ?orden) 
        (line-item $?items))
    (line-item 
        (id ?li-id) 
        (product-id ?pid) 
        (product-tipo ?tipo) 
        (cantidad ?qty))
    (test (member$ ?li-id ?items))
    =>
    (if (eq ?tipo smartphone) then
        (do-for-fact ((?p smartphone)) (eq ?p:id ?pid)
        (bind ?nuevo-stock (- ?p:stock ?qty))
        (modify ?p (stock ?nuevo-stock))
        (printout t "Nuevo stock de smartphone " ?pid ": " ?nuevo-stock crlf)))

    (if (eq ?tipo computadora) then
        (do-for-fact ((?p computadora)) (eq ?p:id ?pid)
        (bind ?nuevo-stock (- ?p:stock ?qty))
        (modify ?p (stock ?nuevo-stock))
        (printout t "Nuevo stock de computadora " ?pid ": " ?nuevo-stock crlf)))

    (if (eq ?tipo accesorio) then
        (do-for-fact ((?p accesorio)) (eq ?p:id ?pid)
        (bind ?nuevo-stock (- ?p:stock ?qty))
        (modify ?p (stock ?nuevo-stock))
        (printout t "Nuevo stock de accesorio " ?pid ": " ?nuevo-stock crlf)))
)

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

;; 13. Promoción 10% de descuento al comprar más de 10 productos
(defrule promo-descuento-10-productos
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?lineItems))
    =>
    (bind ?total (total-productos-orden $?lineItems))
    (if (> ?total 10) then
        (printout t "Promocion: El cliente " ?cliente-id 
                " califica para un 15% de descuento por comprar más de 10 productos en la orden: " ?numero-orden crlf))
)

;; 14. Promoción 5% de descuento al comprar entre 6 y 10 productos
(defrule promo-descuento-orden-mediana
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $?lineItems))
    =>
    (bind ?total (total-productos-orden $?lineItems))
    (if (and (>= ?total 6) (<= ?total 10)) then
            (printout t "Promocion: El cliente " ?cliente-id 
                " califica para un 5% de descuento por comprar entre 6 y 10 productos en la orden: " ?numero-orden crlf))
)

;; 15. Promoción accesorio de regalo al comprar más de 15 productos
(defrule regalo-por-compra-mayor
  (orden-compra 
    (order-number ?numero-orden)
    (cliente-id ?cliente-id)
    (line-item $?lineItems))
  =>
  (bind ?total (total-productos-orden $?lineItems))
  (if (> ?total 15) then
        (printout t "Promocion: El cliente " ?cliente-id 
              " recibirá un accesorio de regalo por comprar más de 15 productos en la orden: " ?numero-orden crlf))
)

;; 16. Promoción 24 msi en compra de Note 21 con tarjeta BBVA
(defrule promo-note-21-bbva
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
        (banco BBVA))
    =>
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 24 meses sin intereses al comprar un Note 21 con Tarjeta de Credito BBVA por su orden: " ?numero-orden crlf)
)

;; 17. Promocion 18 msi en compra de thinkpad e14 con tarjeta santander
(defrule promo-thinkpad-e14-bbva
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?)
        (tarjeta-credito ?tc-num))
    (line-item 
        (id ?li-id) 
        (product-id pc003))
    (tarjeta-credito 
        (numero ?tc-num) 
        (banco Santander))
    =>
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 18 meses sin intereses al comprar un iPhone 16 con Tarjeta de Credito Banamex por su orden: " ?numero-orden crlf)
)

;; 18. Promocion 50 en vales en compra de funda protectora
(defrule promo-vales-funda
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (line-item $? ?li-id $?)
        (tarjeta-credito ?tc-num))
    (line-item 
        (id ?li-id) 
        (product-id ac003))
    (tarjeta-credito 
        (numero ?tc-num) 
        (banco Santander))
    =>
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para un vale de 50 pesos al comprar una funda protectora por su orden: " ?numero-orden crlf)
        (assert (vale (cliente-id ?cliente-id) (cantidad 50)))
)

;; 19. Promocion 10% de descuento al comprar con una tarjeta de credito visa
(defrule promo-visa-tdc-10
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (tarjeta-credito ?tc-num))
    (tarjeta-credito 
        (numero ?tc-num) 
        (grupo Visa))
    =>
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 15% de descuento al pagar con una tarjeta de credito visa en la orden: " ?numero-orden crlf)
)

;; 20. Promocion 5% de desucento al comprar con una tarjeta de credito mastercard
(defrule promo-mastercard-tdc-5
    (orden-compra 
        (order-number ?numero-orden)
        (cliente-id ?cliente-id)
        (tarjeta-credito ?tc-num))
    (tarjeta-credito 
        (numero ?tc-num) 
        (grupo Mastercard))
    =>
        (printout t "Promoción: El cliente " ?cliente-id 
                " califica para 15% de descuento al pagar con una tarjeta de credito visa en la orden: " ?numero-orden crlf)
)