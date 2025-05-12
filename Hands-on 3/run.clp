(load templates.clp)
(load facts.clp)
(load functions.clp)
(load rules.clp)

(reset)

;; (facts)

;; Asserts para comprobar regla de 24 msi iPhone 16 con tarjeta Banamex
(assert (line-item (id li001) (product-id sm001) (product-tipo smartphone) (cantidad 3)))
(assert (orden-compra (order-number or001) (cliente-id cl001) (line-item li001) (parcialidades 3) (tarjeta-credito 1123012830191231)))

;; Asserts para comprobar regla de 12 msi Samsung Note 21 con tarjeta liverpool visa
(assert (line-item (id li002) (product-id sm002) (product-tipo smartphone) (cantidad 4)))
(assert (orden-compra (order-number or002) (cliente-id cl003) (line-item li002) (parcialidades 1) (tarjeta-credito 9827459012837131)))

(run)