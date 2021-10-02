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

namespace DACK_13_BuiXuanHieu
{
    public partial class FormReceiptDetails : Form
    {
        public int index;
        public int ReceiptID;
        BusReceipts busReceipts;
        public FormReceiptDetails()
        {
            busReceipts = new BusReceipts();
            InitializeComponent();
        }

        private void btThem_Click(object sender, EventArgs e)
        {
            FormProductReceipts f = new FormProductReceipts();

            f.ReceiptID = this.ReceiptID;

            f.ShowDialog();
        }

        private void btXoa_Click(object sender, EventArgs e)
        {

            ReceiptDetail p = new ReceiptDetail();
            try
            {
                p.ReceiptID = Int32.Parse(tbReceipt.Text);
                p.ProductID = Int32.Parse(tbProduct.Text);
                busReceipts.RemoveRDetails(p);
                busReceipts.showRDetails(gVCTDH, p.ReceiptID);
                MessageBox.Show("Delete Success!!!");
            }
            catch (FormatException)
            {
                MessageBox.Show("Please fill with number only!");
            }
        }

        private void btSua_Click(object sender, EventArgs e)
        {
            ReceiptDetail o = new ReceiptDetail();
            try
            {
                o.ReceiptID = Int32.Parse(tbReceipt.Text);
                o.ProductID = Int32.Parse(tbProduct.Text);
                o.UnitPrice = double.Parse(tbPrice.Text);
                o.Quantity = short.Parse(tbQuantity.Text);
                busReceipts.EditRDetails(o);
                busReceipts.showRDetails(gVCTDH, o.ReceiptID);
                MessageBox.Show("Edit Success!!!");
            }
            catch (FormatException)
            {
                MessageBox.Show("Please fill with number only!");

            }
            gVCTDH.CurrentCell = gVCTDH.Rows[index].Cells[0];
            gVCTDH.Rows[index].Selected = true;
        }

        private void gVCTDH_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tbReceipt.Enabled = false;
            tbProduct.Enabled = false;
            btSua.Enabled = true;
            btXoa.Enabled = true;
            if (e.RowIndex >= 0 && e.RowIndex < gVCTDH.Rows.Count)
            {
                index = e.RowIndex;
                tbReceipt.Text = gVCTDH.Rows[e.RowIndex].Cells[0].Value.ToString();
                tbProduct.Text = gVCTDH.Rows[e.RowIndex].Cells[1].Value.ToString();
                tbPrice.Text = gVCTDH.Rows[e.RowIndex].Cells[2].Value.ToString();
                tbQuantity.Text = gVCTDH.Rows[e.RowIndex].Cells[3].Value.ToString();
            }
        }

        private void ShowRDetails(int ma)
        {
            gVCTDH.DataSource = null;
            busReceipts.showRDetails(gVCTDH, ma);

            gVCTDH.Columns[0].Width = (int)(0.2 * gVCTDH.Width);//20%
            gVCTDH.Columns[1].Width = (int)(0.3 * gVCTDH.Width);
            gVCTDH.Columns[2].Width = (int)(0.2 * gVCTDH.Width);
            gVCTDH.Columns[3].Width = (int)(0.2 * gVCTDH.Width);
        }

        private void FormReceiptDetails_Activated(object sender, EventArgs e)
        {
            btSua.Enabled = false;
            btXoa.Enabled = false;
            this.ShowRDetails(ReceiptID);
        }
    }
}
