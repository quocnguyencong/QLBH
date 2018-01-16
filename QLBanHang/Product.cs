using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DataAccess;
using DataAccess.Models;

namespace QLBanHang
{
    public partial class Product : Form
    {
        public Product()
        {
            InitializeComponent();
            LoadInitData();
        }

        public void LoadInitData()
        {
            ProductDataAccess productDataAccess = new ProductDataAccess();
            var result = productDataAccess.GetAllProduct();
            gridProduct.DataSource = result;
        }

        private void gridProduct_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnThemSanPham_Click(object sender, EventArgs e)
        {
            AddEditProduct frmAddEditProduct = new AddEditProduct(this);
            frmAddEditProduct.Show();
        }
    }
}
