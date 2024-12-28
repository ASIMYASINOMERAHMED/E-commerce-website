using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static OnlineStoreDataAccess.clsNotificationCustomerData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerNotificationController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllCustomerNotifications")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<NotificationCustomerDTO>> GetAllCustomerNotifications()
        {
            List<NotificationCustomerDTO> CustomerNotificationsList = OnlineStoreBusiness.clsNotificationCustomer.GetAllCustomerNotifications();
            if (CustomerNotificationsList.Count == 0)
            {
                return NotFound("No Notifications Found!");
            }
            return Ok(CustomerNotificationsList);
        }
        [HttpGet("{NotificationID}", Name = "GetCustomerNotificationByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<NotificationCustomerDTO>> GetCustomerNotificationByID(int NotificationID)
        {
            if (NotificationID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsNotificationCustomer Notification = OnlineStoreBusiness.clsNotificationCustomer.Find(NotificationID);

            if (Notification == null)
            {
                return NotFound($"Customer notification not found.");
            }

            NotificationCustomerDTO DTO = Notification.notificationCustomerDTO;

            return Ok(DTO);
        }

    }
}
