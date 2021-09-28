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
    public partial class FormCustomers : Form
    {

        //
        Panel pnlLoadForm;
        FormMain formMain;

        //
        BusCustomers bCustomer;

        //
        public FormCustomers()
        {
            InitializeComponent();
            bCustomer = new BusCustomers();
        }

        public FormCustomers(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            bCustomer = new BusCustomers();
            this.pnlLoadForm = pnlLoadForm;
            showListCustomer();

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

        //Hiển thị danh sách khách hàng
        private void showListCustomer()
        {
            
            dgvCustomers.DataSource = null;
            bCustomer.getListCustomer(dgvCustomers);
            dgvCustomers.Columns[0].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[1].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[2].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[3].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[4].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[5].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[6].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[7].Width = (int)(dgvCustomers.Width * 0.25);
            dgvCustomers.Columns[8].Width = (int)(dgvCustomers.Width * 0.25);
        }

        // hiển thị lên textbox
        private void dgvCustomers_CellClick_1(object sender, DataGridViewCellEventArgs e)
        {
            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 2;

            //           
            if (e.RowIndex >= 0 && e.RowIndex < dgvCustomers.Rows.Count)
            {
                if (dgvCustomers.Rows[e.RowIndex].Cells["MemberID"].Value == null)
                {
                    tbMemberID.Text = "";
                }
                else
                {
                    tbMemberID.Text = dgvCustomers.Rows[e.RowIndex].Cells["MemberID"].Value.ToString();
                    tbLastName.Text = dgvCustomers.Rows[e.RowIndex].Cells["LastName"].Value.ToString();
                    tbFIrstName.Text = dgvCustomers.Rows[e.RowIndex].Cells["FirstName"].Value.ToString();
                    dtpBirthDate.Text = dgvCustomers.Rows[e.RowIndex].Cells["BirthDate"].Value.ToString();
                    tbAddress.Text = dgvCustomers.Rows[e.RowIndex].Cells["Address"].Value.ToString();
                    tbCity.Text = dgvCustomers.Rows[e.RowIndex].Cells["City"].Value.ToString();
                    tbDistrict.Text = dgvCustomers.Rows[e.RowIndex].Cells["District"].Value.ToString();
                    tbPhone.Text = dgvCustomers.Rows[e.RowIndex].Cells["Phone"].Value.ToString();
                    tbEmail.Text = dgvCustomers.Rows[e.RowIndex].Cells["Email"].Value.ToString();
                }
            }    
        }

        private void FormCustomers_Load(object sender, EventArgs e)
        {
            bCustomer.getListCustomer(dgvCustomers);
        }

        // xử lý thêm khách hàng
        private void btnAdd_Click(object sender, EventArgs e)
        {
            
            bool success = bCustomer.addRecord(tbLastName, tbFIrstName, dtpBirthDate, tbAddress, tbCity, tbDistrict, tbPhone, tbEmail);

            dgvCustomers.Columns.Clear();
            bCustomer.getListCustomer(dgvCustomers);

            if (success)
            {
                btnAdd.Enabled = true;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }

        // xử lý xóa các trường đang nhập trên textbox
        private void btnClear_Click(object sender, EventArgs e)
        {
            tbMemberID.Clear();
            tbLastName.Clear();
            tbFIrstName.Clear();
            tbAddress.Clear();
            tbCity.Clear();
            tbDistrict.Clear();
            tbEmail.Clear();
            tbPhone.Clear();


            
            btnAdd.FlatAppearance.BorderSize = 2;
        }

        // xử lý sửa thông tin khách hàng
        private void btnEdit_Click(object sender, EventArgs e)
        {
            //
            bCustomer.editRecord(dgvCustomers, tbMemberID, tbLastName, tbFIrstName,dtpBirthDate, tbAddress, tbCity, tbDistrict, tbPhone, tbEmail);
            //
            dgvCustomers.Columns.Clear();
            bCustomer.getListCustomer(dgvCustomers);
            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        // xử lý xóa một dòng khách hàng 
        private void btnRemove_Click(object sender, EventArgs e)
        {
            //
            bCustomer.removeRecord(dgvCustomers);
            //
            dgvCustomers.Columns.Clear();
            
            bCustomer.getListCustomer(dgvCustomers);
            //
            btnAdd.Enabled = true;
            btnAdd.FlatAppearance.BorderSize = 1;
        }

        private void btnAssignMember_Click(object sender, EventArgs e)
        {
            FormAssignMember formAssignMember = new FormAssignMember(formMain, dgvCustomers);
            formAssignMember.Show();
        }

        private void dgvCustomers_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }
    }
}
