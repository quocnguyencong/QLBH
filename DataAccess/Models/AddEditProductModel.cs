using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class AddEditProductModel
    {
        public int Id { get; set; }

        public string TenHang { get; set; }

        public List<LookupModel> LoaiHangSource { get; set; }

        public int LoaiHangId { get; set; }

        public List<LookupModel> DonViTinhSource { get; set; }

        public int DonViTinhId { get; set; }

        public List<LookupModel> NhaSanXuatSource { get; set; }

        public int NhaSanXuatId { get; set; }

        public int GiaNhap { get; set; }

        public int GiaXuat { get; set; }

        public int SoLuong { get; set; }

        public List<LookupModel> KichThuocSource { get; set; }

        public int KichThuocId { get; set; }
    }
}
