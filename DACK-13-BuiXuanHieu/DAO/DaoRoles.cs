using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoRoles
    {
        SupermarketEntities supmar;

        public DaoRoles()
        {
            supmar = new SupermarketEntities();
        }

        public Login loadRolesByUsername(string username)
        {
            Login login = supmar.Logins.FirstOrDefault(l => l.Username == username);
            return login;
        }
    }
}
