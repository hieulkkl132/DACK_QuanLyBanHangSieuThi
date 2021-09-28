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
            busReceipts.displayTableReceipts(dgvReceipts);
            dgvReceipts.Columns[0].Width = (int)(0.1 * dgvReceipts.Width);
            dgvReceipts.Columns[1].Width = (int)(0.1 * dgvReceipts.Width);
            dgvReceipts.Columns[2].Width = (int)(0.1 * dgvReceipts.Width);
            dgvReceipts.Columns[3].Width = (int)(0.31 * dgvReceipts.Width);
            dgvReceipts.Columns[4].Width = (int)(0.31 * dgvReceipts.Width);
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
            String x = tbEmployee.Text;

            bool success = busReceipts.addRecord(tbEmployee, tbCustomer, tbReceiveMethod, dtpReceiveDate);
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
                tbEmployee.Text = dgvReceipts.Rows[e.RowIndex].Cells["EmployeeID"].Value.ToString();
                tbCustomer.Text = dgvReceipts.Rows[e.RowIndex].Cells["CustomerID"].Value.ToString();
                tbReceiveMethod.Text = dgvReceipts.Rows[e.RowIndex].Cells["ReceiveMethod"].Value.ToString();
                dtpReceiveDate.Text = dgvReceipts.Rows[e.RowIndex].Cells["ReceiveDate"].Value.ToString();
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            busReceipts.editRecord(dgvReceipts, tbEmployee, tbCustomer, tbReceiveMethod, dtpReceiveDate);
            //
            dgvReceipts.Columns.Clear();
            UpdateGv();
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            tbCustomer.Clear();
            tbEmployee.Clear();
            tbReceiveMethod.Clear();
           

            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        private void btRemove_Click(object sender, EventArgs e)
        {
            busReceipts.removeRecord(dgvReceipts);
            //
            dgvReceipts.Columns.Clear();
            UpdateGv();
            //
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }
    }
}
