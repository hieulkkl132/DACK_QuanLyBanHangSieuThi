using DACK_13_BuiXuanHieu.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusProducts
    {
        DaoProducts daoProduct;

        public BusProducts()
        {
            daoProduct = new DaoProducts();
        }

        public void displayTableProduct(DataGridView dgvProducts)
        {
            dgvProducts.DataSource = daoProduct.loadTableProduct();
            dgvProducts.Columns[0].Width = (int)(dgvProducts.Width * 0.13);
            dgvProducts.Columns[1].Width = (int)(dgvProducts.Width * 0.15);
            dgvProducts.Columns[2].Width = (int)(dgvProducts.Width * 0.15);
            dgvProducts.Columns[3].Width = (int)(dgvProducts.Width * 0.13);
            dgvProducts.Columns[4].Width = (int)(dgvProducts.Width * 0.15);
            dgvProducts.Columns[5].Width = (int)(dgvProducts.Width * 0.11);
            dgvProducts.Columns[6].Width = (int)(dgvProducts.Width * 0.10);
        }
        public List<Product> ListProducts()
        {
            return daoProduct.LoadListProducts();
        }

        public void displayComboboxCategory(ComboBox cb)
        {
            cb.DataSource = daoProduct.loadComboboxCategory();
            cb.DisplayMember = "CategoryName";
            cb.ValueMember = "CategoryID";
        }

        public bool addRecord(TextBox tbProductName, ComboBox cbCategory, NumericUpDown nudQuantityPerUnit,
                              NumericUpDown nudUnitPrice, NumericUpDown nudUnitsInStock, TextBox tbActive)
        {
            String productName = tbProductName.Text.Trim(),
                   category = cbCategory.Text.Trim(),
                   quantityperunit = nudQuantityPerUnit.Value.ToString(),
                   unitPrice = nudUnitPrice.Value.ToString(),
                   unitsInStock = nudUnitsInStock.Value.ToString(),
                   active = tbActive.Text.Trim();

            if (productName == "" || category == "" || quantityperunit == "" || unitPrice == "" ||
                unitsInStock == "" || active == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (int.TryParse(active, out int activeNumeric) == false)
            {
                MessageBox.Show("Please, check your ACTIVE number again !");
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
                        Product p = new Product();
                        p.ProductName = productName;
                        p.CategoryID = int.Parse(cbCategory.SelectedValue.ToString());
                        p.QuantityPerUnit = int.Parse(quantityperunit);
                        p.UnitPrice = double.Parse(unitPrice);
                        p.UnitsInStock = int.Parse(unitsInStock);
                        p.Active = short.Parse(active);

                        if (daoProduct.addRecord(p))
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

        public bool editRecord(DataGridView dgvProduct, TextBox tbProductName, ComboBox cbCategory, NumericUpDown nudQuantityPerUnit,
                                NumericUpDown nudUnitPrice, NumericUpDown nudUnitsInStock, TextBox tbActive)
        {
            String productID = dgvProduct.CurrentRow.Cells["ProductID"].Value.ToString();
            String productName = tbProductName.Text.Trim(),
            category = cbCategory.Text.Trim(),
            quantityperunit = nudQuantityPerUnit.Value.ToString(),
            unitPrice = nudUnitPrice.Value.ToString(),
            unitsInStock = nudUnitsInStock.Value.ToString(),
            active = tbActive.Text.Trim();

            DialogResult dr = MessageBox.Show("Record [ " + productID + " ] will be EDITED! Continue ?", "Action confirm",
                                           MessageBoxButtons.OKCancel,
                                           MessageBoxIcon.Question);

            if (dr == DialogResult.OK)
            {
                try
                {
                    Product p = new Product();
                    p.ProductID = int.Parse(productID);
                    p.ProductName = productName;
                    p.CategoryID = int.Parse(cbCategory.SelectedValue.ToString());
                    p.QuantityPerUnit = int.Parse(quantityperunit);
                    p.UnitPrice = int.Parse(unitPrice);
                    p.UnitsInStock = int.Parse(unitsInStock);
                    p.Active = short.Parse(active);

                    if (daoProduct.editRecord(p))
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

        public bool removeRecord(DataGridView dgvProduct)
        {
            String productID = dgvProduct.CurrentRow.Cells["ProductID"].Value.ToString();
            DialogResult dr = MessageBox.Show("Record [ " + productID + " ] will be REMOVED! Continue ?", "Action confrim",
                                MessageBoxButtons.OKCancel,
                                MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoProduct.removeRecord(int.Parse(productID)))
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
