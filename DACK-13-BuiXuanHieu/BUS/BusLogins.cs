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

        public bool assignLogin(int employeeID, TextBox tbUsername, ComboBox cbLoginType, TextBox tbPassword, TextBox tbRetype)
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
                DialogResult dr = MessageBox.Show("A login will be ASSIGNED! Continue ?", "Action confirm",
                                                  MessageBoxButtons.OKCancel,
                                                  MessageBoxIcon.Question);
                if (dr == DialogResult.Cancel)
                {
                    return false;
                }
                else
                {
                    try // Add Login.
                    {
                        Login l = new Login();
                        l.Username = username;
                        l.LoginTypeID = int.Parse(loginType);
                        l.Password = password;

                        if (daoLogins.addRecord(l))
                        {
                            MessageBox.Show("Successfully !", "Announcement",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Information);
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

                    try // Assign to Employee.
                    {
                        Login login = daoLogins.loadLoginByUsername(username);
                        daoEmployees.assignLogin(employeeID, login);
                    }
                    catch
                    {
                        MessageBox.Show("Fail to assign login !");
                        return false;
                    }
                }

                return true;
            }
        }

        //public bool addRecord(TextBox tbCompanyName, TextBox tbContact, TextBox tbContactTitle, TextBox tbAddress,
        //                      TextBox tbCity, TextBox tbDistrict, TextBox tbPhone, TextBox tbFax)
        //{
        //    //
        //    String companyName = tbCompanyName.Text.Trim(),
        //           contact = tbContact.Text.Trim(),
        //           contactTitle = tbContactTitle.Text.Trim(),
        //           address = tbAddress.Text.Trim(),
        //           city = tbCity.Text.Trim(),
        //           district = tbDistrict.Text.Trim(),
        //           phone = tbPhone.Text.Trim(),
        //           fax = tbFax.Text.Trim();
        //    //
        //    if (companyName == "" || contact == "" || contactTitle == "" || address == "" ||
        //        city == "" || district == "" || phone == "" || fax == "")
        //    {
        //        MessageBox.Show("Please, fill up ALL attributes !");
        //        return false;
        //    }
        //    else if (int.TryParse(phone, out int phoneNumeric) == false || int.TryParse(fax, out int faxNumeric) == false)
        //    {
        //        MessageBox.Show("Please, check your PHONE or FAX number again !");
        //        return false;
        //    }
        //    else
        //    {
        //        DialogResult dr = MessageBox.Show("A record will be ADDED! Continue ?", "Action confirm",
        //                                          MessageBoxButtons.OKCancel,
        //                                          MessageBoxIcon.Question);
        //        if (dr == DialogResult.Cancel)
        //        {
        //            return false;
        //        }
        //        else
        //        {
        //            try
        //            {
        //                Supplier s = new Supplier();
        //                s.CompanyName = companyName;
        //                s.Contact = contact;
        //                s.ContactTitle = contactTitle;
        //                s.Address = address;
        //                s.City = city;
        //                s.District = district;
        //                s.Phone = phone;
        //                s.Fax = fax;

        //                if (daoSuppliers.addRecord(s))
        //                {
        //                    MessageBox.Show("Successfully !", "Announcement",
        //                                MessageBoxButtons.OK,
        //                                MessageBoxIcon.Information);
        //                }
        //                else
        //                {
        //                    MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement",
        //                                    MessageBoxButtons.OK,
        //                                    MessageBoxIcon.Error);
        //                    return false;
        //                }
        //            }
        //            catch (Exception e)
        //            {
        //                MessageBox.Show(e.Message.ToString());
        //                return false;
        //            }
        //        }

        //        return true;
        //    }
        //}
        //}
    }
}
