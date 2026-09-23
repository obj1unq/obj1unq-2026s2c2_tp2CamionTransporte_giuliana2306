import camion.*
object knightRider {

	method peso() {
		return 500
	}
	method nivelDePeligrosidad() {
		return 10
	}
	method bulto () {
		return 1
	}
	method tieneAccidente () {
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object arenaAGranel {
	var peso = 0

	method peso() {
		return peso
	}
	method nivelDePeligrosidad() {
		return 1
	}
	method cambiarPeso(_peso) {
		peso = _peso
	}
	method bulto () {
		return 1
	}
	method tieneAccidente () {
		peso = peso + 20
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object bumblebee {
	var transformacion = auto

	method peso() {
		return 800
	}
	method nivelDePeligrosidad() {
		return transformacion.nivelDePeligrosidad()
	}
	method cambiarTransformacion(_transformacion) {
		transformacion = _transformacion
	}
	method bulto () {
		return 2
	}
	method tieneAccidente () {
		if (transformacion == auto) {
			transformacion = robot
		} else {
			transformacion = auto
		}
	}
	method transformacion() {
		return transformacion
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object robot {

	method nivelDePeligrosidad() {
		return 30
	}
}

object auto {
	method nivelDePeligrosidad() {
		return 15
	}
}

object paqueteDeLadrillos {
	var ladrillos = 0

	method peso() {
		return ladrillos *2
	}
	method ladrillos(_ladrillos) {
		ladrillos = _ladrillos
	}
	method bulto() {
    if (ladrillos <= 100) {
        return 1
    } else {
        if (ladrillos <= 300) {
            return 2
        } else {
            return 3
        }
    }
    }
	method tieneAccidente () {
		if (ladrillos < 12) {
			ladrillos = 0
		} else {
			ladrillos = ladrillos - 12
		}
	}
	method nivelDePeligrosidad() {
		return 2
	}
	method cantDeLadrillos() {
		return ladrillos
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object bateriaAntiaerea {
	var peso = 200
	var nivelDePeligrosidad = 0
	var tieneMisiles = false

	method peso() {
		return peso
	}
	method nivelDePeligrosidad() {
		return nivelDePeligrosidad
	}
	method ponerMisiles() {
    tieneMisiles = true
    peso = peso + 100
    nivelDePeligrosidad = 100
}
	method bulto() {
		if (tieneMisiles == true) {
			return 2
		} else {
			return 1
		}
	}
	method tieneAccidente () {
		tieneMisiles = false
	}
	method estaCargada() {
		return tieneMisiles
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object residuosRadioactivos {
	var peso = 0

	method peso () {
		return peso
	}
	method cambiarPeso(_peso) {
		peso = _peso
	}
	method nivelDePeligrosidad() {
		return 200
	}
	method bulto() {
		return 1
	}
	method tieneAccidente() {
		peso = peso + 15
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object contenedorPortuario {
	var contenido = []

	method agregarContenido(_contenido) {
		contenido.add(_contenido)
	}
	method contenido() {
		return contenido 
	}
	method peso() {
		return 100 + contenido.sum({cosa => cosa.peso()})
	}
	method nivelDePeligrosidad() {
		if (contenido == []) {
			return 0
		} else {
          return contenido.max({cosa => cosa.nivelDePeligrosidad()}).nivelDePeligrosidad()
		}
	}
	method bulto() {
		return 1 + contenido.sum({cosa => cosa.bulto()})
	}
	method tieneAccidente() {
		contenido.forEach({cosa => cosa.tieneAccidente()})
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object embalajeDeSeguridad {
	var envuelto = null

	method envuelveA(_cosa) {
		envuelto = _cosa
	}
	method peso() {
		return envuelto.peso()
	}
	method nivelDePeligrosidad() {
		return envuelto.nivelDePeligrosidad() / 2
	}
	method bulto() {
		return 2
	}
	method tieneAccidente() {
	}
	method esPesoPar() {
		return self.peso() % 2 == 0
    }
}

object ruta9 {

    method nivelDePeligrosidad() {
        return 20
    }
    method soportaViajeCon(vehiculo) {
        return vehiculo.puedeCircularEnRuta(self.nivelDePeligrosidad())
    }
}

object caminosVecinales {

    var pesoMaximo = 0

    method configurarPesoMaximo(_peso) {
        pesoMaximo = _peso
    }
    method soportaViajeCon(vehiculo) {
        return vehiculo.pesoTotal() <= pesoMaximo
    }
}
