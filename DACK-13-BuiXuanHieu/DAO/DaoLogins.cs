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

        public bool removeRecord(int loginID)
        {
            //
            try
            {
                Login chosenRecord = supmar.Logins.First(s => s.LoginID == loginID);
                supmar.Logins.Remove(chosenRecord);
                supmar.SaveChanges();
            }
            catch //(Exception e)
            {
                //MessageBox.Show(e.Message.ToString());
                return false;
            }
            return true;
        }
    }
}
