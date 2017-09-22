class Enfermedad
{
	var celulasAmenazadas
	
	constructor(celAm)
	{
		celulasAmenazadas = celAm
	}
	
	method celulasAmenazadas() = celulasAmenazadas
	
	// NO TIENE QUE LLEVAR LLAVES, ES UN METHOD ABSTRACTO (SIN CODIGO)
	method afectar(persona)
	
	// method afectar(persona){} hace que enfermedad sea una clase
	// instanciable. El metodo no hace nada
	
	method atenuar(cantMedicamento)
	{
		celulasAmenazadas -= cantMedicamento*15
	}
	
	method estaViva() = celulasAmenazadas > 0
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

object muerte
{
	method afectar(persona)
	{
		persona.disminuirTemperatura(persona.temperatura())
	}
	method atenuar(medicamento){}
	method estaViva() = true
}

class Sida inherits Enfermedad
{
	override method afectar(persona)
	{
		super(persona)
		persona.destruirCelulas(celulasAmenazadas)
	}
}