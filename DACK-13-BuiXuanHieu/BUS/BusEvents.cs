using DACK_13_BuiXuanHieu.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusEvents
    {
        DaoEvents daoEvents;
        public BusEvents()
        {
            daoEvents = new DaoEvents();
        }

        public void displayTableEvents(DataGridView dgvOrders)
        {
            dgvOrders.DataSource = daoEvents.loadTableEvents();
            dgvOrders.Columns[0].Width = (int)(0.15 * dgvOrders.Width);
            dgvOrders.Columns[1].Width = (int)(0.15 * dgvOrders.Width);
        }
        public void displayComboboxPromotions(ComboBox cb)
        {
            cb.DataSource = daoEvents.loadComboboxPromotions();
            cb.DisplayMember = "PromotionName";
            cb.ValueMember = "PromotionID";
        }
        public void displayComboboxProducts(ComboBox cb)
        {
            cb.DataSource = daoEvents.loadComboboxProduct();
            cb.DisplayMember = "ProductName";
            cb.ValueMember = "ProductID";
        }
        public bool addRecord(ComboBox cbpromotion, ComboBox cbproduct, DateTimePicker dtpstarday, DateTimePicker dtpenday, NumericUpDown nudlimitquatity, NumericUpDown nuddiscount, TextBox tbdescription)
        {
            String promotion = cbpromotion.Text.Trim(),
                   product = cbproduct.Text.Trim(),
                   discripton = tbdescription.Text.Trim();

            if (dtpenday.Value < System.DateTime.Today || dtpstarday.Value < System.DateTime.Today)
            {
                MessageBox.Show("Please, Don't chose past day !");
                return false;
            }
            else if (dtpenday.Value < dtpstarday.Value)
            {
                MessageBox.Show("Please, Startdate < Enddate !");
                return false;
            }
            else if (dtpenday.Value == dtpstarday.Value)
            {
                MessageBox.Show("Please, Startdate and Enddate are not the same !");
                return false;
            }
            else if (promotion == "" || product == "" || discripton == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
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
                        Event s = new Event();
                        s.Description = discripton;
                        s.StartDate = dtpstarday.Value;
                        s.EndDate = dtpenday.Value;
                        s.ProductID = int.Parse(cbproduct.SelectedValue.ToString());
                        s.PromotionID = int.Parse(cbpromotion.SelectedValue.ToString());
                        s.Discount = System.Convert.ToInt32(nudlimitquatity.Text);
                        s.LimitQuantity = (System.Convert.ToInt32(nudlimitquatity.Text));
                        if (daoEvents.addRecord(s))
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
        public bool editRecord(ComboBox cbpromotion,DataGridView dgvEvents, DateTimePicker dtpstarday, DateTimePicker dtpenday, NumericUpDown nudlimitquatity, NumericUpDown nuddiscount, TextBox tbdescription)
        {
            String discripton = tbdescription.Text.Trim();
            //String promotionID = dgvEvents.Rows[dgvEvents.CurrentRow.Index].Cells["PromotionID"].Value.ToString();
            String productID = dgvEvents.CurrentRow.Cells["ProductID"].Value.ToString();

            if (dtpenday.Value < dtpstarday.Value)
            {
                MessageBox.Show("Please, Startdate < Enddate !");
                return false;
            }
            else if (dtpenday.Value == dtpstarday.Value)
            {
                MessageBox.Show("Please, Startdate and Enddate are not the same !");
                return false;
            }
            DialogResult dr = MessageBox.Show("  Record [ " + productID + " ] " + " will be EDITED! Continue ?", "Action confirm",
                                                MessageBoxButtons.OKCancel,
                                                MessageBoxIcon.Question);

            if (dr == DialogResult.OK)
            {
                try
                {
                    Event s = new Event();
                    s.Description = discripton;
                    s.StartDate = dtpstarday.Value;
                    s.EndDate = dtpenday.Value;
                    s.ProductID = int.Parse(productID);
                    s.PromotionID = int.Parse(cbpromotion.SelectedValue.ToString());
                    s.Discount = System.Convert.ToInt32(nudlimitquatity.Text);
                    s.LimitQuantity = (System.Convert.ToInt32(nudlimitquatity.Text));
                    if (daoEvents.editRecord(s))
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
        public bool removeRecord(DataGridView dgvEvents)
        {
            String productID = dgvEvents.CurrentRow.Cells["ProductID"].Value.ToString();
            DialogResult dr = MessageBox.Show("Record [ " + productID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoEvents.removeRecord(int.Parse(productID)))
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
