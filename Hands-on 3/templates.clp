(deftemplate smartphone
    (slot id)
    (slot marca)
    (multislot modelo)
    (slot precio)
    (slot color)
    (slot stock)
)

(deftemplate computadora
    (slot id)
    (slot marca)
    (multislot modelo)
    (slot precio)
    (slot color)
    (multislot procesador)
    (slot stock)
)

(deftemplate accesorio
    (slot id)
    (slot nombre)
    (slot precio)
    (slot stock)
)

(deftemplate cliente
    (slot id)
    (multislot nombre)
    (multislot direccion)
    (slot telefono)
)

(deftemplate line-item
    (slot id)
    (slot product-id)
    (slot product-tipo) 
    (slot cantidad (default 1))
)

(deftemplate orden-compra
    (slot order-number)
    (slot cliente-id)
    (multislot line-item)
    (slot parcialidades)
    (slot tarjeta-credito)

)

(deftemplate tarjeta-credito
    (slot numero)
    (slot banco)
    (slot grupo)
    (slot fecha-exp)
)

(deftemplate vale
    (slot cliente-id)
    (slot cantidad)
)