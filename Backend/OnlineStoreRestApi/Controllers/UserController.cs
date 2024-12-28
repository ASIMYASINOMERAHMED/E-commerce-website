using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Online_Store_Project;
using OnlineStoreBusiness;
using System.Net;
using static OnlineStoreDataAccess.clsUsersData;


namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        [HttpGet("All-Users", Name = "GetAllUsers")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<UserDTO>> GetAllUsers()
        {
            List<UserDTO> UsersList = OnlineStoreBusiness.clsUser.GetAllUsers();
            if (UsersList.Count == 0)
            {
                return NotFound("No Users Found!");
            }
            return Ok(UsersList);
        }
        [HttpGet("UserID {UserID}", Name = "GetUserByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<UserDTO>> GetUserByID(int UserID)
        {
            if (UserID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsUser user = OnlineStoreBusiness.clsUser.Find(UserID);

            if (user == null)
            {
                return NotFound($"User not found.");
            }

            DetailedUserDTO DTO = user.DetailedUserDTO;

            return Ok(DTO);
        }
        [HttpGet("UserName {UserName}", Name = "GetUserByUserName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<UserDTO>> GetUserByUserName(string UserName)
        {
           
            OnlineStoreBusiness.clsUser user = OnlineStoreBusiness.clsUser.Find(UserName);

            if (user == null)
            {
                return NotFound($"User not found.");
            }

            DetailedUserDTO DTO = user.DetailedUserDTO;

            return Ok(DTO);
        }
        [HttpGet("UserName {UserName}/ Password {Password}", Name = "GetUserByUserNameAndPassword")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<UserDTO>> GetUserByUserNameAndPassword(string UserName,string Password)
        {

            OnlineStoreBusiness.clsUser user = OnlineStoreBusiness.clsUser.Find(UserName,Password);

            if (user == null)
            {
                return NotFound($"User not found.");
            }

            DetailedUserDTO DTO = user.DetailedUserDTO;

            return Ok(DTO);
        }
        [HttpGet("Users-Count", Name = "GetUsersCount")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<int>> GetUsersCount()
        {
           
            int TotalUsers = OnlineStoreBusiness.clsUser.GetUsersCount();
            return Ok(TotalUsers);
        }
        [HttpGet("Check-User-Exist", Name = "IsUserExist")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> IsUserExist(string UserName)
        {

            bool UserExist = OnlineStoreBusiness.clsUser.IsUserExist(UserName);
            return Ok(UserExist);
        }
        [HttpPost("AddUser", Name = "AddUser")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<DetailedUserDTO> AddUser(DetailedUserDTO userDTO)
        {

            if (userDTO == null ||string.IsNullOrEmpty(userDTO.Address)|| string.IsNullOrEmpty(userDTO.UserName)|| string.IsNullOrEmpty(userDTO.Name)
                || string.IsNullOrEmpty(userDTO.Email)|| string.IsNullOrEmpty(userDTO.Phone)|| string.IsNullOrEmpty(userDTO.Password)||userDTO.Permissions<0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsUser user = new OnlineStoreBusiness.clsUser(new DetailedUserDTO(userDTO.UserID,userDTO.Name,userDTO.Email,userDTO.Phone,userDTO.Address,userDTO.UserName,clsGlobal.ComputeHash(userDTO.Password),userDTO.ImageURL,userDTO.Permissions));
            try
            {
                user.Save();
                return CreatedAtRoute("GetUserByID", new { UserID = user.UserID }, userDTO);

            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-User {UserID}", Name = "DeleteUser")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteUser(int UserID)
        {
            if (UserID < 0)
            {
                return BadRequest($"Not Accepted ID {UserID}");
            }

            if (OnlineStoreBusiness.clsUser.Delete(UserID))
                return Ok($"User has been deleted.");
            else
                return NotFound($"User not found. no rows deleted!");
        }
        [HttpPut("Update-User", Name = "UpdateUser")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<UserDTO> UpdateUser(DetailedUserDTO UpdatedUser)
        {
            if (UpdatedUser == null || string.IsNullOrEmpty(UpdatedUser.Address) || string.IsNullOrEmpty(UpdatedUser.UserName) || string.IsNullOrEmpty(UpdatedUser.Name)
          || string.IsNullOrEmpty(UpdatedUser.Email) || string.IsNullOrEmpty(UpdatedUser.Phone))
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsUser User = OnlineStoreBusiness.clsUser.Find(UpdatedUser.UserID);


            if (User == null)
            {
                return NotFound($"User not found.");
            }

            if(UpdatedUser.Permissions!=-1)
                 User.Permissions = UpdatedUser.Permissions;
            User.Address = UpdatedUser.Address;
            User.Name = UpdatedUser.Name;
            User.Email = UpdatedUser.Email;
            if(UpdatedUser.Password!="")
                 User.Password = clsGlobal.ComputeHash(UpdatedUser.Password);
            User.Phone = UpdatedUser.Phone;
            if(UpdatedUser.ImageURL!=""||UpdatedUser.ImageURL!=null)
                 User.ImageURL = UpdatedUser.ImageURL;
            User.UserName = UpdatedUser.UserName;
            try
            {
                User.Save();

                return Ok(User.DetailedUserDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
    }
}

