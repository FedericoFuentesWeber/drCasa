/* class Persona
{
	var enfermedades = []
	var cantidadDeCelulas
	var temperatura
	var diasVividos
	var nombre
		
	method enfermar() {}
} */

class Infecciosa
{
	var celulasAmenazadas
	
	constructor(celAm)
	{
		celulasAmenazadas = celAm
	}
	
	method cantidadCelulasAmenazadas() = celulasAmenazadas
	
	method efecto(persona)
	{

		persona.aumentarTemperatura(celulasAmenazadas/1000)
	}
	
	method reproducir()
	{
		celulasAmenazadas *= 2
	}
}

class Autoinmune
{
	var celulasAmenazadas
	
	constructor(celAm)
	{
		celulasAmenazadas = celAm
	}

	method cantidadCelulasAmenazadas () = celulasAmenazadas

	method efecto(persona)
	{
		persona.destruirCelulas(celulasAmenazadas)
	}
}