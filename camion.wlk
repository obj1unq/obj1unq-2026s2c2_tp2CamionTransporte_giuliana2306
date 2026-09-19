import cosas.*

object camion {
	var cosas  = #{}
	const tara = 1000

	method tieneCosa(_cosa) {
		return cosas.any({cosa => cosa == _cosa})
	}
	method tara() {
		return tara
	}
	method cosas() {
		return cosas
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
		self.validarCosaQueEsIgualDePeligrosoQue(_nivel)
		return cosas.find({cosa => cosa.nivelDePeligrosidad() == _nivel})
	}
	method validarCosaQueEsIgualDePeligrosoQue(_nivel) {
		if (cosas.find({cosa => cosa.nivelDePeligrosidad() == _nivel}) == null) {
			self.error("No hay cosa con el nivel" + _nivel)
		}
	}
	method cosasQueSuperan(_nivel) {
		return cosas.filter({cosa => cosa.nivelDePeligrosidad() > _nivel})
	}
	method cosasMasPeligrosaQue(_cosa) {
		return self.cosasQueSuperan(_cosa.nivelDePeligrosidad())
	}
	method puedeCircularEnRuta(_nivel) {
		self.validarPuedeCircularEnRuta(_nivel)
		return not peso.estaExcedidoDePeso(cosas,tara) && (self.cosasQueSuperan(_nivel) == #{})
	}
	method validarPuedeCircularEnRuta(_nivel) {
		if (peso.estaExcedidoDePeso(cosas,tara) || (self.cosasQueSuperan(_nivel) != #{})) {
        self.error("no puede circular en la ruta")
        }
	}

	method pesoTotal() {
		return peso.pesoTotal(cosas,tara) 
	}
	method totalDeBultos() {
		return cosas.sum({cosa => cosa.bulto()})
	}
	method accidente() {
		return cosas.forEach({cosa => cosa.tieneAccidente()})
	}
	method transportar(destino, camino) {
		self.validarTransportar(destino, camino)
		destino.agregarElementosDeCamion(cosas)
		cosas.clear()
}

    method validarTransportar(destino, camino) {
		if (not camino.soportaViajeCon(self)) {
			self.error("no puede transportar cosas hacia " + destino + " en " + camino)
        }
    }
}
object peso {

	method todosSonPares(_cosas) {
		return _cosas.all({cosa => cosa.peso() % 2 == 0})
	}
	method pesa(_cosas, _peso) {
		return _cosas.any({cosa => cosa.peso() == _peso})
	}
	method pesoTotal(_cosas, tara) {
		return _cosas.sum({cosa => cosa.peso()}) + tara
	} 
	method estaExcedidoDePeso(_cosas,tara) {
		return self.pesoTotal(_cosas,tara) > 2500
	}
	method cosaEstaEntre(_cosas, _peso1, _peso2) {
		return _cosas.any({cosa => cosa.peso() >= _peso1 && cosa.peso() <= _peso2})
	}
	method cosaMasPesada(_cosas) {
		self.validarCosaMasPesada(_cosas)
		return _cosas.max({cosa => cosa.peso()})
	} 
	method validarCosaMasPesada(_cosas) {
		if (_cosas.max({cosa => cosa.peso()}) == null) {
			self.error("No hay cosa más pesada")
		}
	}
	method conjuntoDePesos(_cosas) {
		return _cosas.map({cosa => cosa.peso()})
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
    method agregarElementosDeCamion(_cosas) {
		_cosas.forEach({cosa => elementos.add(cosa)})
	}
}