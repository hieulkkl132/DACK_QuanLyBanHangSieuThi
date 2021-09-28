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
    public partial class FormAssignMember : Form
    {

        #region DeclareVariable
        BusCustomers bCustomer;
        FormMain formMain;
        DataGridView dgvCustomers; 
        #endregion


        public FormAssignMember(FormMain formMain, DataGridView dgvCustomers)
        {
            InitializeComponent();
            bCustomer = new BusCustomers();
            this.formMain = formMain;
            this.dgvCustomers = dgvCustomers;

        }

        private void FormAssignMember_Load(object sender, EventArgs e)
        {
            tbCustomer.Enabled = false;
            String lastName = dgvCustomers.CurrentRow.Cells["LastName"].Value.ToString();
            String firstName = dgvCustomers.CurrentRow.Cells["FirstName"].Value.ToString();
            tbCustomer.Text = lastName + " " + firstName;
            //
            if (dgvCustomers.CurrentRow.Cells["MemberID"].Value == null)
            {
                btnAssign.Enabled = true;              
                
            }
            else
            {
                //
                btnAssign.Enabled = false;
                int memberID = int.Parse(dgvCustomers.CurrentRow.Cells["MemberID"].Value.ToString());
                bCustomer.displayMemberInfo(memberID, tbRank, dtpJoinDate, numPoint);
            }

            //
            
        }


        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        //
        private void btnAssign_Click(object sender, EventArgs e)
        {
            int customerID = int.Parse(dgvCustomers.CurrentRow.Cells["CustomerID"].Value.ToString());
            bCustomer.assignMember(this, customerID, tbRank, dtpJoinDate, numPoint);
            dgvCustomers.Columns.Clear();
            bCustomer.getListCustomer(dgvCustomers);
        }

        private void cbRank_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void FormAssignMember_FormClosed(object sender, FormClosedEventArgs e)
        {
            //formMain.Enabled = true;
        }

    }       
}
































