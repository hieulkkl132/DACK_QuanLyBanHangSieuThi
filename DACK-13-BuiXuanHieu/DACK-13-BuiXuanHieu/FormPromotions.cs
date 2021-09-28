﻿using DACK_13_BuiXuanHieu.BUS;
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
    public partial class FormPromotions : Form
    {
        //
        Panel pnlLoadForm;
        BusPromotions busPromotions;
        BusEvents busEvents;
        //
        public FormPromotions()
        {
            InitializeComponent();
            busPromotions = new BusPromotions();
            busEvents = new BusEvents();
        }

        public FormPromotions(Panel pnlLoadForm)
        {
            //

            InitializeComponent();
            this.pnlLoadForm = pnlLoadForm;
            busPromotions = new BusPromotions();
            busEvents = new BusEvents();
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




        private void FormPromotions_Load(object sender, EventArgs e)
        {
            dgvEvents.DataSource = null;
            dgvPromotions.DataSource = null;
            busPromotions.displayTablePromotions(dgvPromotions);
            cbProduct.Enabled = false;
            dtpEndDate.Enabled = false;
            dtpStartDate.Enabled = false;
            nudLimitQuantity.Enabled = false;
            nudDiscount.Enabled = false;
            cbPromotion.Enabled = false;
            tbPromotionName.Enabled = true;

        }

        private void tbtnManageEvents_CheckedChanged(object sender, EventArgs e)
        {
           
    
            
            if (tbtnManageEvents.Checked) // ON
            {
                dgvEvents.DataSource = null;
                dgvPromotions.Columns.Clear();
                busEvents.displayTableEvents(dgvEvents);
                busEvents.loadcbProducts(cbProduct);
                busEvents.loadcbPromotions(cbPromotion);
                //dgvPromotions.Enabled = false;
                //dgvEvents.Enabled = true;
                //dgvEvents.Columns[0].Visible = true;
                //dgvEvents.Columns[1].Visible = true;
                //dgvEvents.Columns[2].Visible = true;
                //dgvEvents.Columns[3].Visible = true;
                //dgvEvents.Columns[4].Visible = true;
                //dgvEvents.Columns[5].Visible = true;
                //dgvEvents.Columns[6].Visible = true;
                //dgvPromotions.Columns[0].Visible = false;
                //dgvPromotions.Columns[1].Visible = false;
                //dgvPromotions.Columns[2].Visible = false;
                cbProduct.Enabled = true;
                dtpEndDate.Enabled = true;
                dtpStartDate.Enabled = true;
                nudLimitQuantity.Enabled = true;
                nudDiscount.Enabled = true;
                cbPromotion.Enabled = true;
                tbPromotionName.Enabled = false;
                tbDescription.Clear();
                tbPromotionName.Clear();


            }
            else // OFF
            {
                //dgvPromotions.Enabled = true;
                //dgvEvents.Enabled = false;
                //dgvEvents.Columns[0].Visible = false;
                //dgvEvents.Columns[1].Visible = false;
                //dgvEvents.Columns[2].Visible = false;
                //dgvEvents.Columns[3].Visible = false;
                //dgvEvents.Columns[4].Visible = false;
                //dgvEvents.Columns[5].Visible = false;
                //dgvEvents.Columns[6].Visible = false;
                //dgvPromotions.Columns[0].Visible = true;
                //dgvPromotions.Columns[1].Visible = true;
                //dgvPromotions.Columns[2].Visible = true;
                dgvPromotions.DataSource = null;
                dgvEvents.Columns.Clear();
                busPromotions.displayTablePromotions(dgvPromotions);
                cbProduct.Enabled = false;
                dtpEndDate.Enabled = false;
                dtpStartDate.Enabled = false;
                nudLimitQuantity.Enabled = false;
                nudDiscount.Enabled = false;
                tbPromotionName.Enabled = true;
                cbPromotion.Enabled = false;
                tbDescription.Clear();
                nudLimitQuantity.Value = 0;
                nudDiscount.Value = 0;
                cbPromotion.Text = " ";
                cbProduct.Text = " ";
                //Xu ly, goi BUS cua Promotions.
            }
            // Xu ly, goi BUS cua Eventds.

        }

        private void dgvPromotions_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;

            //
            if (e.RowIndex >= 0 && e.RowIndex < dgvPromotions.Rows.Count)
            {

                tbPromotionName.Text = dgvPromotions.Rows[e.RowIndex].Cells["PromotionName"].Value.ToString();
                tbDescription.Text = dgvPromotions.Rows[e.RowIndex].Cells["Description"].Value.ToString();

            }
        }

        private void dgvEvents_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            btnAdd.Enabled = false;
            btnAdd.FlatAppearance.BorderSize = 1;

            //
            if (e.RowIndex >= 0 && e.RowIndex < dgvEvents.Rows.Count)
            {
                cbPromotion.Text = dgvEvents.Rows[e.RowIndex].Cells["PromotionID"].Value.ToString();
                cbProduct.Text = dgvEvents.Rows[e.RowIndex].Cells["ProductID"].Value.ToString();
                dtpStartDate.Text = dgvEvents.Rows[e.RowIndex].Cells["StartDate"].Value.ToString();
                dtpEndDate.Text = dgvEvents.Rows[e.RowIndex].Cells["EndDate"].Value.ToString();
                nudLimitQuantity.Text = dgvEvents.Rows[e.RowIndex].Cells["LimitQuantity"].Value.ToString();
                nudDiscount.Text = dgvEvents.Rows[e.RowIndex].Cells["Discount"].Value.ToString();
                tbDescription.Text = dgvEvents.Rows[e.RowIndex].Cells["Description"].Value.ToString();

            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            if (tbtnManageEvents.Checked) // ON
            {
                cbProduct.Text = " ";
                nudLimitQuantity.Value = 0;
                nudDiscount.Value = 0;
                cbPromotion.Text = " ";
                tbDescription.Clear();
                btnAdd.Enabled = true;
                btnAdd.FlatAppearance.BorderSize = 2;
            }
            else
            {
                tbDescription.Clear();
                tbPromotionName.Clear();
                btnAdd.Enabled = true;
                btnAdd.FlatAppearance.BorderSize = 2;
            }
        } 

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (tbtnManageEvents.Checked) // ON
            {
                bool success = busEvents.addRecord(cbPromotion, cbProduct, dtpStartDate , dtpEndDate, nudLimitQuantity , nudDiscount, tbDescription);
                //
                dgvEvents.Columns.Clear();
                busEvents.displayTableEvents(dgvEvents);
                //
                if (success)
                {
                    //btnAdd.Enabled = false;
                    btnAdd.FlatAppearance.BorderSize = 1;
                }
            }
            else
            {
                bool success = busPromotions.addRecord(tbPromotionName, tbDescription);
                //
                dgvPromotions.Columns.Clear();
                busPromotions.displayTablePromotions(dgvPromotions);
                //
                if (success)
                {
                    //btnAdd.Enabled = false;
                    btnAdd.FlatAppearance.BorderSize = 1;
                }
            }

        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (tbtnManageEvents.Checked) // ON
            {
                busEvents.editRecord(dgvEvents, dtpStartDate, dtpEndDate, nudLimitQuantity, nudDiscount, tbDescription);
                dgvEvents.Columns.Clear();
                busEvents.displayTableEvents(dgvEvents);
                //
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
            else
            {
                busPromotions.editRecord(dgvPromotions, tbPromotionName, tbDescription);
                //
                dgvPromotions.Columns.Clear();
                busPromotions.displayTablePromotions(dgvPromotions);
                //
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }

        private void btRemove_Click(object sender, EventArgs e)
        {
            if (tbtnManageEvents.Checked) // ON
            {
                busEvents.removeRecord(dgvEvents);
                //
                dgvEvents.Columns.Clear();
                busEvents.displayTableEvents(dgvEvents);
                //
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
            else
            {
                Promotion d = new Promotion();
                d.PromotionID = int.Parse(dgvPromotions.CurrentRow.Cells["PromotionID"].Value.ToString());
                busPromotions.removeRecord(d);
                //
                dgvPromotions.Columns.Clear();
                busPromotions.displayTablePromotions(dgvPromotions);
                //
                btnAdd.Enabled = false;
                btnAdd.FlatAppearance.BorderSize = 1;
            }
        }
    }


   
}

