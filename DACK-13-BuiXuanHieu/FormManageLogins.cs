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
    public partial class FormManageLogins : Form
    {
        //
        BusLogins busLogins;
        BusEmployees busEmployees;
        FormMain formMain;
        DataGridView dgvEmployees;

        public FormManageLogins()
        {
            InitializeComponent();
        }

        public FormManageLogins(FormMain formMain, DataGridView dgvEmployees)
        {
            //
            InitializeComponent();
            busLogins = new BusLogins();
            busEmployees = new BusEmployees();
            this.formMain = formMain;
            this.dgvEmployees = dgvEmployees;
        }

        private void FormManageLogins_Load(object sender, EventArgs e)
        {
            //
            formMain.Enabled = false;

            //
            String lastName = dgvEmployees.CurrentRow.Cells["LastName"].Value.ToString();
            String firstName = dgvEmployees.CurrentRow.Cells["FirstName"].Value.ToString();
            lbEmployee.Text = lastName + " " + firstName;

            // display CB
            busLogins.displayComboBox(cbLoginType);

            //
            if (dgvEmployees.CurrentRow.Cells["LoginID"].Value == null)
            {
                //
                rdbtnAssign.Enabled = true; rdbtnAssign.Checked = true;
                rdbtnEdit.Enabled = false;
                rdbtnRemove.Enabled = false;

                //
                cbLoginType.Text = "";

                
            }
            else 
            {
                //
                rdbtnAssign.Enabled = false;
                rdbtnEdit.Enabled = true; rdbtnEdit.Checked = true;
                rdbtnRemove.Enabled = true;

                //
                int loginID = int.Parse(dgvEmployees.CurrentRow.Cells["LoginID"].Value.ToString());
                busLogins.displayLoginInfo(loginID, tbUsername, cbLoginType, tbPassword);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            //
            this.Close();

        }

        private void FormManageLogins_FormClosed(object sender, FormClosedEventArgs e)
        {
            //
            formMain.Enabled = true;
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            //
            if (rdbtnAssign.Checked)
            {
                //
                int employeeID = int.Parse(dgvEmployees.CurrentRow.Cells["EmployeeID"].Value.ToString());
                busLogins.assignLogin(employeeID, tbUsername, cbLoginType, tbPassword, tbRetype);

                //
                dgvEmployees.Columns.Clear();
                busEmployees.displayTableEmployees(dgvEmployees);
            }
            else if (rdbtnEdit.Checked)
            {

            }
            else if (rdbtnRemove.Checked)
            { 
                
            }
        }
    }
}
