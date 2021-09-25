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
    public partial class FormEmployees : Form
    {
        //
        Panel pnlLoadForm;
        BusEmployees busEmployees;
        //
        public FormEmployees()
        {
            InitializeComponent();
            busEmployees = new BusEmployees();
        }

        public FormEmployees(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
            busEmployees = new BusEmployees();
        }

        private void FormEmployees_Load(object sender, EventArgs e)
        {
            busEmployees.displayTableEmployees(dgvEmployees);
            busEmployees.displayComboboxPositions(cbPosition);
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

        private void btnClear_Click(object sender, EventArgs e)
        {
            tbLoginID.Clear();
            tbLastName.Clear();
            tbFirstName.Clear();
            cbPosition.SelectedIndex = -1;
            dtpBirthDate.ResetText();
            tbAddress.Clear();
            tbCity.Clear();
            tbDistrict.Clear();
            tbPhone.Clear();
            tbEmail.Clear();
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        private void dgvEmployees_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
            tbLoginID.Enabled = false;
            if (e.RowIndex >= 0 && e.RowIndex < dgvEmployees.Rows.Count)
            {
                tbLoginID.Text = dgvEmployees.Rows[e.RowIndex].Cells["EmployeeID"].Value.ToString();
                tbLastName.Text = dgvEmployees.Rows[e.RowIndex].Cells["LastName"].Value.ToString();
                tbFirstName.Text = dgvEmployees.Rows[e.RowIndex].Cells["FirstName"].Value.ToString();
                cbPosition.Text = dgvEmployees.Rows[e.RowIndex].Cells[3].Value.ToString();
                dtpBirthDate.Text = dgvEmployees.Rows[e.RowIndex].Cells["BirthDate"].Value.ToString();
                tbAddress.Text = dgvEmployees.Rows[e.RowIndex].Cells["Address"].Value.ToString();
                tbCity.Text = dgvEmployees.Rows[e.RowIndex].Cells["City"].Value.ToString();
                tbDistrict.Text = dgvEmployees.Rows[e.RowIndex].Cells["District"].Value.ToString();
                tbPhone.Text = dgvEmployees.Rows[e.RowIndex].Cells["Phone"].Value.ToString();
                tbEmail.Text = dgvEmployees.Rows[e.RowIndex].Cells["Email"].Value.ToString();
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            bool success = busEmployees.addRecord(tbLastName, tbFirstName, cbPosition, dtpBirthDate, tbAddress, tbCity, tbDistrict, tbPhone, tbEmail);
            dgvEmployees.Columns.Clear();
            busEmployees.displayTableEmployees(dgvEmployees);
            if (success)
            {
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            busEmployees.editRecord(dgvEmployees, tbLastName, tbFirstName, cbPosition, dtpBirthDate, tbAddress, tbCity, tbDistrict, tbPhone, tbEmail);
            dgvEmployees.Columns.Clear();
            busEmployees.displayTableEmployees(dgvEmployees);
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            busEmployees.removeRecord(dgvEmployees);
            dgvEmployees.Columns.Clear();
            busEmployees.displayTableEmployees(dgvEmployees);
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;
        }
    }
}
