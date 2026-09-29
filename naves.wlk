class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method velocidad() = velocidad
  method direccion() = direccion
  method combustible() = combustible

  // Velocidad
  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(100000)
  }

  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }

  // Dirección
  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }

  // Combustible
  method cargarCombustible(litros) {
    combustible = combustible + litros
  }

  method descargarCombustible(litros) {
    combustible = (combustible - litros).max(0)
  }

  // Viaje
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  // Tranquilidad
  method estaTranquila() = combustible >= 4000 && velocidad <= 12000

  // Amenazas
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method escapar()

  method avisar()

  // Relajo
  method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()

  method tienePocaActividad()
}

class NaveBaliza inherits Nave {
  var colorDeBaliza = "azul"
  var cambioDeColor = false

  method colorDeBaliza() = colorDeBaliza

  method cambiarColorDeBaliza(colorNuevo) {
    colorDeBaliza = colorNuevo
    cambioDeColor = true
  }

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() = super() && colorDeBaliza != "rojo"

  override method escapar() {
    self.irHaciaElSol()
  }

  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }

  override method tienePocaActividad() = !cambioDeColor
}

class NaveDePasajeros inherits Nave {
  const property cantidadDePasajeros
  var racionesDeComida = 0
  var racionesDeBebida = 0
  var racionesDeComidaServidas = 0

  method racionesDeComida() = racionesDeComida
  method racionesDeBebida() = racionesDeBebida
  method racionesDeComidaServidas() = racionesDeComidaServidas

  method cargarComida(cantidad) {
    racionesDeComida = racionesDeComida + cantidad
  }

  method descargarComida(cantidad) {
    racionesDeComida = (racionesDeComida - cantidad).max(0)
  }

  method cargarBebida(cantidad) {
    racionesDeBebida = racionesDeBebida + cantidad
  }

  method descargarBebida(cantidad) {
    racionesDeBebida = (racionesDeBebida - cantidad).max(0)
  }

  override method prepararViaje() {
    super()
    self.cargarComida(4 * cantidadDePasajeros)
    self.cargarBebida(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method escapar() {
    self.acelerar(velocidad)
  }

  override method avisar() {
    self.descargarComida(cantidadDePasajeros)
    self.descargarBebida(cantidadDePasajeros * 2)
    racionesDeComidaServidas = racionesDeComidaServidas + cantidadDePasajeros
  }

  override method tienePocaActividad() = racionesDeComidaServidas < 50
}

class NaveHospital inherits NaveDePasajeros {
  var quirofanosPreparados = false

  method quirofanosPreparados() = quirofanosPreparados

  method prepararQuirofanos() {
    quirofanosPreparados = true
  }

  override method estaTranquila() = super() && !quirofanosPreparados

  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}
