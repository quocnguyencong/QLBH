using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.Models
{
    public class LookupDataAccess
    {
        public List<LookupModel> GetListLookup(string groupConfigName)
        {
            List<SqlParameter> parameters = new List<SqlParameter>() {
                new SqlParameter() { ParameterName = "@GroupConfigName", Value = groupConfigName}
            };
            return DataAccessFactory.Get<List<LookupModel>>("SelectLookupData", parameters, CommandType.StoredProcedure, dr => {
                List<LookupModel> dataReturn = new List<LookupModel>();
                while (dr.Read())
                {
                    dataReturn.Add(new LookupModel()
                    {
                        Id = Convert.ToInt32(dr["Id"]),
                        Ten = dr["Ten"].ToString()
                    });
                }

                return dataReturn;
            });
        }
    }
}
