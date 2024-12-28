using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsReportData;
using static OnlineStoreDataAccess.clsShippingData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShippingController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllShippings")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ShippingDataDTO>> GetAllShippings()
        {
            List<ShippingDataDTO> ShippingsList = OnlineStoreBusiness.clsShipping.GetAllShippings();
            if (ShippingsList.Count == 0)
            {
                return NotFound("No Shippings Found!");
            }
            return Ok(ShippingsList);
        }
        [HttpGet("Delivered-Shippings{CarrierID}", Name = "GetAllDeliveredShippingsForCarrierID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ShippingDataDTO>> GetAllDeliveredShippingsForCarrierID(int CarrierID)
        {
            List<ShippingDataDTO> DeliveredShippingsList = OnlineStoreBusiness.clsShipping.GetAllDeliveredShippingsForCarrierID(CarrierID);
            if (DeliveredShippingsList.Count == 0)
            {
                return NotFound("No Shippings Found!");
            }
            return Ok(DeliveredShippingsList);
        }
        [HttpGet("All-Shippings{CarrierID}", Name = "GetAllShippingsForCarrierID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ShippingDataDTO>> GetAllShippingsForCarrierID(int CarrierID)
        {
            List<ShippingDataDTO> ShippingsList = OnlineStoreBusiness.clsShipping.GetAllShippingsForCarrierID(CarrierID);
            if (ShippingsList.Count == 0)
            {
                return NotFound("No Shippings Found!");
            }
            return Ok(ShippingsList);
        }

        [HttpGet("Shipping {ShippingID}", Name = "GetShippingByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippingDTO>> GetShippingByID(int ShippingID)
        {
            if (ShippingID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsShipping Shipping = OnlineStoreBusiness.clsShipping.Find(ShippingID);

            if (Shipping == null)
            {
                return NotFound($"Shipping not found.");
            }

            ShippingDTO DTO = Shipping.ShippingDTO;

            return Ok(DTO);
        }

        [HttpGet("Shipping-For-TrackingNumber {TrackingNumner}", Name = "GetShippingByTrackingNumber")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippingDTO>> GetShippingByTrackingNumber(string TrackingNumner)
        {
          
            OnlineStoreBusiness.clsShipping Shipping = OnlineStoreBusiness.clsShipping.Find(TrackingNumner);

            if (Shipping == null)
            {
                return NotFound($"Shipping not found.");
            }

            ShippingDTO DTO = Shipping.ShippingDTO;

            return Ok(DTO);
        }
        [HttpPost("AddShipping", Name = "AddShipping")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ShippingDTO> AddShipping(ShippingDTO ShippingDTO)
        {

            if (ShippingDTO == null || string.IsNullOrEmpty(ShippingDTO.TrackingNumber) || ShippingDTO.OrderID < 1 || ShippingDTO.CarrierID < 1 || ShippingDTO.Status < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsShipping Shipping = new OnlineStoreBusiness.clsShipping(new ShippingDTO(ShippingDTO.ShippingID, ShippingDTO.OrderID, ShippingDTO.CarrierID, ShippingDTO.TrackingNumber, ShippingDTO.Status, ShippingDTO.EstimatedDeliveryDate, ShippingDTO.ActualDeliveryDate));

            try
            {
                Shipping.Save();
                ShippingDTO.ShippingID = Shipping.ShippingID;
                return CreatedAtRoute("GetShippingByID", new { ShippingID = Shipping.ShippingID }, ShippingDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }

        [HttpPut("UpdateShipping", Name = "UpdateShipping")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ShippingDTO> UpdateShipping(ShippingDTO UpdatedShipping)
        {
            if (UpdatedShipping == null || string.IsNullOrEmpty(UpdatedShipping.TrackingNumber) || UpdatedShipping.OrderID < 1 || UpdatedShipping.CarrierID < 1 || UpdatedShipping.Status < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsShipping shipping = OnlineStoreBusiness.clsShipping.Find(UpdatedShipping.ShippingID);


            if (shipping == null)
            {
                return NotFound($"Shipping not found.");
            }


            shipping.TrackingNumber = UpdatedShipping.TrackingNumber;
            shipping.ActualDeliveryDate = UpdatedShipping.ActualDeliveryDate;
            shipping.EstimatedDeliveryDate = UpdatedShipping.EstimatedDeliveryDate;
            shipping.OrderID = UpdatedShipping.OrderID;
            shipping.CarrierID = UpdatedShipping.CarrierID;
            shipping.Status = (OnlineStoreBusiness.clsShipping.enShippingStatus)UpdatedShipping.Status;
            try
            {
                shipping.Save();

                return Ok(shipping.ShippingDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Shipping {ShippingID}", Name = "DeleteShipping")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteShipping(int ShippingID)
        {
            if (ShippingID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsShipping.Delete(ShippingID))
                return Ok($"Shipping has been deleted.");
            else
                return NotFound($"Shipping not found. no rows deleted!");
        }
        [HttpGet("Deliver-Order", Name = "DeliverOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> DeliverOrder(int ShippingID)
        {
            OnlineStoreBusiness.clsShipping shipping = OnlineStoreBusiness.clsShipping.Find(ShippingID);


            if (shipping == null)
            {
                return NotFound($"Shipping Order not found.");
            }

            bool DeliverOrder = shipping.DeliverOrder();
            return Ok(DeliverOrder);
        }
        [HttpGet("Cancel-Order", Name = "CancelOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> CancelOrder(int ShippingID)
        {
            OnlineStoreBusiness.clsShipping shipping = OnlineStoreBusiness.clsShipping.Find(ShippingID);


            if (shipping == null)
            {
                return NotFound($"Shipping Order not found.");
            }

            bool CancelOrder = shipping.CancelOrder();
            return Ok(CancelOrder);
        }
    }
}