using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DACK_13_BuiXuanHieu.DAO;
using System.Windows.Forms;

namespace DACK_13_BuiXuanHieu.BUS
{
    class BusReceipts
    {
        DaoReceipts daoReceipts;

        //
        public BusReceipts()
        {
            //
            daoReceipts = new DaoReceipts();
        }
        public void displayTableReceipts(DataGridView dgvOrders)
        {
            //
            dgvOrders.DataSource = daoReceipts.loadTableReceipts();


            
        }
        public bool addRecord(TextBox tbEmployee , TextBox tbCustumer , TextBox tbMethod, DateTimePicker dtpReceiveDate)
        {
            //
            String employee = tbEmployee.Text.Trim(),
                   custumer = tbCustumer.Text.Trim(),
                   method = tbMethod.Text.Trim();
                  
            //
            if (employee == "" || custumer == "" || method == "" )
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
                        Receipt s = new Receipt();
                        s.ReceiveMethod = method;
                        s.ReceiveDate = dtpReceiveDate.Value;
                        s.EmployeeID = int.Parse(employee);
                        s.CustomerID = int.Parse(custumer);



                        if (daoReceipts.addRecord(s))
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
        public bool editRecord(DataGridView dgvReceipts, TextBox tbEmployee, TextBox tbCustumer, TextBox tbMethod, DateTimePicker dtpReceiveDate)
        {
            //
            String receiptID = dgvReceipts.CurrentRow.Cells["ReceiptID"].Value.ToString();
            String
                   employee = tbEmployee.Text.Trim(),
                   custumer = tbCustumer.Text.Trim(),
                   method = tbMethod.Text.Trim();
            
            //
            DialogResult dr = MessageBox.Show("Record [ " + receiptID + " ] will be EDITED! Continue ?", "Action confirm",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    Receipt s = new Receipt();
                    s.ReceiptID = int.Parse(receiptID);
                    s.ReceiveMethod = method;
                    s.ReceiveDate = dtpReceiveDate.Value;
                    s.EmployeeID = int.Parse(employee);
                    s.CustomerID = int.Parse(custumer);

                    if (daoReceipts.editRecord(s))
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
        public bool removeRecord(DataGridView dgvReceipts)
        {
            //
            String receiptID = dgvReceipts.CurrentRow.Cells["ReceiptID"].Value.ToString();

            //
            DialogResult dr = MessageBox.Show("Record [ " + receiptID + " ] will be REMOVED! Continue ?", "Action confrim",
                                            MessageBoxButtons.OKCancel,
                                            MessageBoxIcon.Question);
            if (dr == DialogResult.OK)
            {
                try
                {
                    if (daoReceipts.removeRecord(int.Parse(receiptID)))
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

