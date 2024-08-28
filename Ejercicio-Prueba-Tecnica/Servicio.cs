using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Ejercicio_Prueba_Tecnica
{
    public class Servicio
    {
        //Get: lista de razas de gatos
        //https://api.thecatapi.com/v1/breeds

        public async Task<List<CatBreed>> GetAllCatBreed()
        {
            using (HttpClient client = new HttpClient())
            {

                client.BaseAddress = new Uri("https://api.thecatapi.com/v1/breeds");
                HttpResponseMessage res = await client.GetAsync("breeds");

                if (res.IsSuccessStatusCode)
                {
                    string json = await res.Content.ReadAsStringAsync();
                    var respuesDes = JsonSerializer.Deserialize<List<CatBreed>>(json);
                    return respuesDes;

                }
                else
                {
                    Console.WriteLine("El error es :" + res.StatusCode);
                    return null;
                }



            }
        }
    }
}
