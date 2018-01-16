using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    public static class DataAccessFactory
    {
        private static string _connectionString = @"Data Source=QUOC-PC\SQLEXPRESS;Initial Catalog=QLBANHANG;Integrated Security=True";

        public static T Get<T>(string query, List<SqlParameter> parameters, CommandType commandType, Func<SqlDataReader, T> mapAction)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand();
                command.CommandType = commandType;
                command.CommandText = query;
                command.Connection = connection;
                if (parameters.Count > 0)
                {
                    command.Parameters.AddRange(parameters.ToArray());
                }

                return mapAction(command.ExecuteReader());
            }
        }

        public static void ExecuteNoneQuery(string sql, List<SqlParameter> parameters, CommandType commandType)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand();
                command.CommandType = commandType;
                command.CommandText = sql;
                command.Connection = connection;
                if (parameters.Count > 0)
                {
                    command.Parameters.AddRange(parameters.ToArray());
                }

                command.ExecuteNonQuery();
            }
        }
    }
}
