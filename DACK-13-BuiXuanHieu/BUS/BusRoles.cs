using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DACK_13_BuiXuanHieu.DAO;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusRoles
    {
        DaoRoles droles;
        public BusRoles()
        {
            droles = new DaoRoles();
        }

        public bool loadRolesByUsername(string UserName)
        {
            string username = FormLogin.UserName;
            Login login = droles.loadRolesByUsername(username);
            if (login.LoginTypeID==1)
            {
                
                return true;
            }else
            {
                return false;
            }
        }
    }
}
