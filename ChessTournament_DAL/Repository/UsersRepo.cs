using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using ChessTournament_COMMON.Models;
using ChessTournament_DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace ChessTournament_DAL.Respositories
{
    public class UserRepo : IUserRepo
    {
        private readonly string _connectionString;

        //IConfiguration => nuget Microsoft.Extensions.Configuration
        // Permet d'accèder à appsettings.json
        public UserRepo(IConfiguration config)
        {
            _connectionString = config.GetConnectionString("DefaultConnection");
        }

        private User Mapper(SqlDataReader reader)
        {
            return new User
            {

                Usr_Id = (int)reader["Usr_Id"],
                Usr_Pseudo = reader["Usr_Pseudo"].ToString(),
                Usr_Email = reader["Usr_Email"].ToString(),
                Usr_Birthdate = (DateTime)reader["Usr_Birthdate"],
                Usr_Genre = (short)reader["Usr_Genre"],
                Usr_Firstname = reader["Usr_Firstname"].ToString(),
                Usr_Lastname = reader["Usr_Lastname"].ToString(),
                Usr_Elo = (short)reader["Usr_Elo"],
                Usr_Role = (bool)reader["Usr_Role"],
                Usr_InActive = (bool)reader["Usr_InActive"]

            };
        }

        public List<User> GetAll()
        {
            List<User> list = new List<User>();

            using (SqlConnection cnx = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = cnx.CreateCommand())
                {
                    string sqlQuery = "SELECT * FROM Users";
                    cmd.CommandText = sqlQuery;
                    cnx.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            list.Add(Mapper(reader));
                        }
                    }
                    cnx.Close();
                }

            }
            return list;
        }
    }
}