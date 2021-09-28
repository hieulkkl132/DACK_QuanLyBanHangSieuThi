
namespace DACK_13_BuiXuanHieu
{
    partial class FormSuppliers
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormSuppliers));
            this.dgvSuppliers = new System.Windows.Forms.DataGridView();
            this.btnEdit = new System.Windows.Forms.Button();
            this.btnRemove = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.tbCompanyName = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.tbContact = new System.Windows.Forms.TextBox();
            this.tbContactTitle = new System.Windows.Forms.TextBox();
            this.tbAddress = new System.Windows.Forms.TextBox();
            this.tbCity = new System.Windows.Forms.TextBox();
            this.tbDistrict = new System.Windows.Forms.TextBox();
            this.tbPhone = new System.Windows.Forms.TextBox();
            this.tbFax = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label10 = new System.Windows.Forms.Label();
            this.btnBack = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSuppliers)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgvSuppliers
            // 
            this.dgvSuppliers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSuppliers.Location = new System.Drawing.Point(20, 450);
            this.dgvSuppliers.Name = "dgvSuppliers";
            this.dgvSuppliers.RowHeadersWidth = 51;
            this.dgvSuppliers.RowTemplate.Height = 24;
            this.dgvSuppliers.Size = new System.Drawing.Size(1070, 490);
            this.dgvSuppliers.TabIndex = 18;
            this.dgvSuppliers.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSuppliers_CellClick);
            // 
            // btnEdit
            // 
            this.btnEdit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnEdit.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnEdit.FlatAppearance.BorderSize = 2;
            this.btnEdit.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEdit.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEdit.ForeColor = System.Drawing.Color.Black;
            this.btnEdit.Location = new System.Drawing.Point(1110, 650);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(150, 80);
            this.btnEdit.TabIndex = 38;
            this.btnEdit.Text = "Edit";
            this.btnEdit.UseVisualStyleBackColor = true;
            this.btnEdit.Click += new System.EventHandler(this.btnEdit_Click);
            // 
            // btnRemove
            // 
            this.btnRemove.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnRemove.FlatAppearance.BorderColor = System.Drawing.Color.OrangeRed;
            this.btnRemove.FlatAppearance.BorderSize = 2;
            this.btnRemove.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRemove.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnRemove.ForeColor = System.Drawing.Color.OrangeRed;
            this.btnRemove.Location = new System.Drawing.Point(1110, 880);
            this.btnRemove.Name = "btnRemove";
            this.btnRemove.Size = new System.Drawing.Size(150, 60);
            this.btnRemove.TabIndex = 37;
            this.btnRemove.Text = "Remove";
            this.btnRemove.UseVisualStyleBackColor = true;
            this.btnRemove.Click += new System.EventHandler(this.btnRemove_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAdd.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnAdd.FlatAppearance.BorderSize = 2;
            this.btnAdd.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAdd.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAdd.ForeColor = System.Drawing.Color.Black;
            this.btnAdd.Location = new System.Drawing.Point(1110, 550);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(150, 80);
            this.btnAdd.TabIndex = 36;
            this.btnAdd.Text = "Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnClear
            // 
            this.btnClear.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnClear.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnClear.FlatAppearance.BorderSize = 2;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.Color.Black;
            this.btnClear.Location = new System.Drawing.Point(1110, 450);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(150, 80);
            this.btnClear.TabIndex = 35;
            this.btnClear.Text = "Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.Black;
            this.label2.Location = new System.Drawing.Point(50, 150);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(180, 29);
            this.label2.TabIndex = 40;
            this.label2.Text = "CompanyName";
            // 
            // tbCompanyName
            // 
            this.tbCompanyName.BackColor = System.Drawing.Color.White;
            this.tbCompanyName.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCompanyName.ForeColor = System.Drawing.Color.Black;
            this.tbCompanyName.Location = new System.Drawing.Point(250, 150);
            this.tbCompanyName.Name = "tbCompanyName";
            this.tbCompanyName.Size = new System.Drawing.Size(300, 34);
            this.tbCompanyName.TabIndex = 39;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(50, 210);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(94, 29);
            this.label3.TabIndex = 41;
            this.label3.Text = "Contact";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.Color.White;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.Black;
            this.label4.Location = new System.Drawing.Point(50, 270);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(142, 29);
            this.label4.TabIndex = 42;
            this.label4.Text = "ContactTitle";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.Color.White;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.ForeColor = System.Drawing.Color.Black;
            this.label5.Location = new System.Drawing.Point(50, 330);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(102, 29);
            this.label5.TabIndex = 43;
            this.label5.Text = "Address";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.BackColor = System.Drawing.Color.White;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.Black;
            this.label6.Location = new System.Drawing.Point(700, 150);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(53, 29);
            this.label6.TabIndex = 44;
            this.label6.Text = "City";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.BackColor = System.Drawing.Color.White;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.ForeColor = System.Drawing.Color.Black;
            this.label7.Location = new System.Drawing.Point(700, 210);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(86, 29);
            this.label7.TabIndex = 45;
            this.label7.Text = "District";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.BackColor = System.Drawing.Color.White;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.ForeColor = System.Drawing.Color.Black;
            this.label8.Location = new System.Drawing.Point(700, 270);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(83, 29);
            this.label8.TabIndex = 46;
            this.label8.Text = "Phone";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.BackColor = System.Drawing.Color.White;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.ForeColor = System.Drawing.Color.Black;
            this.label9.Location = new System.Drawing.Point(700, 330);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(52, 29);
            this.label9.TabIndex = 47;
            this.label9.Text = "Fax";
            // 
            // tbContact
            // 
            this.tbContact.BackColor = System.Drawing.Color.White;
            this.tbContact.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbContact.ForeColor = System.Drawing.Color.Black;
            this.tbContact.Location = new System.Drawing.Point(200, 210);
            this.tbContact.Name = "tbContact";
            this.tbContact.Size = new System.Drawing.Size(350, 34);
            this.tbContact.TabIndex = 48;
            // 
            // tbContactTitle
            // 
            this.tbContactTitle.BackColor = System.Drawing.Color.White;
            this.tbContactTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbContactTitle.ForeColor = System.Drawing.Color.Black;
            this.tbContactTitle.Location = new System.Drawing.Point(200, 270);
            this.tbContactTitle.Name = "tbContactTitle";
            this.tbContactTitle.Size = new System.Drawing.Size(350, 34);
            this.tbContactTitle.TabIndex = 49;
            // 
            // tbAddress
            // 
            this.tbAddress.BackColor = System.Drawing.Color.White;
            this.tbAddress.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAddress.ForeColor = System.Drawing.Color.Black;
            this.tbAddress.Location = new System.Drawing.Point(200, 330);
            this.tbAddress.Name = "tbAddress";
            this.tbAddress.Size = new System.Drawing.Size(350, 34);
            this.tbAddress.TabIndex = 50;
            // 
            // tbCity
            // 
            this.tbCity.BackColor = System.Drawing.Color.White;
            this.tbCity.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCity.ForeColor = System.Drawing.Color.Black;
            this.tbCity.Location = new System.Drawing.Point(850, 150);
            this.tbCity.Name = "tbCity";
            this.tbCity.Size = new System.Drawing.Size(350, 34);
            this.tbCity.TabIndex = 51;
            // 
            // tbDistrict
            // 
            this.tbDistrict.BackColor = System.Drawing.Color.White;
            this.tbDistrict.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbDistrict.ForeColor = System.Drawing.Color.Black;
            this.tbDistrict.Location = new System.Drawing.Point(850, 210);
            this.tbDistrict.Name = "tbDistrict";
            this.tbDistrict.Size = new System.Drawing.Size(350, 34);
            this.tbDistrict.TabIndex = 52;
            // 
            // tbPhone
            // 
            this.tbPhone.BackColor = System.Drawing.Color.White;
            this.tbPhone.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbPhone.ForeColor = System.Drawing.Color.Black;
            this.tbPhone.Location = new System.Drawing.Point(850, 270);
            this.tbPhone.Name = "tbPhone";
            this.tbPhone.Size = new System.Drawing.Size(350, 34);
            this.tbPhone.TabIndex = 53;
            // 
            // tbFax
            // 
            this.tbFax.BackColor = System.Drawing.Color.White;
            this.tbFax.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbFax.ForeColor = System.Drawing.Color.Black;
            this.tbFax.Location = new System.Drawing.Point(850, 330);
            this.tbFax.Name = "tbFax";
            this.tbFax.Size = new System.Drawing.Size(350, 34);
            this.tbFax.TabIndex = 54;
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.LightSalmon;
            this.panel1.Controls.Add(this.label10);
            this.panel1.Location = new System.Drawing.Point(140, 10);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(300, 100);
            this.panel1.TabIndex = 55;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 19.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(60, 30);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(162, 38);
            this.label10.TabIndex = 1;
            this.label10.Text = "Suppliers";
            // 
            // btnBack
            // 
            this.btnBack.BackColor = System.Drawing.Color.White;
            this.btnBack.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnBack.FlatAppearance.BorderColor = System.Drawing.Color.White;
            this.btnBack.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnBack.Image = ((System.Drawing.Image)(resources.GetObject("btnBack.Image")));
            this.btnBack.Location = new System.Drawing.Point(30, 30);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(70, 70);
            this.btnBack.TabIndex = 56;
            this.btnBack.UseVisualStyleBackColor = false;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // FormSuppliers
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1280, 953);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.tbFax);
            this.Controls.Add(this.tbPhone);
            this.Controls.Add(this.tbDistrict);
            this.Controls.Add(this.tbCity);
            this.Controls.Add(this.tbAddress);
            this.Controls.Add(this.tbContactTitle);
            this.Controls.Add(this.tbContact);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.tbCompanyName);
            this.Controls.Add(this.btnEdit);
            this.Controls.Add(this.btnRemove);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.dgvSuppliers);
            this.ForeColor = System.Drawing.Color.Black;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.MinimumSize = new System.Drawing.Size(1280, 953);
            this.Name = "FormSuppliers";
            this.Text = "FormSuppliers";
            this.Load += new System.EventHandler(this.FormSuppliers_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSuppliers)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DataGridView dgvSuppliers;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.Button btnRemove;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbCompanyName;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox tbContact;
        private System.Windows.Forms.TextBox tbContactTitle;
        private System.Windows.Forms.TextBox tbAddress;
        private System.Windows.Forms.TextBox tbCity;
        private System.Windows.Forms.TextBox tbDistrict;
        private System.Windows.Forms.TextBox tbPhone;
        private System.Windows.Forms.TextBox tbFax;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Button btnBack;
    }
}