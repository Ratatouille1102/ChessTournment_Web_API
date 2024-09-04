using ChessTournament_COMMON.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace ChessTournament_DAL.Interfaces
{
    public interface IUserRepo
    {
        List<User> GetAll();
    }
}
