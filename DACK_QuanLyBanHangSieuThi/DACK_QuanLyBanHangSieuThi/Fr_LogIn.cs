using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DACK_QuanLyBanHangSieuThi
{
    public partial class Fr_LogIn : Form
    {
        public Fr_LogIn()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void Fr_LogIn_Load(object sender, EventArgs e)
        {

        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Fr_SignIn f = new Fr_SignIn();
            f.StartPosition = FormStartPosition.CenterScreen;
            f.Show();
        }
    }
}
