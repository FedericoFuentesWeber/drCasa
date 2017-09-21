 class Persona
{
	var enfermedades = []
	var celulas
	var temperatura
	
	constructor(cel, temp)
	{
		celulas = cel
		temperatura = temp
	}
	
	// getters	
	method celulas() = celulas
	method temperatura() = temperatura
	method enfermedades() = enfermedades
	
	method enfermar(enfermedad) {enfermedades.add(enfermedad)}
	
	method aumentarTemperatura(aumento) {temperatura += aumento}
	method disminuirTemperatura(disminucion) {temperatura -= disminucion}
	
	method destruirCelulas(celulasAmenazadas) {celulas -= celulasAmenazadas}
	
	method vivirUnDia()
	{
		enfermedades.forEach({enfermedad => enfermedad.afectar(self)})
	}
	
	method estoyCurado()
	{
		return enfermedades.all({enfermedad => enfermedad.celulasAmenazadas() <= 0})
	}
}

class Medico inherits Persona
{
	var dosisMed
	
	constructor(cel,temp,dosis) = super(cel,temp)
	{dosisMed = dosis}
	
	method dosisMed() = dosisMed
	method dosisMed(dosis) {dosisMed = dosis}
	
	method atenderPaciente(persona)
	{
		persona.enfermedades().forEach({enf => enf.atenuar(dosisMed)})
	}
	
	override method enfermar(enfermedad)
	{
		super(enfermedad)
		self.atenderPaciente(self)
	}
}

class JefeDepto inherits Medico
{
	var subordinados = []
	
	method subordinados() = subordinados
	method subordinados(sub) {subordinados.add(sub)}
	
	override method atenderPaciente(persona)
	{
		subordinados.anyOne().atenderPaciente(persona)
	}
}

class Enfermedad
{
	var celulasAmenazadas
	
	constructor(celAm)
	{
		celulasAmenazadas = celAm
	}
	
	method celulasAmenazadas() = celulasAmenazadas
	
	method afectar(persona){}
	
	method atenuar(cantMedicamento)
	{
		celulasAmenazadas -= cantMedicamento*15
	}
}

class Infecciosa inherits Enfermedad
{
	override method afectar(persona)
	{
		persona.aumentarTemperatura(celulasAmenazadas/1000)
	}
	
	method reproducir() {celulasAmenazadas *= 2}
}

class Autoinmune inherits Enfermedad
{
	override method afectar(persona)
	{
		persona.destruirCelulas(celulasAmenazadas)
	}
}

class Muerte inherits Enfermedad
{
	override method afectar(persona)
	{
		persona.disminuirTemperatura(persona.temperatura())
	}
	override method atenuar(medicamento) {super(0)}
}

class Sida inherits Infecciosa
{
	override method afectar(persona)
	{
		super(persona)
		persona.destruirCelulas(celulasAmenazadas)
	}
}