using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DACK_13_BuiXuanHieu.DAO;
using System.Windows.Forms;
using System.Data.Entity.Infrastructure;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusPromotions
    {
        DaoPromotions daoPromotions;

        public BusPromotions()
        {
            daoPromotions = new DaoPromotions();
        }
        public void displayTablePromotions(DataGridView dgvOrders)
        {
            dgvOrders.DataSource = daoPromotions.loadTablePromotions();
            dgvOrders.Columns[0].Width = (int)(0.25 * dgvOrders.Width);
            dgvOrders.Columns[1].Width = (int)(0.3 * dgvOrders.Width);
        }
        public bool addRecord(TextBox tbPromotionName, TextBox tbDescription)
        {
            String promotionName = tbPromotionName.Text.Trim(),
                   description = tbDescription.Text.Trim();
            if (promotionName == "" || description == "")
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
                        Promotion s = new Promotion();
                        s.Description = description;
                        s.PromotionName = promotionName;
                        if (daoPromotions.addRecord(s))
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
        public bool editRecord(DataGridView dgvPromotions, TextBox tbPromotionName, TextBox tbDescription)
        {
            String promotionName = tbPromotionName.Text.Trim(),
                   description = tbDescription.Text.Trim();
            String promotionID = dgvPromotions.CurrentRow.Cells["PromotionID"].Value.ToString();
            DialogResult dr = MessageBox.Show("Record [ " + promotionID + " ] will be EDITED! Continue ?", "Action confirm",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {

                    Promotion s = new Promotion();
                    s.Description = description;
                    s.PromotionName = promotionName;
                    s.PromotionID = int.Parse(promotionID);
                    if (daoPromotions.editRecord(s))
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
        
       public void removeRecord(Promotion p)
        {
            if (daoPromotions.removeRecord(p))
            {
                try
                {
                   
                    MessageBox.Show("Successfully !", "Announcement");
                }
                catch(DbUpdateException ex)
                {
                    MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement" + ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Fail ! Something crashed in DataAccessLayer ?!!", "Announcement");
            }
        }
    }
}

