object camion {
    var carga = cargamento 
    const tara = 1000

    method puedeCircularEnRuta(_nivel) {
		self.validarPuedeCircularEnRuta(_nivel)
		return not self.estaExcedidoDePeso() && (carga.cosasQueSuperan(_nivel) == #{})
	}
	method validarPuedeCircularEnRuta(_nivel) {
		if (self.estaExcedidoDePeso() || (carga.cosasQueSuperan(_nivel) != #{})) {
        self.error("no puede circular en la ruta")
        }
	}
	method estaExcedidoDePeso() {
		return self.pesoTotal() > 2500
	}
	method pesoTotal() {
		return carga.pesoTotal() + tara
	}
	method totalDeBultos() {
		return carga.totalDeBultos()
	}
	method accidente() {
		return carga.accidente()
	}
	method transportar(destino, camino) {
		self.validarTransportar(destino, camino)
        carga.transportarA(destino)
}

    method validarTransportar(destino, camino) {
		if (not camino.soportaViajeCon(self)) {
			self.error("no puede transportar cosas hacia " + destino + " en " + camino)
        }
    }

}

object cargamento {
    var cosas = #{}

    method tieneCosa(_cosa) {
		return cosas.contains(_cosa)
    }
	method cargar(_cosa) {
		self.validarCargar(_cosa)
		cosas.add(_cosa)
	}
	method validarCargar(_cosa) {
		if (self.tieneCosa(_cosa)) {
			self.error("No se puede cargar " + _cosa)
		}
	}
	method descargar(_cosa) {
		self.validarDescargar(_cosa)
		cosas.remove(_cosa)
	}
	method validarDescargar(_cosa) {
		if (not self.tieneCosa(_cosa)) {
			self.error("No se puede descargar " + _cosa)
		}
	}
	method cosaQueEsIgualDePeligrosoQue(_nivel) {
        return cosas.find({cosa => cosa.nivelDePeligrosidad() == _nivel})
    }
	method cosasQueSuperan(_nivel) {
		return cosas.filter({cosa => cosa.nivelDePeligrosidad() > _nivel})
	}
	method cosasMasPeligrosaQue(_cosa) {
		return self.cosasQueSuperan(_cosa.nivelDePeligrosidad())
	}

	method totalDeBultos() {
		return cosas.sum({cosa => cosa.bulto()})
	}
	method accidente() {
		return cosas.forEach({cosa => cosa.tieneAccidente()})
	}
	method pesoTotal() {
		return cosas.sum({cosa => cosa.peso()}) 
	}
	method transportarA(destino) {
		destino.agregarElementosDeCargamento(cosas)
		cosas.clear()
	}
	 method todosLosPesosSonPares(){
		return cosas.all({elemento => elemento.esPesoPar()})
    }
	method pesa(_peso) {
		return cosas.any({cosa => cosa.peso() == _peso})
	}

	method cosaEstaEntre(_peso1, _peso2) {
		return cosas.any({cosa => cosa.peso() >= _peso1 && cosa.peso() <= _peso2})
	}
	method cosaMasPesada() {
		self.validarCosaMasPesada()
		return cosas.max({cosa => cosa.peso()})
	} 
	method validarCosaMasPesada() {
		if (cosas.max({cosa => cosa.peso()}) == null) {
			self.error("No hay cosa más pesada")
		}
	}
	method conjuntoDePesos() {
		return cosas.map({cosa => cosa.peso()})
	}
}


object almacen {
	var elementos = #{}

	method agregarElementos(_elemento) {
		elementos.add(_elemento)
	}
	method elementos() {
		return elementos
	}
    method agregarElementosDeCargamento(_cosas) {
		_cosas.forEach({cosa => elementos.add(cosa)})
	}
}