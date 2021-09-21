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
    public partial class FormSuppliers : Form
    {
        //
        Panel pnlLoadForm;
        BusSuppliers busSuppliers;

        //
        public FormSuppliers()
        {
            //
            InitializeComponent();
            busSuppliers = new BusSuppliers();
        }

        public FormSuppliers(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
            busSuppliers = new BusSuppliers();
        }

        private void FormSuppliers_Load(object sender, EventArgs e)
        {
            //
            busSuppliers.displayTableSuppliers(dgvSuppliers);
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

        private void dgvSuppliers_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;

            //
            if (e.RowIndex >= 0 && e.RowIndex < dgvSuppliers.Rows.Count)
            {
                tbCompanyName.Text = dgvSuppliers.Rows[e.RowIndex].Cells["CompanyName"].Value.ToString();
                tbContact.Text = dgvSuppliers.Rows[e.RowIndex].Cells["Contact"].Value.ToString();
                tbContactTitle.Text = dgvSuppliers.Rows[e.RowIndex].Cells["ContactTitle"].Value.ToString();
                tbAddress.Text = dgvSuppliers.Rows[e.RowIndex].Cells["Address"].Value.ToString();
                tbCity.Text = dgvSuppliers.Rows[e.RowIndex].Cells["City"].Value.ToString();
                tbDistrict.Text = dgvSuppliers.Rows[e.RowIndex].Cells["District"].Value.ToString();
                tbPhone.Text = dgvSuppliers.Rows[e.RowIndex].Cells["Phone"].Value.ToString();
                tbFax.Text = dgvSuppliers.Rows[e.RowIndex].Cells["Fax"].Value.ToString();
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            //
            tbCompanyName.Clear();
            tbContact.Clear();
            tbContactTitle.Clear();
            tbAddress.Clear();
            tbCity.Clear();
            tbDistrict.Clear();
            tbPhone.Clear();
            tbFax.Clear();

            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            String x = tbCompanyName.Text;
            //
            bool success = busSuppliers.addRecord(tbCompanyName, tbContact, tbContactTitle, tbAddress, tbCity, tbDistrict, tbPhone, tbFax);
            //
            dgvSuppliers.Columns.Clear();
            busSuppliers.displayTableSuppliers(dgvSuppliers);
            //
            if (success)
            {
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            //
            busSuppliers.editRecord(dgvSuppliers, tbCompanyName, tbContact, tbContactTitle, tbAddress, tbCity, tbDistrict, tbPhone, tbFax);
            //
            dgvSuppliers.Columns.Clear();
            busSuppliers.displayTableSuppliers(dgvSuppliers);
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            //
            busSuppliers.removeRecord(dgvSuppliers);
            //
            dgvSuppliers.Columns.Clear();
            busSuppliers.displayTableSuppliers(dgvSuppliers);
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }
    }
}
