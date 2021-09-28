using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DACK_13_BuiXuanHieu.DAO;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusCustomers
    {
        DaoCustomers dCustomer;
        public BusCustomers()
        {
            dCustomer = new DaoCustomers();
        }

        
        public void getListCustomer(DataGridView dgv) 
        {
            dgv.DataSource = dCustomer.getListCustomer();
        }

        //
        public void getMemberList(DataGridView dgv)
        {
            dgv.DataSource = dCustomer.getMemberList();
        }
        //
        public bool addRecord(TextBox tbLastName, TextBox tbFirstName, DateTimePicker dtpBirthDate,TextBox tbAddress, TextBox tbCity, TextBox tbDistrict,TextBox tbPhone, TextBox tbEmail)
        {
            DateTime birthDate = dtpBirthDate.Value;
            string lastName = tbLastName.Text.Trim(),
                   firstName = tbFirstName.Text.Trim(),                  
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   email = tbEmail.Text.Trim();


            if (lastName == "" || firstName == "" || address == "" || city == "" || district == "" || phone == "" || email == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (int.TryParse(phone, out int phoneNumeric) == false)
            {
                MessageBox.Show("Please, check your PHONE number again !");
                return false;
            }
            else
            {
                DialogResult dr = MessageBox.Show("A record will be ADDED! Continue ?", "Action confirm",
                                  MessageBoxButtons.OKCancel,
                                  MessageBoxIcon.Question);
                if (dr==DialogResult.Cancel)
                {
                    return false;
                }
                else
                {
                    try
                    {
                        Customer c = new Customer();
                        c.LastName = lastName;
                        c.FirstName = firstName;
                        c.BirthDate = birthDate;
                        c.Address = address;
                        c.City = city;
                        c.District = district;
                        c.Phone = phone;
                        c.Email = email;

                        if (dCustomer.addRecord(c))
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

        public bool editRecord(DataGridView dgvCustomers,TextBox tbCustomerID,TextBox tbLastName, TextBox tbFirstName,DateTimePicker dtpBirthDate, TextBox tbAddress,
                              TextBox tbCity, TextBox tbDistrict, TextBox tbPhone, TextBox tbEmail)
        {
            //
            DateTime birthDate = dtpBirthDate.Value;
            string customerID= tbCustomerID.Text.Trim(),
                lastName = tbLastName.Text.Trim(),
                   firstName = tbFirstName.Text.Trim(),
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   email = tbEmail.Text.Trim();
            //
            DialogResult dr = MessageBox.Show("Record [ " + customerID + " ] will be EDITED! Continue ?", "Action confirm",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    Customer c = new Customer();
                    c.CustomerID = Int32.Parse(customerID);
                    c.LastName = lastName;
                    c.FirstName = firstName;
                    c.BirthDate = birthDate;
                    c.Address = address;
                    c.City = city;
                    c.District = district;
                    c.Phone = phone;
                    c.Email = email;

                    if (dCustomer.editRecord(c))
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

        public bool removeRecord(DataGridView dgvCustomers)
        {
            //
            String customerID = dgvCustomers.CurrentRow.Cells["CustomerID"].Value.ToString();

            //
            DialogResult dr = MessageBox.Show("Record [ " + customerID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (dCustomer.removeRecord(int.Parse(customerID)))
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



        public void displayMemberInfo(int memberID,TextBox tbRank,DateTimePicker dtpJoinDate, NumericUpDown numPoint)
        {
            //
            Member member= dCustomer.loadMemberByID(memberID);

            //
            dtpJoinDate.Value= member.JoinDate;          
            tbRank.Text = member.Rank;
            numPoint.Value = member.Point;
        }


        public bool assignMember(FormAssignMember formAssignMember, int memberID, TextBox tbRank , DateTimePicker dtpJoinDate, NumericUpDown numPoint)
        {
            //
            DateTime joinDate = dtpJoinDate.Value;
            int point = Convert.ToInt32(Math.Round(numPoint.Value,0));           
            String rank = tbRank.Text.Trim();
                   
            //
            if (rank == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else 
            {
                DialogResult dr = MessageBox.Show("A member will be ASSIGNED! Continue ?", "Action confirm",
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
                        Member m = new Member();
                        m.Rank = rank;
                        m.JoinDate = joinDate;
                        m.Point = point;

                        if (dCustomer.assignMember(memberID,m))
                        {
                            MessageBox.Show("Successfully !", "Announcement",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Information);
                            formAssignMember.Close();
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
}
