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
    public partial class AddEditProduct : Form
    {
        private Product frmProduct;
        public AddEditProduct()
        {
            InitializeComponent();
        }

        public AddEditProduct(Product product)
        {
            InitializeComponent();
            frmProduct = product;
            loadInitData();
        }

        private void loadInitData()
        {
            ProductDataAccess productDataAccess = new ProductDataAccess();
            var addEditProduct = productDataAccess.GetProductForCreate();

            cbbDonViTinh.DataSource = addEditProduct.DonViTinhSource;
            cbbDonViTinh.DisplayMember = "Ten";
            cbbDonViTinh.ValueMember = "Id";

            cbbKichThuoc.DataSource = addEditProduct.KichThuocSource;
            cbbKichThuoc.DisplayMember = "Ten";
            cbbKichThuoc.ValueMember = "Id";

            cbbLoaiHang.DataSource = addEditProduct.LoaiHangSource;
            cbbLoaiHang.DisplayMember = "Ten";
            cbbLoaiHang.ValueMember = "Id";

            cbbNhaSanXuat.DataSource = addEditProduct.NhaSanXuatSource;
            cbbNhaSanXuat.DisplayMember = "Ten";
            cbbNhaSanXuat.ValueMember = "Id";
        }

        private void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrWhiteSpace(txtTenHang.Text) || string.IsNullOrWhiteSpace(txtGiaNhap.Text) 
                || string.IsNullOrWhiteSpace(txtGiaXuat.Text) || string.IsNullOrWhiteSpace(txtSoLuong.Text))
            {
                var dialogResult = MessageBox.Show("Nhập dữ liệu là bắt buộc cho các trường: Tên hàng, Giá nhập, Giá xuất, Số lượng", "Error!", MessageBoxButtons.OK);
                if(dialogResult == DialogResult.OK)
                {
                    return;
                }
            }

            int giaNhap = 0;
            int giaXuat = 0;
            int soLuong = 0;
            if(!int.TryParse(txtGiaNhap.Text.Trim(),out giaNhap) || !int.TryParse(txtGiaXuat.Text.Trim(), out giaXuat) || !int.TryParse(txtSoLuong.Text.Trim(), out soLuong))
            {
                var dialogResult = MessageBox.Show("Nhập dữ liệu số cho các trường: Giá nhập, Giá xuất, Số lượng", "Error!", MessageBoxButtons.OK);
                if (dialogResult == DialogResult.OK)
                {
                    return;
                }
            }

            AddEditProductModel product = new AddEditProductModel()
            {
                TenHang = txtTenHang.Text.Trim(),
                LoaiHangId = (int)cbbLoaiHang.SelectedValue,
                DonViTinhId = (int)cbbDonViTinh.SelectedValue,
                NhaSanXuatId = (int)cbbNhaSanXuat.SelectedValue,
                GiaNhap = giaNhap,
                GiaXuat = giaXuat,
                SoLuong = soLuong,
                KichThuocId = Convert.ToInt32(cbbKichThuoc.SelectedValue)
            };

            try
            {
                ProductDataAccess productDataAccess = new ProductDataAccess();
                productDataAccess.AddProduct(product);
                frmProduct.LoadInitData();
                this.Close();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message, "Error!", MessageBoxButtons.OK);
            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
