using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DACK_13_BuiXuanHieu.BUS;
namespace DACK_13_BuiXuanHieu
{
    public partial class FormReceipts : Form
    {
        //
        Panel pnlLoadForm;
        BusReceipts busReceipts;
        //
        public FormReceipts()
        {
            InitializeComponent();
            busReceipts = new BusReceipts();
        }
        public void UpdateGv()
        {
            dgvReceipts.DataSource = null;
            busReceipts.displayComboboxCustomer(cbCustomer);
            busReceipts.displayComboboxEmployee(cbEmployee);
            busReceipts.displayTableReceipts(dgvReceipts);
            dgvReceipts.Columns[0].Width = (int)(0.17 * dgvReceipts.Width);
            dgvReceipts.Columns[1].Width = (int)(0.18 * dgvReceipts.Width);
            dgvReceipts.Columns[2].Width = (int)(0.18 * dgvReceipts.Width);
            dgvReceipts.Columns[3].Width = (int)(0.19 * dgvReceipts.Width);
            dgvReceipts.Columns[4].Width = (int)(0.20 * dgvReceipts.Width);
        }
        public FormReceipts(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
            busReceipts = new BusReceipts();
        }

        private void FormReceipts_Load(object sender, EventArgs e)
        {
            UpdateGv();
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

        private void btnAdd_Click(object sender, EventArgs e)
        {
            bool success = busReceipts.addRecord(cbEmployee, cbCustomer, tbReceiveMethod, dtpReceiveDate);
            //
            dgvReceipts.Columns.Clear();
            UpdateGv();
            //
            if (success)
            {
                //btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }

        }

        private void dgvReceipts_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
            //
            if (e.RowIndex >= 0 && e.RowIndex < dgvReceipts.Rows.Count)
            {
                cbEmployee.Text = dgvReceipts.Rows[e.RowIndex].Cells["FirstName"].Value.ToString();
                cbCustomer.Text = dgvReceipts.Rows[e.RowIndex].Cells["LastName"].Value.ToString();
                tbReceiveMethod.Text = dgvReceipts.Rows[e.RowIndex].Cells["ReceiveMethod"].Value.ToString();
                dtpReceiveDate.Text = dgvReceipts.Rows[e.RowIndex].Cells["ReceiveDate"].Value.ToString();
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            busReceipts.editRecord(dgvReceipts, cbEmployee, cbCustomer, tbReceiveMethod, dtpReceiveDate);
            //
            dgvReceipts.Columns.Clear();
            UpdateGv();
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            cbCustomer.SelectedValue = -1;
            cbEmployee.SelectedValue = -1;
            tbReceiveMethod.Clear();
            dtpReceiveDate.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 5, 30, 0);

            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            busReceipts.removeRecord(dgvReceipts);
            //
            dgvReceipts.Columns.Clear();
            UpdateGv();
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dgvReceipts_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            FormReceiptDetails f = new FormReceiptDetails();
            f.ReceiptID = int.Parse(dgvReceipts.CurrentRow.Cells[0].Value.ToString());
            f.ShowDialog();
        }
    }
}
