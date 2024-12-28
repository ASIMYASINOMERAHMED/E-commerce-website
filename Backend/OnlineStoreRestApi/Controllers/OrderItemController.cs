using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsOrderItemsData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderItemController : ControllerBase
    {
        [HttpGet("OrderID {OrderID}", Name = "GetAllOrderItems")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<OrderItemsDTO>> GetAllOrderItems(int OrderID)
        {
            if(OrderID<1)
            {
                return BadRequest("Invalid OrderID.");
            }
            List<OrderItemsDTO> OrderItemsList = OnlineStoreBusiness.clsOrderItem.GetAllOrderItems(OrderID);
            if (OrderItemsList.Count == 0)
            {
                return NotFound("No Order Items Found!");
            }
            return Ok(OrderItemsList);
        }
        [HttpGet("{OrderID}/{ProductID}", Name = "GetOrderItemsByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<OrderItemsDetailsDTO>> GetOrderItemsByID(int OrderID,int ProductID)
        {
            if (OrderID < 1||ProductID<1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsOrderItem orderItem = OnlineStoreBusiness.clsOrderItem.Find(OrderID,ProductID);

            if (orderItem == null)
            {
                return NotFound($"Order Item not found.");
            }

            OrderItemsDetailsDTO DTO = orderItem.OrderItemsDTO;

            return Ok(DTO);
        }
        [HttpPost("AddOrderItem", Name = "AddOrderItem")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<OrderItemsDetailsDTO> AddOrderItem(OrderItemsDetailsDTO orderItemsDTO)
        {
            
            if (orderItemsDTO == null || string.IsNullOrEmpty(orderItemsDTO.Color)||string.IsNullOrEmpty(orderItemsDTO.Size) 
                || orderItemsDTO.Quantity < 1 || orderItemsDTO.ProductID<1||orderItemsDTO.Price <=0||orderItemsDTO.TotalItemsPrice<=0)
            {
                return BadRequest("Invalid Order Item data.");
            }

            OnlineStoreBusiness.clsOrderItem orderItem = new OnlineStoreBusiness.clsOrderItem(new OrderItemsDetailsDTO(orderItemsDTO.OrderID, orderItemsDTO.ProductID, orderItemsDTO.Quantity, orderItemsDTO.Size,orderItemsDTO.Color,orderItemsDTO.Price,orderItemsDTO.TotalItemsPrice));
            try
            {
                orderItem.Save();
                return CreatedAtRoute("GetAllOrderItems", new { OrderID = orderItem.OrderID }, orderItemsDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("ProductID {ProductID}", Name = "DeleteOrderItem")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteOrderItem(int ProductID)
        {
            if (ProductID < 0)
            {
                return BadRequest($"Not Accepted ProductID {ProductID}");
            }
       
            if (OnlineStoreBusiness.clsOrderItem.Delete(ProductID))
                return Ok($"Order Item with ProductID {ProductID} has been deleted.");
            else
                return NotFound($"Order Item with ProductID {ProductID} not found. no rows deleted!");
        }
        [HttpPut("UpdateOrderItem", Name = "UpdateOrderItem")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<OrderItemsDetailsDTO> UpdateOrderItem(OrderItemsDetailsDTO UpdatedOrderItem)
        {
            if (UpdatedOrderItem.OrderID < 1 || UpdatedOrderItem.ProductID < 1 || UpdatedOrderItem == null 
                || string.IsNullOrEmpty(UpdatedOrderItem.Color) || string.IsNullOrEmpty(UpdatedOrderItem.Size) || UpdatedOrderItem.Quantity<1
                || UpdatedOrderItem.Price <1||UpdatedOrderItem.TotalItemsPrice<1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsOrderItem orderItem = OnlineStoreBusiness.clsOrderItem.Find(UpdatedOrderItem.OrderID,UpdatedOrderItem.ProductID);


            if (orderItem == null)
            {
                return NotFound($"Order Item not found.");
            }


            orderItem.OrderID = UpdatedOrderItem.OrderID;
            orderItem.ProductID = UpdatedOrderItem.ProductID;
            orderItem.Color = UpdatedOrderItem.Color;
            orderItem.Size = UpdatedOrderItem.Size;
            orderItem.Price = UpdatedOrderItem.Price;
            orderItem.TotalItemsPrice = UpdatedOrderItem.TotalItemsPrice;
            orderItem.Quantity = UpdatedOrderItem.Quantity;
            try
            {
                orderItem.Save();

                return Ok(orderItem.OrderItemsDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
    }
}
