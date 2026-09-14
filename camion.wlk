import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
		
	method cargar(_cosa) {
		self.validarCargar(_cosa)
		cosas.add(_cosa)
	}
	method validarCargar(_cosa) {
		if (tieneCosa(_cosa)) {
			self.error("No se puede cargar" +_cosa)
		}
	}
	method tieneCosa(_cosa) {
		cosas.any({cosa => cosa == _cosa})
	}
    method descargar(_cosa) {
		self.validarDescargar(_cosa)
		cosas.remove(_cosa)
	}
	method validarDescargar(_cosa) {
		if (not tieneCosa(_cosa)) {
			self.error("No se puede descargar" + _cosa)
		}
	}
	method elPesoEsPar() {
		return cosas.all({elemento => elemento.peso() % 2 ==0})
	}
	method pesa(_peso) {
		return cosas.any({elemento => elemento.peso() == _peso})
	}
	method pesoTotalDelCamion() {
		return cosas.sum({elemento => elemento.peso()}) + tara
	}
	method estaExcedidoDePeso() {
		return self.pesoTotalDelCamion() > 2500
	}
	method elementoConNivel(_nivel) {
		self.validarElementoConNivel(_nivel)
		return cosas.filter({elemento => elemento.nivelDePeligrosidad() == _nivel}).first()
	}
	method validarElementoConNivel(_nivel) {
		if (cosas.filter({elemento => elemento.nivelDePeligrosidad() == _nivel}).isEmpty()) {
			self.error("No hay elementos con nivel" + _nivel)
		}
	}
	method cosasQueSuperan(_nivel) {
		return cosas.filter({elemento => elemento.nivelDePeligrosidad() > _nivel})
	}
	method cosasMasPeligrosaQue(_cosa) {
		return self.cosasQueSuperan(_cosa.nivelDePeligrosidad())
	}
}
