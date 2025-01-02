using Microsoft.AspNetCore.Mvc;
using Online_Store_Project;
using System.Net;
using static OnlineStoreDataAccess.clsCustomerData;

namespace OnlineStoreRestApi.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class CustomerController : Controller
	{
	
		[HttpGet("Customer {CustomerID}", Name = "GetCustomerByID")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public ActionResult<IEnumerable<CustomerDTO>> GetCustomerByID(int CustomerID)
		{
			if (CustomerID < 1)
			{
				return BadRequest($"Not Accepted ID");
			}
			OnlineStoreBusiness.clsCustomer customer = OnlineStoreBusiness.clsCustomer.Find(CustomerID);

			if (customer == null)
			{
				return NotFound($"customer not found.");
			}

			CustomerDTO DTO = customer.CustomerDTO;
			return Ok(DTO);
		}
		[HttpGet("Email {Email}", Name = "GetCustomerByEmail")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<CustomerDTO>> GetCustomerByEmail(string Email)
		{

			OnlineStoreBusiness.clsCustomer customer = OnlineStoreBusiness.clsCustomer.Find(Email);

			if (customer == null)
			{
				return NotFound($"customer not found.");
			}

			CustomerDTO DTO = customer.CustomerDTO;

			return Ok(DTO);
		}
		[HttpGet("Email {Email}/ Password {Password}", Name = "GetCustomerByEmailAndPassword")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<CustomerDTO>> GetCustomerByEmailAndPassword(string Email, string Password)
		{

			OnlineStoreBusiness.clsCustomer customer = OnlineStoreBusiness.clsCustomer.Find(Email, Password);

			if (customer == null)
			{
				return NotFound($"Customer not found.");
			}

			CustomerDTO DTO = customer.CustomerDTO;

			return Ok(DTO);
		}
		[HttpGet("Customers-Count", Name = "GetCustomersCount")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<int>> GetCustomersCount()
		{

			int TotalCustomers = OnlineStoreBusiness.clsCustomer.GetCustomersCount();
			return Ok(TotalCustomers);
		}
		[HttpGet("Check-Customer-Exist", Name = "IsCustomerExist")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<bool>> IsCustomerExist(string Email)
		{

			bool CustomerExist = OnlineStoreBusiness.clsCustomer.IsCustomerExist(Email);
			return Ok(CustomerExist);
		}
		[HttpPost("AddCustomer", Name = "AddCustomer")]
		[ProducesResponseType(StatusCodes.Status201Created)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status500InternalServerError)]
		public ActionResult<CustomerDTO> AddCustomer(CustomerDTO customerDTO)
		{

			if (customerDTO == null || string.IsNullOrEmpty(customerDTO.Address) || string.IsNullOrEmpty(customerDTO.Name)
				|| string.IsNullOrEmpty(customerDTO.Email) || string.IsNullOrEmpty(customerDTO.Phone) || string.IsNullOrEmpty(customerDTO.Password))
			{
				return BadRequest("Invalid data.");
			}

			OnlineStoreBusiness.clsCustomer customer = new OnlineStoreBusiness.clsCustomer(new CustomerDTO(customerDTO.CustomerID, customerDTO.Name, customerDTO.Email, customerDTO.Phone, customerDTO.Address,clsGlobal.ComputeHash(customerDTO.Password)));
			try
			{
				customer.Save();
				return CreatedAtRoute("GetCustomerByID", new { CustomerID = customer.CustomerID }, customerDTO);

			}
			catch (Exception e)
			{
				return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
			}

		}
		[HttpDelete("Delete-Customer {CustomerID}", Name = "DeleteCustomer")]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult DeleteCustomer(int CustomerID)
		{
			if (CustomerID < 0)
			{
				return BadRequest($"Not Accepted ID {CustomerID}");
			}

			if (OnlineStoreBusiness.clsCustomer.Delete(CustomerID))
				return Ok($"Customer has been deleted.");
			else
				return NotFound($"Customer not found. no rows deleted!");
		}
		[HttpPut("Update-Customer", Name = "UpdateCustomer")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		[ProducesResponseType(StatusCodes.Status500InternalServerError)]
		public ActionResult<CustomerDTO> UpdateCustomer(CustomerDTO UpdatedCustomer)
		{
			if (UpdatedCustomer == null || string.IsNullOrEmpty(UpdatedCustomer.Address) || string.IsNullOrEmpty(UpdatedCustomer.Name)
		  || string.IsNullOrEmpty(UpdatedCustomer.Email)|| string.IsNullOrEmpty(UpdatedCustomer.Phone))
			{
				return BadRequest("Invalid data.");
			}

			OnlineStoreBusiness.clsCustomer customer = OnlineStoreBusiness.clsCustomer.Find(UpdatedCustomer.CustomerID);


			if (customer == null)
			{
				return NotFound($"Customer not found.");
			}


			customer.CustomerID = UpdatedCustomer.CustomerID;
			customer.Address = UpdatedCustomer.Address;
			customer.Name = UpdatedCustomer.Name;
			customer.Email = UpdatedCustomer.Email;
			if (UpdatedCustomer.Password != "")
				customer.Password =clsGlobal.ComputeHash(UpdatedCustomer.Password);
			customer.Phone = UpdatedCustomer.Phone;

			try
			{
				customer.Save();

				return Ok(customer.CustomerDTO);
			}
			catch (Exception e)
			{
				return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
			}
		}
	}
}

