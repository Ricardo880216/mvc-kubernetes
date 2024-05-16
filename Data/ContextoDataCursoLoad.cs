
using System.Collections.Generic;
using Bogus;
using MVCPrototipo.Models;
using System.Threading.Tasks;

namespace MVCPrototipo.DataTest
{

    public class ContextoDataCursoLoad
    {
        public static async Task InsertarData(ContextoCurso context)
        {
            List<Instructor> instructors = new List<Instructor>();
            for (int i = 0; i <= 20; i++)
            {

                var testUsers = new Faker<Instructor>()
                .RuleFor(u => u.Nombre, (f, u) => f.Name.FirstName(0))
                .RuleFor(u => u.Apellidos, (f, u) => f.Name.LastName(0))
                .RuleFor(u => u.Grado, (f, u) => f.Company.CompanyName(0));

                //var users = testUsers.Generate();
                instructors.Add(testUsers.Generate());
            }

            await context.Instructor!.AddRangeAsync(instructors!);
            await context.SaveChangesAsync();

        }
    }
}