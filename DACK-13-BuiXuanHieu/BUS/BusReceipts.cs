using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DACK_13_BuiXuanHieu.DAO;
using System.Windows.Forms;
using System.Data.Entity.Infrastructure;
using System.Data;
using System.Transactions;

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
        public void displayComboboxEmployee(ComboBox cb)
        {
            cb.DataSource = daoReceipts.loadComboboxEmployee();
            cb.DisplayMember = "FirstName";
            cb.ValueMember = "EmployeeID";
        }
        public void displayComboboxCustomer(ComboBox cb)
        {
            cb.DataSource = daoReceipts.loadComboboxCustomer();
            cb.DisplayMember = "LastName";
            cb.ValueMember = "CustomerID";
        }
        public bool addRecord(ComboBox tbEmployee, ComboBox tbCustumer, TextBox tbMethod, DateTimePicker dtpReceiveDate)
        {
            String employee = tbEmployee.SelectedValue.ToString(),
                   custumer = tbCustumer.SelectedValue.ToString(),
                   method = tbMethod.Text.Trim();
            if (dtpReceiveDate.Value < System.DateTime.Today)
            {
                MessageBox.Show("Please, Don't chose past day !");
                return false;
            }
            else if (employee == "" || custumer == "" || method == "")
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
        public bool editRecord(DataGridView dgvReceipts, ComboBox cbEmployee, ComboBox cbCustumer, TextBox tbMethod, DateTimePicker dtpReceiveDate)
        {
            //
            String receiptID = dgvReceipts.CurrentRow.Cells["ReceiptID"].Value.ToString();
            String
                   employee = cbEmployee.SelectedValue.ToString(),
                   custumer = cbCustumer.SelectedValue.ToString(),
                   method = tbMethod.Text.Trim();
            if (employee == "" || custumer == "" || method == "")
            {
                MessageBox.Show("Please, fill up ALL attributes !");
                return false;
            }
            else if (dtpReceiveDate.Value < System.DateTime.Today)
            {
                MessageBox.Show("Please, Don't chose past day !");
                return false;
            }
            else
            {
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
                    Receipt d = new Receipt();
                    d.ReceiptID = int.Parse(receiptID);
                    if (daoReceipts.removeRecord(d))
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


        //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////// RECEIPT DETAILS //////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////

        public void showRDetails(DataGridView dg, int Rid)
        {
            dg.DataSource = daoReceipts.loadRDetails(Rid);

        }

        public void RemoveRDetails(ReceiptDetail dh)
        {
            try
            {
                daoReceipts.RemoveRDetails(dh);
                MessageBox.Show("Xóa thành công");
            }
            catch (DbUpdateException ex)
            {
                MessageBox.Show("Xóa thất bại\n" + ex.Message);
            }
        }

        public bool AddRDetails(int Rid, DataTable dtdh)
        {
            using (var tran = new TransactionScope())
            {
                try
                {
                    foreach (DataRow item in dtdh.Rows)
                    {
                        ReceiptDetail d = new ReceiptDetail();
                        d.ReceiptID = Rid;
                        d.ProductID = int.Parse(item[0].ToString());
                        d.UnitPrice = float.Parse(item[1].ToString());
                        d.Quantity = int.Parse(item[2].ToString());
                        d.Discount = float.Parse(item[3].ToString());
                        if (daoReceipts.ProductCheck(d))
                        {
                            daoReceipts.AddRDetails(d);
                        }
                        else
                        {
                            throw new Exception("Sản phẩm đã tồn tại" + d.ProductID);
                        }
                    }
                    tran.Complete();
                    MessageBox.Show("Them Thanh Cong");
                    return true;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Them That Bai\n" + ex.Message);
                    return false;
                }
            }
        }


        public void EditRDetails(ReceiptDetail dh)
        {
            try
            {
                daoReceipts.EditRDetails(dh);
                MessageBox.Show("Sua thanh cong");
            }
            catch (DbUpdateException ex)
            {
                MessageBox.Show("Sua that bai\n" + ex.Message);
            }
        }

        //// =============================================================================================
        ////=============================== DANH MUC SAN PHAM ============================================
        //// =============================================================================================

        public void loadListProduct(ComboBox cb)
        {
            cb.DataSource = daoReceipts.loadListProduct();
            cb.DisplayMember = "ProductName";
            cb.ValueMember = "ProductID";
        }

        public Product LoadDetails(int maSP)
        {
            return daoReceipts.loadPDetails(maSP);
        }

    }
}

