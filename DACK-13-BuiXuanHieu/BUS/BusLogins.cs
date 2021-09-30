using DACK_13_BuiXuanHieu.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusLogins
    {
        //
        DaoLogins daoLogins;
        DaoEmployees daoEmployees;

        //
        public BusLogins()
        {
            //
            daoLogins = new DaoLogins();
            daoEmployees = new DaoEmployees();
        }

        public void displayComboBox(ComboBox cb)
        {
            if (cb.Name == "cbLoginType")
            {
                cb.DataSource = daoLogins.loadTableLoginTypes();
                cb.DisplayMember = "LoginTypeName";
                cb.ValueMember = "LoginTypeID";
            }
        }

        public void displayLoginInfo(int loginID, TextBox tbUsername, ComboBox cbLoginType, TextBox tbPassword)
        {
            //
            Login login = daoLogins.loadLoginByID(loginID);

            //
            tbUsername.Text = login.Username;
            cbLoginType.SelectedValue = login.LoginTypeID;
            tbPassword.Text = login.Password;
        }

        public bool assignLogin(FormManageLogins formManageLogins, int employeeID, TextBox tbUsername, ComboBox cbLoginType, TextBox tbPassword, TextBox tbRetype)
        {
            //
            String username = tbUsername.Text.Trim(),
                   loginType = cbLoginType.SelectedValue.ToString(),
                   password = tbPassword.Text,
                   retype = tbRetype.Text;
            //
            if (username == "" || loginType == "" || password == "" || retype == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (password != retype)
            {
                MessageBox.Show("Password doesn't match !");
                return false;
            }
            else if (daoLogins.checkExistedUsername(username) != 0)
            {
                MessageBox.Show("Username already EXISTED !");
                return false;
            }
            else
            {
                DialogResult dr = MessageBox.Show("A login will be ASSIGNED! Continue ?", "Action confirm",
                                                  MessageBoxButtons.OKCancel,
                                                  MessageBoxIcon.Question);
                if (dr == DialogResult.Cancel)
                {
                    return false;
                }
                else
                {
                    try
                    {
                        Login l = new Login();
                        l.Username = username;
                        l.LoginTypeID = int.Parse(loginType);
                        l.Password = password;

                        if (daoEmployees.assignLogin(employeeID, l))
                        {
                            MessageBox.Show("Successfully !", "Announcement",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Information);
                            formManageLogins.Close();
                        }
                        else
                        {
                            MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement",
                                            MessageBoxButtons.OK,
                                            MessageBoxIcon.Error);
                            return false;
                        }
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message.ToString());
                        return false;
                    }
                }

                return true;
            }
        }

        public bool editLogin(FormManageLogins formManageLogins, int employeeID, TextBox tbUsername, ComboBox cbLoginType, TextBox tbPassword, TextBox tbRetype)
        {
            //
            String username = tbUsername.Text.Trim(),
                   loginType = cbLoginType.SelectedValue.ToString(),
                   password = tbPassword.Text,
                   retype = tbRetype.Text;
            //
            if (username == "" || loginType == "" || password == "" || retype == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (password != retype)
            {
                MessageBox.Show("Password doesn't match !");
                return false;
            }
            else
            {
                DialogResult dr = MessageBox.Show("A login will be EDITED! Continue ?", "Action confirm",
                                                  MessageBoxButtons.OKCancel,
                                                  MessageBoxIcon.Question);
                if (dr == DialogResult.Cancel)
                {
                    return false;
                }
                else
                {
                    try
                    {
                        Login editedLogin = new Login();
                        editedLogin.Username = username;
                        editedLogin.LoginTypeID = int.Parse(loginType);
                        editedLogin.Password = password;

                        if (daoEmployees.editLogin(employeeID, editedLogin))
                        {
                            MessageBox.Show("Successfully !", "Announcement",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Information);
                            formManageLogins.Close();
                        }
                        else
                        {
                            MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement",
                                            MessageBoxButtons.OK,
                                            MessageBoxIcon.Error);
                            return false;
                        }
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message.ToString());
                        return false;
                    }
                }

                return true;
            }
        }

        public bool removeLogin(FormManageLogins formManageLogins, int employeeID)
        {
            DialogResult dr = MessageBox.Show("A login will be REMOVED! Continue ?", "Action confirm",
                                                MessageBoxButtons.OKCancel,
                                                MessageBoxIcon.Question);
            if (dr == DialogResult.Cancel)
            {
                return false;
            }
            else
            {
                try
                {
                    int loginID = daoEmployees.removeLogin(employeeID);
                    if (daoLogins.removeRecord(loginID))
                    {
                        MessageBox.Show("Successfully !", "Announcement",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Information);
                        formManageLogins.Close();
                    }
                    else
                    {
                        MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Error);
                        return false;
                    }
                }
                catch (Exception e)
                {
                    MessageBox.Show(e.Message.ToString());
                    return false;
                }
            }

            return true;
        }


   /////    /// ///
        public bool checkAccount( TextBox tbUsername, TextBox tbPassword)
        {
            string userName = tbUsername.Text.Trim(),
                   passWord = tbPassword.Text.Trim();
            
            Login l = new Login();
            
            if ( daoLogins.account(userName,passWord)!=null)
            {
                if (true)
                {
                    return true;  
                }            
            }
            else
            {
                return false;
            }                                          
        }
    }
}
