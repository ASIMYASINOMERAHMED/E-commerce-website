using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsResponseData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ResponseController : ControllerBase
    {
        [HttpGet("Responses-For-Customer {CustomerID}", Name = "GetResponsesForCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ResponseDTO>> GetResponsesForCustomerID(int CustomerID)
        {
            List<ResponseDTO> ResponseList = OnlineStoreBusiness.clsResponse.GetResponsesForCustomerID(CustomerID);
            if (ResponseList.Count == 0)
            {
                return NotFound("No Responses Found!");
            }
            return Ok(ResponseList);
        }
   
        [HttpGet("{ResponseID}", Name = "GetResponseByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ResponseDTO>> GetResponseByID(int ResponseID)
        {
            if (ResponseID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsResponse response = OnlineStoreBusiness.clsResponse.Find(ResponseID);

            if (response == null)
            {
                return NotFound($"Response not found.");
            }

            ResponseDTO DTO = response.ResponseDTO;

            return Ok(DTO);
        }
        [HttpPost("AddResponse", Name = "AddResponse")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ResponseDTO> AddResponse(ResponseDTO responseDTO)
        {

            if (responseDTO == null || string.IsNullOrEmpty(responseDTO.Response) || string.IsNullOrEmpty(responseDTO.Name) || responseDTO.OwnerID < 1|| responseDTO.CustomerID < 1|| responseDTO.MessageID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsResponse response = new OnlineStoreBusiness.clsResponse(new ResponseDTO(responseDTO.ResponseID, responseDTO.OwnerID, responseDTO.Name, responseDTO.Response, responseDTO.MessageID, responseDTO.DateTime, responseDTO.CustomerID));

            try
            {
                response.Save();
                return CreatedAtRoute("GetResponseByID", new { ResponseID = response.ResponseDTO }, responseDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }

        [HttpPut("UpdateResponse", Name = "UpdateResponse")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ResponseDTO> UpdateResponse(ResponseDTO UpdatedResponse)
        {

            if (UpdatedResponse == null || string.IsNullOrEmpty(UpdatedResponse.Response) || UpdatedResponse.ResponseID < 1 || UpdatedResponse.OwnerID < 1 ||
                UpdatedResponse.CustomerID < 1|| string.IsNullOrEmpty(UpdatedResponse.Name) || UpdatedResponse.MessageID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsResponse Response = OnlineStoreBusiness.clsResponse.Find(UpdatedResponse.ResponseID);


            if (Response == null)
            {
                return NotFound($"Response not found.");
            }


            Response.Response = UpdatedResponse.Response;
            Response.CustomerID = UpdatedResponse.CustomerID;
            Response.Name = UpdatedResponse.Name;
            Response.MessageID = UpdatedResponse.MessageID;
            Response.OwnerID = UpdatedResponse.OwnerID;
            try
            {
                Response.Save();

                return Ok(Response.ResponseDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Response {ResponseID}", Name = "DeleteResponse")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteResponse(int ResponseID)
        {
            if (ResponseID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsResponse.DeleteResponse(ResponseID))
                return Ok($"Response has been deleted.");
            else
                return NotFound($"Response not found. no rows deleted!");
        }
    }
}
