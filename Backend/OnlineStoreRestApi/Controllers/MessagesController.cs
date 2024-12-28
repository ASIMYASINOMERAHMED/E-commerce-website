using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsMessageData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessagesController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllMessages")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<MessageDTO>> GetAllMessages()
        {
            List<MessageListDTO> MessagesList = OnlineStoreBusiness.clsMessage.GetAllMessages();
            if (MessagesList.Count == 0)
            {
                return NotFound("No Messages Found!");
            }
            return Ok(MessagesList);
        }
        [HttpGet("CustomerID {CustomerID}", Name = "GetAllMessagesForCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<MessageDTO>> GetAllMessagesForCustomerID(int CustomerID)
        {
            List<MessageDTO> MessagesList = OnlineStoreBusiness.clsMessage.GetAllMessagesForCustomerID(CustomerID);
            if (MessagesList.Count == 0)
            {
                return NotFound("No Messages Found!");
            }
            return Ok(MessagesList);
        }
        [HttpGet("MessageID {MessageID}", Name = "GetMessageByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<MessageDTO>> GetMessageByID(int MessageID)
        {
            if (MessageID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsMessage message = OnlineStoreBusiness.clsMessage.Find(MessageID);

            if (message == null)
            {
                return NotFound($"Message not found.");
            }

            MessageDTO DTO = message.MessageDTO;

            return Ok(DTO);
        }
        [HttpPost("AddMesaage", Name = "AddMesaage")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<MessageDTO> AddMesaage(MessageDTO message)
        {

            if (message == null || string.IsNullOrEmpty(message.Message)
                || message.CustomerID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsMessage Message = new OnlineStoreBusiness.clsMessage(new MessageDTO(message.MessageID, message.CustomerID, message.Message, message.dateTime));

            try
            {
                Message.Save();

				return CreatedAtRoute("GetMessageByID", new { MessageID = message.MessageID }, message);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("MessageID {MessageID}", Name = "DeleteMessage")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteMessage(int MessageID)
        {
            if (MessageID < 0)
            {
                return BadRequest($"Not Accepted ID {MessageID}");
            }

            if (OnlineStoreBusiness.clsMessage.DeleteMessage(MessageID))
                return Ok($"Message has been deleted.");
            else
                return NotFound($"Message not found. no rows deleted!");
        }
        [HttpPut("UpdateMessage", Name = "UpdateMessage")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<MessageDTO> UpdateMessage(MessageDTO UpdatedMessage)
        {
            if (UpdatedMessage.MessageID < 1 || UpdatedMessage.CustomerID < 1 || UpdatedMessage == null
                || string.IsNullOrEmpty(UpdatedMessage.Message))
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsMessage Message = OnlineStoreBusiness.clsMessage.Find(UpdatedMessage.MessageID);


            if (Message == null)
            {
                return NotFound($"Message not found.");
            }


            Message.MessageID = UpdatedMessage.MessageID;
            Message.CustomerID = UpdatedMessage.CustomerID;
            Message.Message = UpdatedMessage.Message;
            Message.DateTime = UpdatedMessage.dateTime;
            try
            {
                Message.Save();

                return Ok(Message.MessageDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
    }
}
