using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace DataAccess
{
    public class ProductDataAccess
    {
        public List<ProductModel> GetAllProduct()
        {
            string query = "SelectProduct";
            return DataAccessFactory.Get<List<ProductModel>>(query, new List<SqlParameter>(), CommandType.StoredProcedure, dr => {
                List<ProductModel> dataReturn = new List<ProductModel>();
                while (dr.Read())
                {
                    dataReturn.Add(new ProductModel()
                    {
                        Id = Convert.ToInt32(dr["Id"]),
                        TenHang = dr["TenHang"].ToString(),
                        LoaiHang = dr["LoaiHang"].ToString(),
                        DonViTinh = dr["DonViTinh"].ToString(),
                        NhaSanXuat = dr["NhaSanXuat"].ToString(),
                        GiaNhap = Convert.ToInt32(dr["GiaNhap"]),
                        GiaXuat = Convert.ToInt32(dr["GiaXuat"]),
                        SoLuong = Convert.ToInt32(dr["SoLuong"]),
                        KichThuoc = dr["KichThuoc"].ToString()
                    });
                }
                return dataReturn;
            });
        }

        public AddEditProductModel GetProductForCreate()
        {
            AddEditProductModel product = new AddEditProductModel();
            LookupDataAccess lookupDataAccess = new LookupDataAccess();
            product.DonViTinhSource = lookupDataAccess.GetListLookup("DonViTinh");
            product.KichThuocSource = lookupDataAccess.GetListLookup("KichThuoc");
            product.LoaiHangSource = lookupDataAccess.GetListLookup("LoaiHang");
            product.NhaSanXuatSource = lookupDataAccess.GetListLookup("NhaSanXuat");
            return product;
        } 

        public void AddProduct(AddEditProductModel product)
        {
            List<SqlParameter> parameters = new List<SqlParameter>() {
                new SqlParameter("@TenHang", product.TenHang),
                new SqlParameter("@LoaiHangId", product.LoaiHangId),
                new SqlParameter("@DonViTinhId", product.DonViTinhId),
                new SqlParameter("@NhaSanXuatId", product.NhaSanXuatId),
                new SqlParameter("@GiaNhap", product.GiaNhap),
                new SqlParameter("@GiaXuat", product.GiaXuat),
                new SqlParameter("@SoLuong", product.SoLuong),
                new SqlParameter("@KichThuocId", product.KichThuocId),
            };

            DataAccessFactory.ExecuteNoneQuery("InsertProduct", parameters, CommandType.StoredProcedure);
        }
    }
}
