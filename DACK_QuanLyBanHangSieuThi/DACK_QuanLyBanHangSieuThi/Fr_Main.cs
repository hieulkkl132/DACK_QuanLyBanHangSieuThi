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
    public partial class Fr_Main : Form
    {
        public Fr_Main()
        {
            InitializeComponent();
        }

        private void nhânViênToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Fr_NhanVien f = new Fr_NhanVien();
            f.StartPosition = FormStartPosition.CenterScreen;
            f.Show();
        }
    }
}
