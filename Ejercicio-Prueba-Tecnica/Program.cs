
using Ejercicio_Prueba_Tecnica;

var servicio = new Servicio();
var razasGatos = await servicio.GetAllCatBreed();

if(razasGatos != null)
{
    var primerasDiez = razasGatos.OrderByDescending(p => p.intelligence).Take(10).ToList();



    foreach (var razas in primerasDiez)
    {
        Console.WriteLine("Nombre: "+ razas.name);
        Console.WriteLine("Descripcion: "+ razas.description);
        Console.WriteLine("Origen"+ razas.origin);
        Console.WriteLine("Inteligencia: "+ razas.intelligence);
        Console.WriteLine("Adaptabilidad: "+ razas.adaptability);
    }

    double promedioAdaptabilidad = razasGatos.Average(p => p.adaptability);
    Console.WriteLine("El promedio de adaptabilidad es "+ promedioAdaptabilidad);
}
else
{
    Console.WriteLine("No se pudo obtener informacion");
}


