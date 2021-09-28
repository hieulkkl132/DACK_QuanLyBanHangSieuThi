
namespace DACK_13_BuiXuanHieu
{
    partial class FormCustomers
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormCustomers));
            this.dgvCustomers = new System.Windows.Forms.DataGridView();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label10 = new System.Windows.Forms.Label();
            this.btnEdit = new System.Windows.Forms.Button();
            this.btnRemove = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.tbMemberID = new System.Windows.Forms.TextBox();
            this.tbLastName = new System.Windows.Forms.TextBox();
            this.tbFIrstName = new System.Windows.Forms.TextBox();
            this.tbAddress = new System.Windows.Forms.TextBox();
            this.tbCity = new System.Windows.Forms.TextBox();
            this.tbDistrict = new System.Windows.Forms.TextBox();
            this.tbPhone = new System.Windows.Forms.TextBox();
            this.tbEmail = new System.Windows.Forms.TextBox();
            this.dtpBirthDate = new System.Windows.Forms.DateTimePicker();
            this.btnAssignMember = new System.Windows.Forms.Button();
            this.btnBack = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCustomers)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgvCustomers
            // 
            this.dgvCustomers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvCustomers.Location = new System.Drawing.Point(20, 449);
            this.dgvCustomers.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgvCustomers.Name = "dgvCustomers";
            this.dgvCustomers.RowHeadersWidth = 51;
            this.dgvCustomers.RowTemplate.Height = 24;
            this.dgvCustomers.Size = new System.Drawing.Size(1071, 490);
            this.dgvCustomers.TabIndex = 19;
            this.dgvCustomers.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvCustomers_CellClick_1);
            this.dgvCustomers.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvCustomers_CellContentClick);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.LightGoldenrodYellow;
            this.panel1.Controls.Add(this.label10);
            this.panel1.Location = new System.Drawing.Point(140, 10);
            this.panel1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(300, 100);
            this.panel1.TabIndex = 56;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 19.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(60, 31);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(185, 38);
            this.label10.TabIndex = 1;
            this.label10.Text = "Customers";
            // 
            // btnEdit
            // 
            this.btnEdit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnEdit.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnEdit.FlatAppearance.BorderSize = 2;
            this.btnEdit.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEdit.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEdit.ForeColor = System.Drawing.Color.Black;
            this.btnEdit.Location = new System.Drawing.Point(1111, 650);
            this.btnEdit.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(151, 80);
            this.btnEdit.TabIndex = 60;
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
            this.btnRemove.Location = new System.Drawing.Point(1111, 880);
            this.btnRemove.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnRemove.Name = "btnRemove";
            this.btnRemove.Size = new System.Drawing.Size(151, 60);
            this.btnRemove.TabIndex = 59;
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
            this.btnAdd.Location = new System.Drawing.Point(1111, 550);
            this.btnAdd.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(151, 80);
            this.btnAdd.TabIndex = 58;
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
            this.btnClear.Location = new System.Drawing.Point(1111, 449);
            this.btnClear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(151, 80);
            this.btnClear.TabIndex = 57;
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
            this.label2.Location = new System.Drawing.Point(49, 150);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(126, 29);
            this.label2.TabIndex = 61;
            this.label2.Text = "MemberID";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(49, 209);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(122, 29);
            this.label1.TabIndex = 62;
            this.label1.Text = "LastName";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(49, 271);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(125, 29);
            this.label3.TabIndex = 63;
            this.label3.Text = "FirstName";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.Color.White;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.Black;
            this.label4.Location = new System.Drawing.Point(49, 330);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(112, 29);
            this.label4.TabIndex = 64;
            this.label4.Text = "BirthDate";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.Color.White;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.ForeColor = System.Drawing.Color.Black;
            this.label5.Location = new System.Drawing.Point(49, 390);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(102, 29);
            this.label5.TabIndex = 65;
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
            this.label6.TabIndex = 66;
            this.label6.Text = "City";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.BackColor = System.Drawing.Color.White;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.ForeColor = System.Drawing.Color.Black;
            this.label7.Location = new System.Drawing.Point(700, 209);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(86, 29);
            this.label7.TabIndex = 67;
            this.label7.Text = "District";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.BackColor = System.Drawing.Color.White;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.ForeColor = System.Drawing.Color.Black;
            this.label8.Location = new System.Drawing.Point(700, 271);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(83, 29);
            this.label8.TabIndex = 68;
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
            this.label9.Size = new System.Drawing.Size(74, 29);
            this.label9.TabIndex = 69;
            this.label9.Text = "Email";
            // 
            // tbMemberID
            // 
            this.tbMemberID.BackColor = System.Drawing.Color.White;
            this.tbMemberID.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbMemberID.ForeColor = System.Drawing.Color.Black;
            this.tbMemberID.Location = new System.Drawing.Point(200, 150);
            this.tbMemberID.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbMemberID.Name = "tbMemberID";
            this.tbMemberID.ReadOnly = true;
            this.tbMemberID.Size = new System.Drawing.Size(349, 34);
            this.tbMemberID.TabIndex = 70;
            // 
            // tbLastName
            // 
            this.tbLastName.BackColor = System.Drawing.Color.White;
            this.tbLastName.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbLastName.ForeColor = System.Drawing.Color.Black;
            this.tbLastName.Location = new System.Drawing.Point(200, 209);
            this.tbLastName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbLastName.Name = "tbLastName";
            this.tbLastName.Size = new System.Drawing.Size(349, 34);
            this.tbLastName.TabIndex = 71;
            // 
            // tbFIrstName
            // 
            this.tbFIrstName.BackColor = System.Drawing.Color.White;
            this.tbFIrstName.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbFIrstName.ForeColor = System.Drawing.Color.Black;
            this.tbFIrstName.Location = new System.Drawing.Point(200, 271);
            this.tbFIrstName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbFIrstName.Name = "tbFIrstName";
            this.tbFIrstName.Size = new System.Drawing.Size(349, 34);
            this.tbFIrstName.TabIndex = 72;
            // 
            // tbAddress
            // 
            this.tbAddress.BackColor = System.Drawing.Color.White;
            this.tbAddress.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAddress.ForeColor = System.Drawing.Color.Black;
            this.tbAddress.Location = new System.Drawing.Point(200, 390);
            this.tbAddress.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbAddress.Name = "tbAddress";
            this.tbAddress.Size = new System.Drawing.Size(349, 34);
            this.tbAddress.TabIndex = 73;
            // 
            // tbCity
            // 
            this.tbCity.BackColor = System.Drawing.Color.White;
            this.tbCity.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCity.ForeColor = System.Drawing.Color.Black;
            this.tbCity.Location = new System.Drawing.Point(849, 150);
            this.tbCity.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbCity.Name = "tbCity";
            this.tbCity.Size = new System.Drawing.Size(349, 34);
            this.tbCity.TabIndex = 74;
            // 
            // tbDistrict
            // 
            this.tbDistrict.BackColor = System.Drawing.Color.White;
            this.tbDistrict.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbDistrict.ForeColor = System.Drawing.Color.Black;
            this.tbDistrict.Location = new System.Drawing.Point(849, 209);
            this.tbDistrict.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbDistrict.Name = "tbDistrict";
            this.tbDistrict.Size = new System.Drawing.Size(349, 34);
            this.tbDistrict.TabIndex = 75;
            // 
            // tbPhone
            // 
            this.tbPhone.BackColor = System.Drawing.Color.White;
            this.tbPhone.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbPhone.ForeColor = System.Drawing.Color.Black;
            this.tbPhone.Location = new System.Drawing.Point(849, 271);
            this.tbPhone.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbPhone.Name = "tbPhone";
            this.tbPhone.Size = new System.Drawing.Size(349, 34);
            this.tbPhone.TabIndex = 76;
            // 
            // tbEmail
            // 
            this.tbEmail.BackColor = System.Drawing.Color.White;
            this.tbEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbEmail.ForeColor = System.Drawing.Color.Black;
            this.tbEmail.Location = new System.Drawing.Point(849, 330);
            this.tbEmail.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.tbEmail.Name = "tbEmail";
            this.tbEmail.Size = new System.Drawing.Size(349, 34);
            this.tbEmail.TabIndex = 77;
            // 
            // dtpBirthDate
            // 
            this.dtpBirthDate.CustomFormat = "dd-MM-yyyy";
            this.dtpBirthDate.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpBirthDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpBirthDate.Location = new System.Drawing.Point(200, 330);
            this.dtpBirthDate.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtpBirthDate.Name = "dtpBirthDate";
            this.dtpBirthDate.Size = new System.Drawing.Size(349, 34);
            this.dtpBirthDate.TabIndex = 78;
            // 
            // btnAssignMember
            // 
            this.btnAssignMember.BackColor = System.Drawing.Color.LightCyan;
            this.btnAssignMember.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAssignMember.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnAssignMember.FlatAppearance.BorderSize = 2;
            this.btnAssignMember.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAssignMember.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAssignMember.Location = new System.Drawing.Point(951, 60);
            this.btnAssignMember.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnAssignMember.Name = "btnAssignMember";
            this.btnAssignMember.Size = new System.Drawing.Size(249, 60);
            this.btnAssignMember.TabIndex = 79;
            this.btnAssignMember.Text = "Assign Member";
            this.btnAssignMember.UseVisualStyleBackColor = false;
            this.btnAssignMember.Click += new System.EventHandler(this.btnAssignMember_Click);
            // 
            // btnBack
            // 
            this.btnBack.BackColor = System.Drawing.Color.White;
            this.btnBack.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnBack.FlatAppearance.BorderColor = System.Drawing.Color.White;
            this.btnBack.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnBack.Image = ((System.Drawing.Image)(resources.GetObject("btnBack.Image")));
            this.btnBack.Location = new System.Drawing.Point(31, 31);
            this.btnBack.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(71, 70);
            this.btnBack.TabIndex = 80;
            this.btnBack.UseVisualStyleBackColor = false;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // FormCustomers
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1280, 838);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.btnAssignMember);
            this.Controls.Add(this.dtpBirthDate);
            this.Controls.Add(this.tbEmail);
            this.Controls.Add(this.tbPhone);
            this.Controls.Add(this.tbDistrict);
            this.Controls.Add(this.tbCity);
            this.Controls.Add(this.tbAddress);
            this.Controls.Add(this.tbFIrstName);
            this.Controls.Add(this.tbLastName);
            this.Controls.Add(this.tbMemberID);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btnEdit);
            this.Controls.Add(this.btnRemove);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.dgvCustomers);
            this.ForeColor = System.Drawing.Color.Black;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "FormCustomers";
            this.Text = "FormCustomers";
            this.Load += new System.EventHandler(this.FormCustomers_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvCustomers)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvCustomers;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.Button btnRemove;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox tbMemberID;
        private System.Windows.Forms.TextBox tbLastName;
        private System.Windows.Forms.TextBox tbFIrstName;
        private System.Windows.Forms.TextBox tbAddress;
        private System.Windows.Forms.TextBox tbCity;
        private System.Windows.Forms.TextBox tbDistrict;
        private System.Windows.Forms.TextBox tbPhone;
        private System.Windows.Forms.TextBox tbEmail;
        private System.Windows.Forms.DateTimePicker dtpBirthDate;
        private System.Windows.Forms.Button btnAssignMember;
        private System.Windows.Forms.Button btnBack;
    }
}