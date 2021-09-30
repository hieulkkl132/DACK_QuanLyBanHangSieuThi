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
    public partial class FormMain : Form
    {
        //
        BusRoles bRoles;
        //
        public string Username = FormLogin.UserName;
        //
        public FormMain()
        {
            //
            InitializeComponent();
            //
            this.pnlLoadForm.Controls.Clear();
            FormHome formHome = new FormHome() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formHome.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formHome);
            formHome.Show();
            //
            btnHome.ForeColor = Color.Black;
            btnHome.BackColor = Color.White;
            btnManage.ForeColor = Color.Gray;
            btnManage.BackColor = Color.FromArgb(40, 40, 40);
            btnReport.ForeColor = Color.Gray;
            btnReport.BackColor = Color.FromArgb(40, 40, 40);
            btnAbout.ForeColor = Color.Gray;
            btnAbout.BackColor = Color.FromArgb(40, 40, 40);
            btnSignOut.ForeColor = Color.OrangeRed;
            btnSignOut.BackColor = Color.FromArgb(40, 40, 40);
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            this.MaximizeBox = false;
            bRoles = new BusRoles();
            this.MaximizeBox = false;
            lbUsername.Text = FormLogin.UserName;
            bool roles = bRoles.loadRolesByUsername(Username);
            if (roles == true)
            {
                lbLoginType.Text = "Manager";
            }
            else
            {
                lbLoginType.Text = "Staff";

            }
        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormHome formHome = new FormHome() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formHome.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formHome);
            formHome.Show();
            //
            btnHome.ForeColor = Color.Black;
            btnHome.BackColor = Color.White;
            btnManage.ForeColor = Color.Gray;
            btnManage.BackColor = Color.FromArgb(40, 40, 40);
            btnReport.ForeColor = Color.Gray;
            btnReport.BackColor = Color.FromArgb(40, 40, 40);
            btnAbout.ForeColor = Color.Gray;
            btnAbout.BackColor = Color.FromArgb(40, 40, 40);
            btnSignOut.ForeColor = Color.OrangeRed;
            btnSignOut.BackColor = Color.FromArgb(40, 40, 40);
        }

        private void btnManage_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormManage formManage = new FormManage(pnlLoadForm, this) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formManage.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formManage);
            formManage.Show();
            //
            btnHome.ForeColor = Color.Gray;
            btnHome.BackColor = Color.FromArgb(40, 40, 40);
            btnManage.ForeColor = Color.Black;
            btnManage.BackColor = Color.White;
            btnReport.ForeColor = Color.Gray;
            btnReport.BackColor = Color.FromArgb(40, 40, 40);
            btnAbout.ForeColor = Color.Gray;
            btnAbout.BackColor = Color.FromArgb(40, 40, 40);
            btnSignOut.ForeColor = Color.OrangeRed;
            btnSignOut.BackColor = Color.FromArgb(40, 40, 40);
        }

        private void btnReport_Click(object sender, EventArgs e)
        {

        }

        private void btnAbout_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormAbout formAbout = new FormAbout() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formAbout.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formAbout);
            formAbout.Show();
            //
            btnHome.ForeColor = Color.Gray;
            btnHome.BackColor = Color.FromArgb(40, 40, 40);
            btnManage.ForeColor = Color.Gray;
            btnManage.BackColor = Color.FromArgb(40, 40, 40);
            btnReport.ForeColor = Color.Gray;
            btnReport.BackColor = Color.FromArgb(40, 40, 40);
            btnAbout.ForeColor = Color.Black;
            btnAbout.BackColor = Color.White;
            btnSignOut.ForeColor = Color.OrangeRed;
            btnSignOut.BackColor = Color.FromArgb(40, 40, 40);
        }

        private void btnSignOut_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Are you sure you want to SIGN OUT ?", "Action confirm",
                                                  MessageBoxButtons.OKCancel,
                                                  MessageBoxIcon.Question);
            if (dr==DialogResult.Cancel)
            {
                
            }
            else
            {                
                this.Close();
                FormLogin formLogin = new FormLogin();
                formLogin.Show();
            }
        }

        private void btnSignOut_MouseHover(object sender, EventArgs e)
        {
            this.btnSignOut.BackColor = Color.White;
            this.btnSignOut.ForeColor = Color.Red;
        }

        private void btnSignOut_MouseLeave(object sender, EventArgs e)
        {
            this.btnSignOut.BackColor = Color.FromArgb(40, 40, 40);
            this.btnSignOut.ForeColor = Color.OrangeRed;
        }
    }
}
