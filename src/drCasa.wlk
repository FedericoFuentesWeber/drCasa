class SinEmpleadosException inherits Exception{}

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
	
	method recibirMedicamento(dosis)
	{
		enfermedades.forEach({enf => enf.atenuar(dosis)})
		enfermedades = enfermedades.filter({enf => enf.estaViva()})
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
		persona.recibirMedicamento(self.dosisMed())
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
	
	constructor(cel,temp,dosis) = super(cel,temp)
	
	method subordinados() = subordinados
	method nuevoEsclavo(sub) {subordinados.add(sub)}
	
	override method atenderPaciente(persona)
	{
		if(subordinados.isEmpty())
		{
			// error.throwWithMessage("jefe sin esclavos, no puede atender")
			// throw new Exception("bla bla")
			throw new SinEmpleadosException("Un jefe sin empleados no puede atender pacientes")
		}
		subordinados.anyOne().atenderPaciente(persona)
	}
}