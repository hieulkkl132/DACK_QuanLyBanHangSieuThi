using DACK_13_BuiXuanHieu.BUS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DACK_13_BuiXuanHieu.REPORT;
namespace DACK_13_BuiXuanHieu
{
    public partial class FormProductReceipts : Form
    {
        bool co = false;
        DataTable dtdh;
        int index;
        private BusReceipts busReceipts;
        private BusProducts busProducts;
        public int ReceiptID;
        public FormProductReceipts()
        {
            busReceipts = new BusReceipts();
            busProducts = new BusProducts();
            InitializeComponent();
        }

        private void btTaoDonHang_Click(object sender, EventArgs e)
        {
            bool result = busReceipts.AddRDetails(ReceiptID, dtdh);
            if (result)
            {
                this.Close();
            }
        }

        private void btThem_Click(object sender, EventArgs e)
        {
            DataRow r;
            bool kiemTraSP = true;
            foreach (DataRow item in dtdh.Rows)
            {
                if (cbSP.SelectedValue.ToString() == item[0].ToString())
                {
                    item[2] = int.Parse(item[2].ToString()) + nudSL.Value;
                    kiemTraSP = false;
                    break;
                }
            }

            if (kiemTraSP)
            {
                try
                {
                    r = dtdh.NewRow();
                    r[0] = Int32.Parse(cbSP.SelectedValue.ToString());
                    r[1] = float.Parse(tbPrice.Text.Replace(".", ""));
                    r[2] = Convert.ToInt32(nudSL.Value);
                    r[3] = Convert.ToDecimal(nuddis.Value);

                    dtdh.Rows.Add(r);
                }
                catch (FormatException)
                {
                    MessageBox.Show("Please fill into the blank and only number is alow.");
                }
            }
        }

        private void btXoa_Click(object sender, EventArgs e)
        {
            try
            {
                dGSP.Rows.RemoveAt(index);
                MessageBox.Show("Delete Success!!!");
            }
            catch (Exception)
            {
                MessageBox.Show("Please fill into the blank and only number is alow.");
            }
        }

        private void btSua_Click(object sender, EventArgs e)
        {
            int r = index;// datagridview_cellclick and assign current index to index 

            try
            {
                dGSP.Rows[r].Cells[0].Value = Int32.Parse(cbSP.SelectedValue.ToString());
                dGSP.Rows[r].Cells[1].Value = Int32.Parse(tbPrice.Text.Replace(".", ""));
                dGSP.Rows[r].Cells[2].Value = Convert.ToInt32(nudSL.Value);
                dGSP.Rows[r].Cells[3].Value = Convert.ToDecimal(nuddis.Value);
                MessageBox.Show("Edit Success!!!");
            }
            catch (Exception)
            {
                MessageBox.Show("Please fill into the blank and only number is alow.");
            }
        }

        private void dGSP_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int maSP;
            Product p;
            tbCategory.Enabled = false;
            if (e.RowIndex >= 0 && e.RowIndex < dGSP.Rows.Count - 1)
            {
                index = e.RowIndex;
                cbSP.SelectedIndex = Int32.Parse(dGSP.Rows[e.RowIndex].Cells["ProductID"].Value.ToString()) - 1;
                tbPrice.Text = dGSP.Rows[e.RowIndex].Cells[1].Value.ToString();
                nudSL.Value = Int32.Parse(dGSP.Rows[e.RowIndex].Cells[2].Value.ToString());
                nuddis.Text = dGSP.Rows[e.RowIndex].Cells[3].Value.ToString();

                // set value for any item remain
                maSP = Int32.Parse(cbSP.SelectedValue.ToString());
                p = busReceipts.LoadDetails(maSP);

                tbCategory.Text = p.Category.CategoryName.ToString();
                tbPrice.Text = p.UnitPrice.ToString();
            }
            else
            {
                index = dGSP.Rows.Count - 1;
            }
        }

        private void FormProductReceiptcs_Load(object sender, EventArgs e)
        {
            busReceipts.loadListProduct(cbSP);
            co = true;
            btTaoDonHang.Enabled = false;
            tbReceipt.Text = ReceiptID.ToString();
            tbReceipt.Enabled = false;
            tbCategory.Enabled = false;
            dtdh = new DataTable();
            dtdh.Columns.Add("ProductID");
            dtdh.Columns.Add("UnitPrice");
            dtdh.Columns.Add("Quantity");
            dtdh.Columns.Add("Discount");
            dGSP.DataSource = dtdh;

            dGSP.Columns[0].Width = (int)(0.25 * dGSP.Width);//20%
            dGSP.Columns[1].Width = (int)(0.3 * dGSP.Width);
            dGSP.Columns[2].Width = (int)(0.2 * dGSP.Width);
            dGSP.Columns[3].Width = (int)(0.2 * dGSP.Width);
        }

        private void cbSP_SelectedIndexChanged(object sender, EventArgs e)
        {
            Product p;
            int Pid;

            if (co)
            {
                btTaoDonHang.Enabled = true;
                Pid = Int32.Parse(cbSP.SelectedValue.ToString());
                p = busReceipts.LoadDetails(Pid);

                tbCategory.Text = p.Category.CategoryName.ToString();
                tbPrice.Text = p.UnitPrice.ToString();
            }
        }

        private void btReport_Click(object sender, EventArgs e)
        {
            ListProduct l = new ListProduct();
            FormReport f = new FormReport();
            l.SetDataSource ( busProducts.ListProducts().ToList());
            f.crystalReportViewer1.ReportSource = l;
            f.Show();
        }
    }
}
