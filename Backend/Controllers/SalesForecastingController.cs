using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Reflection;
using static OnlineStoreDataAccess.clsReportData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SalesForecastingController : ControllerBase
    {
        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }
        [HttpGet("PredictTotalSalesAndRevenue", Name = "PredictTotalSalesAndRevenue")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<string>> PredictTotalSalesAndRevenue(int Year , int Month)
        {
            List<ReportDTO> SalesList = OnlineStoreBusiness.clsReport.GetAllSalesData();
            if (SalesList.Count == 0)
            {
                return NotFound("No Sales Data Found!");
            }
            string PredictTotalSalesAndRevenue = OnlineStoreBusiness.clsSalesForcasting.PredictTotalSalesAndRevenue(ToDataTable(SalesList),Year,Month);
            return Ok(PredictTotalSalesAndRevenue);
        }
        [HttpGet("TrainModel", Name = "TrainModel")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<string>> TrainModel(int Year, int Month)
        {
            List<ReportDTO> SalesList = OnlineStoreBusiness.clsReport.GetAllSalesData();
            if (SalesList.Count == 0)
            {
                return NotFound("No Sales Data Found!");
            }
            string PredictTotalSalesAndRevenue = OnlineStoreBusiness.clsSalesForcasting.TrainModel(ToDataTable(SalesList), Year, Month);
            return Ok(PredictTotalSalesAndRevenue);
        }
    }
}
