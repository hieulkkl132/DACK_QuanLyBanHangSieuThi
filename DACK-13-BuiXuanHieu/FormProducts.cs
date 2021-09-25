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
    public partial class FormProducts : Form
    {
        //
        Panel pnlLoadForm;
        BusProducts busProduct;
        //
        public FormProducts()
        {
            InitializeComponent();
            busProduct = new BusProducts();
        }

        public FormProducts(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
            busProduct = new BusProducts();
        }

        public void lishShowProduct()
        {
            dgvProducts.DataSource = null;
            busProduct.displayTableProduct(dgvProducts);
            busProduct.displayComboboxCategory(cbCategory);
        }

        private void FormProducts_Load(object sender, EventArgs e)
        {
            lishShowProduct();
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormManage formManage = new FormManage(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formManage.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formManage);
            formManage.Show();
        }

        private void dgvProducts_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
            if (e.RowIndex >= 0 && e.RowIndex < dgvProducts.Rows.Count)
            {
                tbProductName.Text = dgvProducts.Rows[e.RowIndex].Cells[1].Value.ToString();
                cbCategory.Text = dgvProducts.Rows[e.RowIndex].Cells[2].Value.ToString();
                nudQuantityPerUnit.Text = dgvProducts.Rows[e.RowIndex].Cells[3].Value.ToString();
                nudUnitPrice.Text = dgvProducts.Rows[e.RowIndex].Cells[4].Value.ToString();
                nudUnitsInStock.Text = dgvProducts.Rows[e.RowIndex].Cells[5].Value.ToString();
                tbActive.Text = dgvProducts.Rows[e.RowIndex].Cells[6].Value.ToString();
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            tbProductName.Clear();
            cbCategory.SelectedIndex = -1;
            nudQuantityPerUnit.Value = 0;
            nudUnitPrice.Value = 0;
            nudUnitsInStock.Value = 0;
            tbActive.Clear();
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            bool success = busProduct.addRecord(tbProductName, cbCategory, nudQuantityPerUnit, nudUnitPrice, nudUnitsInStock, tbActive);
            dgvProducts.Columns.Clear();
            busProduct.displayTableProduct(dgvProducts);
            if (success)
            {
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            busProduct.editRecord(dgvProducts, tbProductName, cbCategory, nudQuantityPerUnit, nudUnitPrice, nudUnitsInStock, tbActive);
            dgvProducts.Columns.Clear();
            busProduct.displayTableProduct(dgvProducts);
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            busProduct.removeRecord(dgvProducts);
            dgvProducts.Columns.Clear();
            busProduct.displayTableProduct(dgvProducts);
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }
    }
}
