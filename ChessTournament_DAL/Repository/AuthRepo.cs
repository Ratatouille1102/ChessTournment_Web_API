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

        public int GetIdLoginAction(string email, string password)
        {
            try
            {

                throw new NotImplementedException();
            }
            catch { }
        }

        public User? GetUserInfo(int id)
        {

            // PREPARE MA QUERY SQL DANS LE TIROIR DE COMMANDES

            ////REMPLIR LE TIROIR COMMANDE
            //String query1 = new String(@"SELECT COUNT(*) FROM dbo.Student WHERE dbo.Student.FirstName = 'Sean'", false);
            //Command query2 = new Command(@"SELECT * FROM Student ", false);
            //Command query3 = new Command(@"INSERT INTO Student (FirstName, LastName, BirthDate, SectionId, YearResult) VALUES
            //('Raphael', 'Lemaire', '1930-02-11 00:00:00', 1320, 10)", false);
            //Command query4 = new Command(@"DELETE FROM Student WHERE LastName = 'Lemaire' AND Active = 1", false);

            ////Afficher l’« ID », le « Nom », le « Prenom » de chaque étudiant depuis la vue «V_Student » en utilisant la méthode connectée
            //Command query5 = new Command(@"SELECT * FROM V_Student ", false);



            //Command query6 = new Command(@"X_SP_AddSection", true);
            //query6.AddParameter("@section_id", 1560);
            //query6.AddParameter("@section_name", "Nomdesection Test");


            // APPELER UNE PROCEDURE STOCKEE AVEC DES ADDPARAMETERS AddParameter(string name, object value) 



            // INSERT DANS SECTION

            // DELETE
            // UPDATE



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


        //try
        //{
        //    Console.WriteLine("Résultats d'un insert de données en Non Query : ");
        //    Console.WriteLine(connection.ExecuteNonQuery());
        //}
        //catch (Exception ex)
        //{        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //    Console.WriteLine($"Une erreur s'est produite en query 1 : {ex.Message}");
        //    // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //    throw;
        //}

        //try
        //{
        //    Console.WriteLine("Résultats du lecteur de données Scalaire : ");
        //    Console.WriteLine(connection.ExecuteScalar());
        //}
        //catch (Exception ex)
        //{        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //    Console.WriteLine($"Une erreur s'est produite en query 2 : {ex.Message}");
        //    // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //    throw;
        //}

        ////            try {
        ////            var resultats = DbConnectionExtensions.ExecuteReader(connection, query2,
        ////selector => $" {selector["Id"]} {selector["FirstName"]} {selector["LastName"]} {selector["YearResult"]} {((DateTime)selector["BirthDate"]).ToString("dd-MM-yyyy")} {selector["Active"]}");

        ////            Console.WriteLine("Résultats du lecteur de données Reader :");
        ////            foreach (string resultat in resultats)
        ////            {
        ////                Console.WriteLine(resultat);
        ////            }
        ////           }
        ////            catch(Exception ex)
        ////            {        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        ////                Console.WriteLine($"Une erreur s'est produite en query 2: {ex.Message}");
        ////                // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        ////                throw;
        ////            }

        //            try
        //            {
        //                Console.WriteLine("Résultats d'un delete de d'un student Lemaire en Non Query qui provoque un retour des Active à false : ");
        //                Console.WriteLine(connection.ExecuteNonQuery());
        //            }
        //            catch (Exception ex)
        //            {        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //                Console.WriteLine($"Une erreur s'est produite en query 3 : {ex.Message}");
        //                // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //                throw;
        //            }

        //            try
        //            {


        //                var resultat2 = DbConnectionExtensions.ExecuteReader(connection, query2,
        //selector => $" {selector["Id"]} {selector["FirstName"]} {selector["LastName"]} {selector["YearResult"]} {((DateTime)selector["BirthDate"]).ToString("dd-MM-yyyy")} {selector["Active"]}");

        //                Console.WriteLine("Résultats du lecteur de données Reader :");
        //                foreach (string resultat in resultat2)
        //                {
        //                    Console.WriteLine(resultat);
        //                }
        //            }
        //            catch (Exception ex)
        //            {        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //                Console.WriteLine($"Une erreur s'est produite en query 2 resultat2 : {ex.Message}");
        //                // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //                throw;
        //            }


        //            try
        //            {


        //                var resultat3 = DbConnectionExtensions.ExecuteReader(connection, query5,
        //selector => $" {selector["Id"]} {selector["FirstName"]} {selector["LastName"]} ");

        //                Console.WriteLine(" Résultat étudiant depuis la vue «V_Student » en utilisant la méthode connectée");
        //                foreach (string resultat in resultat3)
        //                {
        //                    Console.WriteLine(resultat);
        //                }
        //            }
        //            catch (Exception ex)
        //            {        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //                Console.WriteLine($"Une erreur s'est produite en query 5 resultat3 : {ex.Message}");
        //                // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //                throw;
        //            }


        //            try
        //            {
        //                Console.WriteLine("Résultats d'un insert de données en Non Query : ");
        //                Console.WriteLine(connection.ExecuteNonQuery(query6));



        //            }
        //            catch (Exception ex)
        //            {        // Gérez l'exception (par exemple, enregistrez les détails ou affichez un message d'erreur)
        //                Console.WriteLine($"Une erreur s'est produite en query 6 : {ex.Message}");
        //                // Vous pouvez également re-lancer l'exception pour la propager plus loin si nécessaire
        //                throw;
        //            }

        //METTRE EN ATTENTE LE TERMINAL D'AFFICHAGE









    }
}

