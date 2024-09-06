using ChessTournament_COMMON.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChessTournament_DAL.Repository
{
    public class AuthRepo
    {
        private readonly string _cs;
        public AuthRepo(IConfiguration config)
        {
            _cs = config.GetConnectionString("DefaultConnection");
        }

        //public int GetIdLoginAction(string email, string password)
        //{
        //    try
        //    {

        //        throw new NotImplementedException();
        //    }
        //    catch { }
        //}

        public User? GetUserInfo(int id)
        {

            // OUVRIR UNE CONNEXION Ecrire le résultat des query

            using (SqlConnection connection = new SqlConnection(_cs))
            {



                string sql = "SELECT * FROM UserView WHERE Usr_Id = " + id;
                connection.Open();
                Console.ReadLine();
                connection.Close();

            }
            // COUPER LA CONNEXION

            return null;
        }











    }
}

