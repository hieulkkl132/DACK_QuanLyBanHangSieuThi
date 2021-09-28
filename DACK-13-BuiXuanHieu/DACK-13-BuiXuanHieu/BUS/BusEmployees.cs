using DACK_13_BuiXuanHieu.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusEmployees
    {
        DaoEmployees daoEmployees;
        public BusEmployees()
        {
            daoEmployees = new DaoEmployees();
        }

        public void displayTableEmployees(DataGridView dgvEmployees)
        {
            //
            dgvEmployees.DataSource = daoEmployees.loadTableEmployees();

            //
            dgvEmployees.Columns["EmployeeID"].Visible = false;
            dgvEmployees.Columns["LoginID"].Width = (int)(0.08 * dgvEmployees.Width);
        }
        public void displayComboboxPositions(ComboBox cb)
        {
            cb.DataSource = daoEmployees.loadComboboxPositon();
            cb.DisplayMember = "PositionName";
            cb.ValueMember = "PositionID";
        }
        public static bool isValidEmail(string inputEmail)
        {
            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail))
                return (true);
            else
                return (false);
        }
        public bool addRecord(TextBox tbLastName, TextBox tbFirstName, ComboBox cbPosition,
                              DateTimePicker dtpBirthdate, TextBox tbAddress, TextBox tbCity, TextBox tbDistrict,
                              TextBox tbPhone, TextBox tbEmail)
        {
            String lastName = tbLastName.Text.Trim(),
                   firstName = tbFirstName.Text.Trim(),
                   position = cbPosition.Text.Trim(),
                   birthdate = dtpBirthdate.Value.ToString(),
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   email = tbEmail.Text.Trim();
            if (lastName == "" || firstName == "" || position == "" || birthdate == "" || address == "" ||
                 city == "" || district == "" || phone == "" || email == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (int.TryParse(phone, out int phoneNumeric) == false)
            {
                MessageBox.Show("Please, check your PHONE number again !");
                return false;
            }
            else if (isValidEmail(email) == false)
            {
                MessageBox.Show("Please, check your Email again !");
                return false;
            }
            else
            {
                DialogResult dr = MessageBox.Show("A record will be ADDED! Continue ?", "Action confirm",
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
                        Employee e = new Employee();
                        e.LastName = lastName;
                        e.FirstName = firstName;
                        e.PositionID = int.Parse(cbPosition.SelectedValue.ToString());
                        e.BirthDate = DateTime.Parse(birthdate);
                        e.Address = address;
                        e.City = city;
                        e.District = district;
                        e.Phone = phone;
                        e.Email = email;
                        if (daoEmployees.addRecord(e))
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
                }
                return true;
            }
        }

        public bool editRecord(DataGridView dgvEmployees, TextBox tbLastName, TextBox tbFirstName, ComboBox cbPosition,
                              DateTimePicker dtpBirthdate, TextBox tbAddress, TextBox tbCity, TextBox tbDistrict,
                              TextBox tbPhone, TextBox tbEmail)
        {
            String EmployeeID = dgvEmployees.CurrentRow.Cells["EmployeeID"].Value.ToString();
            String lastName = tbLastName.Text.Trim(),
                   firstName = tbFirstName.Text.Trim(),
                   position = cbPosition.Text.Trim(),
                   birthdate = dtpBirthdate.Value.ToString(),
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   email = tbEmail.Text.Trim();
            DialogResult dr = MessageBox.Show("Record [ " + EmployeeID + " ] will be EDITED! Continue ?", "Action confirm",
                                MessageBoxButtons.OKCancel,
                                MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    Employee e = new Employee();
                    e.EmployeeID = int.Parse(EmployeeID);
                    e.LastName = lastName;
                    e.FirstName = firstName;
                    e.PositionID = int.Parse(cbPosition.SelectedValue.ToString());
                    e.BirthDate = DateTime.Parse(birthdate);
                    e.Address = address;
                    e.City = city;
                    e.District = district;
                    e.Phone = phone;
                    e.Email = email;

                    if (daoEmployees.editRecord(e))
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
            }
            return true;
        }
        public bool removeRecord(DataGridView dgvEmployees)
        {
            String EmployeeID = dgvEmployees.CurrentRow.Cells["EmployeeID"].Value.ToString();
            DialogResult dr = MessageBox.Show("Record [ " + EmployeeID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoEmployees.removeRecord(int.Parse(EmployeeID)))
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
            }
            return true;
        }
    }
}
