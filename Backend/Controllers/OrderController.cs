using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Web.Http.Cors;
using System.Net;
using static OnlineStoreDataAccess.clsOrderData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<OrderDetailsDTO>> GetAllOrders()
        {
            List<OrderDetailsDTO> OrdersList = OnlineStoreBusiness.clsOrder.GetAllOrders();
            if (OrdersList.Count == 0)
            {
                return NotFound("No Orders Found!");
            }
            return Ok(OrdersList);
        }
        [HttpGet("Compelete-Orders", Name = "GetAllCompeleteOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<OrderDetailsDTO>> GetAllCompeleteOrders()
        {
            List<OrderDetailsDTO> OrdersList = OnlineStoreBusiness.clsOrder.GetAllCompeleteOrders();
            if (OrdersList.Count == 0)
            {
                return NotFound("No Orders Found!");
            }
            return Ok(OrdersList);
        }
        [HttpGet("Orders-For-CustomerID {CustomerID}", Name = "GetAllOrdersForCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<OrderDTO>> GetAllOrdersForCustomerID(int CustomerID)
        {
            List<OrderDTO> OrdersList = OnlineStoreBusiness.clsOrder.GetAllOrdersForCustomerID(CustomerID);
            if (OrdersList.Count == 0)
            {
                return NotFound("No Orders Found!");
            }
            return Ok(OrdersList);
        }
        [HttpGet("Pending-Orders", Name = "GetAllPendingOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<OrderDetailsDTO>> GetAllPendingOrders()
        {
            List<OrderDetailsDTO> OrdersList = OnlineStoreBusiness.clsOrder.GetAllPendingOrders();
            if (OrdersList.Count == 0)
            {
                return NotFound("No Orders Found!");
            }
            return Ok(OrdersList);
        }
        [HttpGet("Processing-Orders", Name = "GetAllProcessingOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<OrderDetailsDTO>> GetAllProcessingOrders()
        {
            List<OrderDetailsDTO> OrdersList = OnlineStoreBusiness.clsOrder.GetAllProcessingOrders();
            if (OrdersList.Count == 0)
            {
                return NotFound("No Orders Found!");
            }
            return Ok(OrdersList);
        }
        [HttpGet("OrderID {OrderID}", Name = "GetOrderByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<OrderDetailsDTO>> GetOrderByID(int OrderID)
        {
            if (OrderID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsOrder Order = OnlineStoreBusiness.clsOrder.Find(OrderID);

            if (Order == null)
            {
                return NotFound($"Order not found.");
            }

            OrderDetailsDTO DTO = Order.orderDetailsDTO;

            return Ok(DTO);
        }
        [HttpPost("NewOrder", Name = "AddOrder")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<OrderDTO> AddOrder(OrderDTO Order)
        {

            if (Order == null||Order.CustomerID <1||Order.Status<1||Order.TotalAmount<1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsOrder OrderObject = new OnlineStoreBusiness.clsOrder(new OrderDTO(Order.OrderID, Order.CustomerID, Order.OrderDate,Order.TotalAmount,Order.Status));
            try
            {
                OrderObject.Save();
                Order.OrderID = OrderObject.OrderID;
                return CreatedAtRoute("GetOrderByID", new { OrderID = Order.OrderID }, Order);

            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Order {OrderID}", Name = "DeleteOrder")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteOrder(int OrderID)
        {
            if (OrderID < 0)
            {
                return BadRequest($"Not Accepted ID {OrderID}");
            }

            if (OnlineStoreBusiness.clsOrder.Delete(OrderID))
                return Ok($"Order has been deleted.");
            else
                return NotFound($"Order not found. no rows deleted!");
        }
        [HttpPut("UpdateOrder", Name = "UpdateOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<OrderDTO> UpdateOrder(OrderDTO UpdatedOrder)
        {
            if (UpdatedOrder == null || UpdatedOrder.OrderID < 1 || UpdatedOrder.CustomerID < 1 || UpdatedOrder.Status < 1 || UpdatedOrder.TotalAmount < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsOrder Order = OnlineStoreBusiness.clsOrder.Find(UpdatedOrder.OrderID);


            if (Order == null)
            {
                return NotFound($"Order not found.");
            }


            Order.OrderID = UpdatedOrder.OrderID;
            Order.CustomerID = UpdatedOrder.CustomerID;
            Order.OrderDate = UpdatedOrder.OrderDate;
            Order.TotalAmount = UpdatedOrder.TotalAmount;
            Order.OrderStatus = (OnlineStoreBusiness.clsOrder.enOrderStatus)UpdatedOrder.Status;
            try
            {
                Order.Save();

                return Ok(Order.orderDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
        [HttpGet("Total-Revenue", Name = "GetTotalRevenue")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<decimal>> GetTotalRevenue()
        {
            decimal TotalRevenue = OnlineStoreBusiness.clsOrder.GetTotalRevenue();
            return Ok(TotalRevenue);
        }
        [HttpGet("OrderDelivered {OrderID}", Name = "OrderDelivered")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> OrderDelivered(int OrderID)
        {
            if (OrderID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool OrderDelivered = OnlineStoreBusiness.clsOrder.OrderDelivered(OrderID);
            return Ok(OrderDelivered);
        }
        [HttpGet("DeleteCompeleteOrder {OrderID}", Name = "DeleteCompeleteOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> DeleteCompeleteOrder(int OrderID)
        {
            if (OrderID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool DeleteCompeleteOrder = OnlineStoreBusiness.clsOrder.DeleteCompeleteOrder(OrderID);
            return Ok(DeleteCompeleteOrder);
        }
        [HttpGet("CompeleteOrder {OrderID}", Name = "CompeleteOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> CompeleteOrder(int OrderID)
        {
            if (OrderID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool CompeleteOrder = OnlineStoreBusiness.clsOrder.CompeleteOrder(OrderID);
            return Ok(CompeleteOrder);
        }
        [HttpGet("ProcessOrder{OrderID}", Name = "ProcessOrder")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> ProcessOrder(int OrderID)
        {
            if (OrderID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool ProcessOrder = OnlineStoreBusiness.clsOrder.ProcessOrder(OrderID);
            return Ok(ProcessOrder);
        }
        [HttpGet("CompleteAllOrders", Name = "CompleteAllOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> CompleteAllOrders()
        {
         
            bool CompleteAllOrders = OnlineStoreBusiness.clsOrder.CompleteAllOrders();
            return Ok(CompleteAllOrders);
        }
        [HttpGet("ProcessAllOrders", Name = "ProcessAllOrders")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> ProcessAllOrders()
        {
      
            bool ProcessAllOrders = OnlineStoreBusiness.clsOrder.ProcessAllOrders();
            return Ok(ProcessAllOrders);
        }
    }
}
