using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsPaymentData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {

        [HttpGet("{PaymentID}", Name = "GetPaymentByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<PaymentDTO>> GetPaymentByID(int PaymentID)
        {
            if (PaymentID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsPayment payment = OnlineStoreBusiness.clsPayment.Find(PaymentID);

            if (payment == null)
            {
                return NotFound($"Payment not found.");
            }

            PaymentDTO DTO = payment.PaymentDTO;

            return Ok(DTO);
        }
        [HttpPost("AddPayment", Name = "AddPayment")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<PaymentDTO> AddPayment(PaymentDTO Payment)
        {

            if (Payment == null || string.IsNullOrEmpty(Payment.PaymentMethod)
                || Payment.OrderID < 1||Payment.Amount<0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsPayment payment = new OnlineStoreBusiness.clsPayment(new PaymentDTO(Payment.PaymentID,Payment.OrderID,Payment.Amount,Payment.PaymentMethod,Payment.TransactionDate));

            try
            {
                payment.Save();
                
                return CreatedAtRoute("GetPaymentByID", new { PaymentID = payment.PaymentID }, Payment);
                

            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete Payment {PaymentID}", Name = "DeletePayment")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeletePayment(int PaymentID)
        {
            if (PaymentID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsPayment.Delete(PaymentID))
                return Ok($"Payment has been deleted.");
            else
                return NotFound($"Payment not found. no rows deleted!");
        }
        [HttpPut("UpdatePayment", Name = "UpdatePayment")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<PaymentDTO> UpdatePayment(PaymentDTO UpdatedPayment)
        {
            if (UpdatedPayment == null || string.IsNullOrEmpty(UpdatedPayment.PaymentMethod)
                || UpdatedPayment.OrderID < 1 || UpdatedPayment.Amount < 0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsPayment Payment = OnlineStoreBusiness.clsPayment.Find(UpdatedPayment.PaymentID);


            if (Payment == null)
            {
                return NotFound($"Payment not found.");
            }


            Payment.Amount = UpdatedPayment.Amount;
            Payment.PaymentMethod = UpdatedPayment.PaymentMethod;
            Payment.OrderID = UpdatedPayment.OrderID;

            try
            {

                Payment.Save();

                return Ok(Payment.PaymentDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
    }
}
