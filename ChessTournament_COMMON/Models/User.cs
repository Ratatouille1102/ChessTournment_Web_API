using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChessTournament_COMMON.Models
{
        public class User
        {
            public int Usr_Id { get; set; }
            public string Usr_Pseudo { get; set; }
            public string Usr_Email { get; set; }
            public DateTime Usr_Birthdate{ get; set; }
            public short Usr_Genre { get; set; }
            public string Usr_Firstname { get; set; }
            public string Usr_Lastname { get; set; }
            public short Usr_Elo { get; set; }
            public bool Usr_Role { get; set; }
            public bool Usr_InActive { get; set; }

    }
    
}

