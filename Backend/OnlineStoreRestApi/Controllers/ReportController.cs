using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static OnlineStoreDataAccess.clsReportData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReportController : ControllerBase
    {
        [HttpGet("Sales-Data", Name = "GetAllSalesData")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ReportDTO>> GetAllSalesData()
        {
            List<ReportDTO> SalesList = OnlineStoreBusiness.clsReport.GetAllSalesData();
            if (SalesList.Count == 0)
            {
                return NotFound("No Sales Data Found!");
            }
            return Ok(SalesList);
        }
        [HttpGet("Current-Year-Total-Sales", Name = "GetCurrentYearTotalSales")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ReportDTO>> GetCurrentYearTotalSales()
        {
            if (OnlineStoreBusiness.clsReport.GetAllSalesData().Count == 0)
            {
                return NotFound("No Sales Data Found!");
            }
            int TotalSales = OnlineStoreBusiness.clsReport.GetCurrentYearTotalSales();
            return Ok(TotalSales);
        }
        [HttpGet("Current-Year-Total-Revenue", Name = "GetCurrentYearTotalRevenue")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ReportDTO>> GetCurrentYearTotalRevenue()
        {
            if (OnlineStoreBusiness.clsReport.GetAllSalesData().Count == 0)
            {
                return NotFound("No Sales Data Found!");
            }
            decimal TotalRevenue = OnlineStoreBusiness.clsReport.GetCurrentYearTotalRevenue();
            return Ok(TotalRevenue);
        }
    }
}
