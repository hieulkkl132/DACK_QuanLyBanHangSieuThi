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
    public partial class FormManage : Form
    {
        //
        Panel pnlLoadForm;

        public FormManage()
        {
            InitializeComponent();
        }

        public FormManage(Panel pnlReceiveFromMainForm)
        {
            InitializeComponent();
            pnlLoadForm = pnlReceiveFromMainForm;
        }

        private void Manage_Load(object sender, EventArgs e)
        {
            this.pnlShadow1.BackColor = Color.FromArgb(20, Color.Black);
            this.pnlShadow2.BackColor = Color.FromArgb(20, Color.Black);
            this.pnlShadow3.BackColor = Color.FromArgb(20, Color.Black);
            this.pnlShadow4.BackColor = Color.FromArgb(20, Color.Black);
            this.pnlShadow5.BackColor = Color.FromArgb(20, Color.Black);
            this.pnlShadow6.BackColor = Color.FromArgb(20, Color.Black);
        }

        private void btnEmployees_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormEmployees formEmployees = new FormEmployees(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formEmployees.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formEmployees);
            formEmployees.Show();
        }

        private void btnProducts_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormProducts formProducts = new FormProducts(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formProducts.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formProducts);
            formProducts.Show();
        }

        private void btnReceipts_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormReceipts formReceipts = new FormReceipts(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formReceipts.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formReceipts);
            formReceipts.Show();
        }

        private void btnSuppliers_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormSuppliers formSuppliers = new FormSuppliers(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formSuppliers.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formSuppliers);
            formSuppliers.Show();
        }

        private void Promotions_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormPromotions formPromotions = new FormPromotions(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formPromotions.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formPromotions);
            formPromotions.Show();
        }

        private void btnCustomers_Click(object sender, EventArgs e)
        {
            //
            this.pnlLoadForm.Controls.Clear();
            FormCustomers formCustomers = new FormCustomers(pnlLoadForm) { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            formCustomers.FormBorderStyle = FormBorderStyle.None;
            this.pnlLoadForm.Controls.Add(formCustomers);
            formCustomers.Show();
        }

        
    }
}
