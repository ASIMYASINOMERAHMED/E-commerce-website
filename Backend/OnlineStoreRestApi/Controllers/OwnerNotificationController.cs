using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static OnlineStoreDataAccess.clsNotificationOwnerData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OwnerNotificationController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllOwnerNotifications")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<NotificationOwnerDTO>> GetAllOwnerNotifications()
        {
            List<NotificationOwnerDTO> NotificationOwnerList = OnlineStoreBusiness.clsNotificationOwner.GetAllOwnerNotifications();
            if (NotificationOwnerList.Count == 0)
            {
                return NotFound("No Notifications Found!");
            }
            return Ok(NotificationOwnerList);
        }
        [HttpGet("WeeklySales", Name = "GetWeeklySales")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<WeeklySalesDTO>> GetWeeklySales()
        {
            List<WeeklySalesDTO> WeeklySalesList = OnlineStoreBusiness.clsNotificationOwner.GetWeeklySales();
            if (WeeklySalesList.Count == 0)
            {
                return NotFound("No Weekly Sales Data Found!");
            }
            return Ok(WeeklySalesList);
        }
        [HttpGet("Chart Data", Name = "GetChartData")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ChartDataDTO>> GetChartData()
        {
            List<ChartDataDTO> ChartDataList = OnlineStoreBusiness.clsNotificationOwner.GetChartData();
            if (ChartDataList.Count == 0)
            {
                return NotFound("No Chart Data Found!");
            }
            return Ok(ChartDataList);
        }
        [HttpGet("{NotificationID}", Name = "GetOwnerNotificationByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<NotificationOwnerDTO>> GetOwnerNotificationByID(int NotificationID)
        {
            if (NotificationID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsNotificationOwner Notification = OnlineStoreBusiness.clsNotificationOwner.Find(NotificationID);

            if (Notification == null)
            {
                return NotFound($"Notification not found.");
            }

            NotificationOwnerDTO DTO = Notification.notificationOwner;

            return Ok(DTO);
        }
    }
}
