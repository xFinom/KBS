(load templates.clp)
(load facts.clp)
(load functions.clp)
(load rules.clp)
(reset)
(facts)

;; Asserts para comprobar regla de 24 msi iPhone 16 con tarjeta Banamex
(assert (line-item (id li001) (product-id sm001) (product-tipo smartphone) (cantidad 3)))
(assert (orden-compra (order-number or001) (cliente-id cl001) (line-item li001) (parcialidades 3) (tarjeta-credito 1123012830191231)))

;; Asserts para comprobar regla de 12 msi Samsung Note 21 con tarjeta liverpool visa
(assert (line-item (id li002) (product-id sm002) (product-tipo smartphone) (cantidad 10)))
(assert (orden-compra (order-number or002) (cliente-id cl003) (line-item li002) (parcialidades 1) (tarjeta-credito 9827459012837131)))

;; Asserts para comprobar regla de vales por orden con macbook air e iphone 16
(assert (line-item (id li003) (product-id pc002) (product-tipo computadora) (cantidad 1)))
(assert (line-item (id li004) (product-id sm001) (product-tipo smartphone) (cantidad 1)))
(assert (orden-compra (order-number or003) (cliente-id cl002) (line-item li003 li004) (parcialidades nil) (tarjeta-credito nil)))

(run)
