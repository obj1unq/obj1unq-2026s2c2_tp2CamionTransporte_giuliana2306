object knightRider {

	method peso() {
		return 500
	}
	method nivelDePeligrosidad() {
		return 1
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
}

object bateriaAntiaerea {
	var misiles = true

	method peso() {
		if (misiles == true) {
			return 300
		} else {
			return 200
		}
	}
	method noTieneMisiles() {
		misiles = false
	}
	method nivelDePeligrosidad() {
		return 2
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
}

