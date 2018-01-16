using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class ProductModel
    {
        public int Id { get; set; }

        public string TenHang { get; set; }

        public string LoaiHang { get; set; }

        public string DonViTinh { get; set; }

        public string NhaSanXuat { get; set; }

        public int GiaNhap { get; set; }

        public int GiaXuat { get; set; }

        public int SoLuong { get; set; }

        public string KichThuoc { get; set; }
    }
}
