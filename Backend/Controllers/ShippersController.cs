using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsReportData;
using static OnlineStoreDataAccess.clsShippersData;
using static Online_Store_Project.clsGlobal;
using Online_Store_Project;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShippersController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllShippers")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ShippersDTO>> GetAllShippers()
        {
            List<ShippersDTO> ShippersList = OnlineStoreBusiness.clsShippers.GetAllShipperData();
            if (ShippersList.Count == 0)
            {
                return NotFound("No SubCategories Found!");
            }
            return Ok(ShippersList);
        }
        [HttpGet("Shippers", Name = "GetAllShippersName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<string>> GetAllShippersName()
        {
            List<string> ShippersList = OnlineStoreBusiness.clsShippers.GetAllShippersName();
            if (ShippersList.Count == 0)
            {
                return NotFound("No Carriers Found!");
            }
            return Ok(ShippersList);
        }
        [HttpGet("{CarrierID}", Name = "GetShipperByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippersDataDTO>> GetShipperByID(int CarrierID)
        {
            if (CarrierID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsShippers Carrier = OnlineStoreBusiness.clsShippers.Find(CarrierID);

            if (Carrier == null)
            {
                return NotFound($"Carrier not found.");
            }

            ShippersDataDTO DTO = Carrier.ShippersDataDTO;

            return Ok(DTO);
        }
        [HttpGet("CarrierName {CarrierName}", Name = "GetShipperByName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippersDataDTO>> GetShipperByName(string CarrierName)
        {
           
            OnlineStoreBusiness.clsShippers Carrier = OnlineStoreBusiness.clsShippers.Find(CarrierName);

            if (Carrier == null)
            {
                return NotFound($"Carrier not found.");
            }

            ShippersDTO DTO = Carrier.ShippersDTO;

            return Ok(DTO);
        }
        [HttpGet("UserName {UserName}", Name = "GetShipperByUserName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippersDataDTO>> GetShipperByUserName(string UserName)
        {

            OnlineStoreBusiness.clsShippers Carrier = OnlineStoreBusiness.clsShippers.FindByUserName(UserName);

            if (Carrier == null)
            {
                return NotFound($"Carrier not found.");
            }

            ShippersDataDTO DTO = Carrier.ShippersDataDTO;

            return Ok(DTO);
        }
        [HttpGet("Carrier {UserName}/ {Password}", Name = "GetShipperByUserNameAndPassword")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ShippersDTO>> GetShipperByUserNameAndPassword(string UserName,string Password)
        {

            OnlineStoreBusiness.clsShippers Carrier = OnlineStoreBusiness.clsShippers.Find(UserName,Password);

            if (Carrier == null)
            {
                return NotFound($"Carrier not found.");
            }

            ShippersDataDTO DTO = Carrier.ShippersDataDTO;

            return Ok(DTO);
        }
        [HttpPost("AddCarrier", Name = "AddCarrier")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ShippersDataDTO> AddCarrier(ShippersDataDTO shippersDTO)
        {

            if (shippersDTO == null || string.IsNullOrEmpty(shippersDTO.CarrierName) || string.IsNullOrEmpty(shippersDTO.UserName) || string.IsNullOrEmpty(shippersDTO.Password) || string.IsNullOrEmpty(shippersDTO.Email) || string.IsNullOrEmpty(shippersDTO.Phone)||shippersDTO.InsertByUserID<=0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsShippers Carrier = new OnlineStoreBusiness.clsShippers(new ShippersDataDTO(shippersDTO.CarrierID, shippersDTO.CarrierName, shippersDTO.Email, shippersDTO.Phone, shippersDTO.UserName,clsGlobal.ComputeHash(shippersDTO.Password),shippersDTO.InsertByUserID));

            try
            {
                Carrier.Save();
                return CreatedAtRoute("GetShipperByID", new { CarrierID = Carrier.CarrierID }, shippersDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }

        [HttpPut("UpdateCarrier", Name = "UpdateCarrier")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ShippersDataDTO> UpdateCarrier(ShippersDataDTO UpdatedCarrier)
        {


            if (UpdatedCarrier == null)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsShippers Carrier = OnlineStoreBusiness.clsShippers.Find(UpdatedCarrier.CarrierID);


            if (Carrier == null)
            {
                return NotFound($"Carrier not found.");
            }

            if(UpdatedCarrier.CarrierName!="")
                 Carrier.CarrierName = UpdatedCarrier.CarrierName;
            if(UpdatedCarrier.Phone!="")
                 Carrier.Phone = UpdatedCarrier.Phone;
            if(UpdatedCarrier.Email!="")
                 Carrier.Email = UpdatedCarrier.Email;
            if(UpdatedCarrier.UserName!="")
                 Carrier.UserName = UpdatedCarrier.UserName;
            if(UpdatedCarrier.Password!=null||UpdatedCarrier.Password!="")
                 Carrier.Password = clsGlobal.ComputeHash(UpdatedCarrier.Password);
            if(UpdatedCarrier.InsertByUserID!=0)
                 Carrier.InsertByUserID = UpdatedCarrier.InsertByUserID;
            try
            {
                Carrier.Save();

                return Ok(Carrier.ShippersDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Carrier {CarrierID}", Name = "DeleteCarrier")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteCarrier(int CarrierID)
        {
            if (CarrierID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsShippers.DeleteShipper(CarrierID))
                return Ok($"Carrier has been deleted.");
            else
                return NotFound($"Carrier not found. no rows deleted!");
        }
        [HttpGet("Check-Shipper-Exist", Name = "IsShipperExist")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> IsShipperExist(string UserName)
        {

            bool UserExist = OnlineStoreBusiness.clsShippers.IsUserExist(UserName);
            return Ok(UserExist);
        }
    }
}

