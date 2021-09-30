using DACK_13_BuiXuanHieu.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusSuppliers
    {
        //
        DaoSuppliers daoSuppliers;

        //
        public BusSuppliers()
        {
            //
            daoSuppliers = new DaoSuppliers();
        }

        public void displayTableSuppliers(DataGridView dgvSuppliers)
        {
            //
            dgvSuppliers.DataSource = daoSuppliers.loadTableSuppliers();

            //
            //dgvOrders.Columns[0].Width = (int)(0.2 * dgvOrders.Width);
            //dgvOrders.Columns[1].Width = (int)(0.2 * dgvOrders.Width);
            //dgvOrders.Columns[2].Width = (int)(0.31 * dgvOrders.Width);
            //dgvOrders.Columns[3].Width = (int)(0.2 * dgvOrders.Width);
        }

        public bool addRecord(TextBox tbCompanyName, TextBox tbContact, TextBox tbContactTitle, TextBox tbAddress,
                              TextBox tbCity, TextBox tbDistrict, TextBox tbPhone, TextBox tbFax)
        {
            //
            String companyName = tbCompanyName.Text.Trim(),
                   contact = tbContact.Text.Trim(),
                   contactTitle = tbContactTitle.Text.Trim(),
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   fax = tbFax.Text.Trim();
            //
            if (companyName == "" || contact == "" || contactTitle == "" || address == "" ||
                city == "" || district == "" || phone == "" || fax == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (int.TryParse(phone, out int phoneNumeric) == false || int.TryParse(fax, out int faxNumeric) == false)
            {
                MessageBox.Show("Please, check your PHONE or FAX number again !");
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
                        Supplier s = new Supplier();
                        s.CompanyName = companyName;
                        s.Contact = contact;
                        s.ContactTitle = contactTitle;
                        s.Address = address;
                        s.City = city;
                        s.District = district;
                        s.Phone = phone;
                        s.Fax = fax;

                        if (daoSuppliers.addRecord(s))
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

        public bool editRecord(DataGridView dgvSuppliers, TextBox tbCompanyName, TextBox tbContact, TextBox tbContactTitle, TextBox tbAddress,
                               TextBox tbCity, TextBox tbDistrict, TextBox tbPhone, TextBox tbFax)
        {
            //
            String supplierID = dgvSuppliers.CurrentRow.Cells["SupplierID"].Value.ToString();
            String companyName = tbCompanyName.Text.Trim(),
                   contact = tbContact.Text.Trim(),
                   contactTitle = tbContactTitle.Text.Trim(),
                   address = tbAddress.Text.Trim(),
                   city = tbCity.Text.Trim(),
                   district = tbDistrict.Text.Trim(),
                   phone = tbPhone.Text.Trim(),
                   fax = tbFax.Text.Trim();
            //
            if (companyName == "" || contact == "" || contactTitle == "" || address == "" ||
                city == "" || district == "" || phone == "" || fax == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (int.TryParse(phone, out int phoneNumeric) == false || int.TryParse(fax, out int faxNumeric) == false)
            {
                MessageBox.Show("Please, check your PHONE or FAX number again !");
                return false;
            }
            else
            {
                DialogResult dr = MessageBox.Show("Record [ " + supplierID + " ] will be EDITED! Continue ?", "Action confirm",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
                if (dr == DialogResult.OK)
                {
                    try
                    {
                        Supplier s = new Supplier();
                        s.SupplierID = int.Parse(supplierID);
                        s.CompanyName = companyName;
                        s.Contact = contact;
                        s.ContactTitle = contactTitle;
                        s.Address = address;
                        s.City = city;
                        s.District = district;
                        s.Phone = phone;
                        s.Fax = fax;

                        if (daoSuppliers.editRecord(s))
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
            }    
            return true;
        }

        public bool removeRecord(DataGridView dgvSuppliers)
        {
            //
            String supplierID = dgvSuppliers.CurrentRow.Cells["SupplierID"].Value.ToString();

            //
            DialogResult dr = MessageBox.Show("Record [ "+ supplierID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoSuppliers.removeRecord(int.Parse(supplierID)))
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
