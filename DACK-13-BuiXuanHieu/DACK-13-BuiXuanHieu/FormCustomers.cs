﻿using System;
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
    public partial class FormCustomers : Form
    {
        //
        Panel pnlLoadForm;

        //
        public FormCustomers()
        {
            InitializeComponent();
        }

        public FormCustomers(Panel pnlLoadForm)
        {
            //
            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
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
    }
}
