using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DACK_13_BuiXuanHieu.DAO
{
    class DaoLogins
    {
        //
        SupermarketEntities supmar;

        //
        public DaoLogins()
        {
            //
            supmar = new SupermarketEntities();
        }

        //
        public dynamic loadTableLoginTypes()
        {
            //
            dynamic loginTypes = supmar.LoginTypes.Select(lt => new
            {
                lt.LoginTypeID,
                lt.LoginTypeName
            }).ToList();

            return loginTypes;
        }

        public Login loadLoginByID(int loginID)
        {
            //
            Login login = supmar.Logins.First(l => l.LoginID == loginID);

            return login;
        }

        public Login loadLoginByUsername(String username)
        {
            //
            Login login = supmar.Logins.First(l => l.Username == username);

            return login;
        }

        public bool addRecord(Login l)
        {
            //
            try
            {
                supmar.Logins.Add(l);
                supmar.SaveChanges();
                return true;
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
        }
    }
}
