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
    public partial class FormLogin : Form
    {
        BusLogins busLogins;
        public FormLogin()
        {
            
            InitializeComponent();
        }

        private void btnSignIn_Click(object sender, EventArgs e)
        {
            bool check = busLogins.checkAccount(tbUsername, tbPassword);
            //
            if (check==true)
            {
                this.Visible = false;
                FormMain mainForm = new FormMain();
                mainForm.Show();
            }
            else
            {
                MessageBox.Show("Incorrect Username or Password! Please type again", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                tbUsername.Focus();
                return;
            }


        }

        //bool checkAccount(string userName, string passWord)
        //{
        //    userName = "abc";
        //    passWord = "abc";
        //    return false;   
        //}

        private void FormLogin_Load(object sender, EventArgs e)
        {
            busLogins = new BusLogins();
        }
    }
}
