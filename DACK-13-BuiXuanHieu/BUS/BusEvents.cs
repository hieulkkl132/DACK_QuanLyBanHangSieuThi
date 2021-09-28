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

        //
        public BusEvents()
        {
            //
            daoEvents = new DaoEvents();
        }

        public void displayTableEvents(DataGridView dgvOrders)
        {
            //
            dgvOrders.DataSource = daoEvents.loadTableEvents();

            //
            dgvOrders.Columns[0].Width = (int)(0.15 * dgvOrders.Width);
            dgvOrders.Columns[1].Width = (int)(0.15 * dgvOrders.Width);
            //dgvOrders.Columns[2].Width = (int)(0.31 * dgvOrders.Width);
            //dgvOrders.Columns[3].Width = (int)(0.2 * dgvOrders.Width);
        }
        public void loadcbProducts(ComboBox cb)
        {
            cb.DataSource = daoEvents.cbProduct();
            cb.DisplayMember = "ProductID";
            cb.ValueMember = "ProductName";
        }
        public void loadcbPromotions(ComboBox cb)
        {
            cb.DataSource = daoEvents.cbPromotion();
            cb.DisplayMember = "PromotionID";
            cb.ValueMember = "PromotionName";
        }
        public bool addRecord(ComboBox cbpromotion, ComboBox cbproduct, DateTimePicker dtpstarday, DateTimePicker dtpenday, NumericUpDown nudlimitquatity, NumericUpDown nuddiscount , TextBox tbdescription)
        {
            //
            String promotion = cbpromotion.Text.Trim(),
                   product = cbproduct.Text.Trim(),       
                   discripton = tbdescription.Text.Trim();
         
                   

            //
            if (promotion == "" || product == "" || discripton ==  "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
      //      else if ((System.Convert.ToDecimal(nuddiscount.Text) > nuddiscount.Maximum) ||
      //(System.Convert.ToDecimal(nuddiscount.Text) < nuddiscount.Minimum)|| (System.Convert.ToInt32(nudlimitquatity.Text) > nudlimitquatity.Maximum) ||
      //(System.Convert.ToInt32(nudlimitquatity.Text) < nudlimitquatity.Minimum))
      //      {
      //          MessageBox.Show("The value entered was not between the Minimum and" +
      //             "Maximum allowable values." + "\n" + "Please re-enter.");
      //          //nuddiscount.Focus();
      //          //nuddiscount.Select(0, nuddiscount.Text.Length);
      //          //nudlimitquatity.Focus();
      //          //nudlimitquatity.Select(0, nudlimitquatity.Text.Length);
      //          return false;
      //      }
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
                        s.ProductID = int.Parse(product);
                        s.PromotionID = int.Parse(promotion);
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
        public bool editRecord(DataGridView dgvEvents,  DateTimePicker dtpstarday, DateTimePicker dtpenday, NumericUpDown nudlimitquatity, NumericUpDown nuddiscount, TextBox tbdescription)
        {
            //

            String discripton = tbdescription.Text.Trim();
            
            String promotionID = dgvEvents.Rows[dgvEvents.CurrentRow.Index].Cells[0].Value.ToString();
            String productID = dgvEvents.CurrentRow.Cells[1].Value.ToString();

                //
                DialogResult dr = MessageBox.Show("Record [ " + promotionID + " ] " + "and Record [ " + productID + " ] " + " will be EDITED! Continue ?", "Action confirm",
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
                    s.PromotionID = int.Parse(promotionID);
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
            //
            String promotionID = dgvEvents.CurrentRow.Cells["PromotionID"].Value.ToString();

            //
            DialogResult dr = MessageBox.Show("Record [ " + promotionID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoEvents.removeRecord(int.Parse(promotionID)))
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
