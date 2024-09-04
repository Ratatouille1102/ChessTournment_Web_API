using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChessTournment_Web_API.Models
{
        public class RegisterForm
        {

            public int Usr_Id { get; set; }
            public string Usr_Pseudo { get; set; }
            public string Usr_Email { get; set; }
            public DateTime Usr_Birthdate { get; set; }
            public int Usr_Genre { get; set; }
            public string Usr_Firstname { get; set; }
            public string Usr_Lastname { get; set; }
            public int Usr_Elo { get; set; }
            public bool Usr_Role { get; set; }
            public string Usr_Password { get; set; }
            public Guid Usr_Salt { get; set; }
            public bool Usr_InActive { get; set; }

        }

}



