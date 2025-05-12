(deffacts smartphones
  (smartphone (id sm001) (marca apple) (modelo iPhone 16) (precio 10990) (color negro) (stock 25))
  (smartphone (id sm002) (marca samsung) (modelo Note 21) (precio 9990) (color plata) (stock 40))
  (smartphone (id sm003) (marca xiaomi) (modelo redmi note 13) (precio 2990) (color azul) (stock 60))
)

(deffacts computadoras
  (computadora (id pc001) (marca dell) (modelo xps 13) (precio 12990) (color gris) (procesador intel core i7) (stock 15))
  (computadora (id pc002) (marca apple) (modelo macbook air) (precio 8990) (color plata) (procesador apple M3) (stock 20))
  (computadora (id pc003) (marca lenovo) (modelo thinkpad e14) (precio 10990) (color negro) (procesador intel core i5) (stock 12))
)

(deffacts accesorios
  (accesorio (id ac001) (nombre audifonos) (precio 49) (stock 100))
  (accesorio (id ac002) (nombre cargador-usb-c) (precio 19) (stock 150))
  (accesorio (id ac003) (nombre funda-protectora) (precio 24) (stock 200))
)

(deffacts clientes
  (cliente (id cl001) (nombre Alvaro Romero) (direccion "Lomas Altas 1232") (telefono 3337129837))
  (cliente (id cl002) (nombre Jorge Fernandez) (direccion "Tultitlan 1231") (telefono 3359876543))
  (cliente (id cl003) (nombre Luis Hernandez) (direccion "Periferico Sur 2381") (telefono 3356789123))
)

(deffacts initial-tarjetas
  (tarjeta-credito (numero 4123049127839808) (banco BBVA) (grupo Visa) (fecha-exp 12/30))
  (tarjeta-credito (numero 9827459012837131) (banco Liverpool) (grupo Visa) (fecha-exp 04/21))
  (tarjeta-credito (numero 1123012830191231) (banco Banamex) (grupo Mastercard) (fecha-exp 09/29))
)

(deffacts initial-vales
  (vale (cliente-id cli001) (cantidad 100))
  (vale (cliente-id cli002) (cantidad 200))
  (vale (cliente-id cli003) (cantidad 50))
)