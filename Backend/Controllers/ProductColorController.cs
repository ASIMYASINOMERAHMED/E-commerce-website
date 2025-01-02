using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static OnlineStoreDataAccess.clsProductColorData;
using System.Net;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductColorController : ControllerBase
    {
        [HttpGet("{ProductID}", Name = "GetProductColors")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductColorDTO>> GetProductColors(int ProductID)
        {
            List<ProductColorDTO>  ProductColorList = OnlineStoreBusiness.clsProductColor.GetProductColors(ProductID);
            if (ProductColorList.Count==0)
            {
                return NotFound("No Product Color Found!");
            }
            return Ok(ProductColorList);
        }
        [HttpGet("Product {ProductID} Colors", Name = "GetProductColorsByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductColorDTO>> GetProductColorsByID(int ProductID)
        {
            if (ProductID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsProductColor Colors = OnlineStoreBusiness.clsProductColor.Find(ProductID);

            if (Colors == null)
            {
                return NotFound($"Product Colors not found.");
            }

            ProductColorDTO DTO = Colors.ProductColorDTO;

            return Ok(DTO);
        }
        [HttpPost("AddProductColors", Name = "AddProductColors")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductColorDTO> AddProductColors(ProductColorDTO Colors)
        {

            if (Colors == null || string.IsNullOrEmpty(Colors.Colors) || Colors.ProductID <1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductColor productColors = new OnlineStoreBusiness.clsProductColor(new ProductColorDTO(Colors.ColorsID, Colors.Colors, Colors.ProductID));

            try
            {
                productColors.Save();
                return CreatedAtRoute("GetProductColorsByID", new { ProductID = productColors.ProductID }, Colors);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
     
        [HttpPut("UpdateProductColors", Name = "UpdateProductColors")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductColorDTO> UpdateProductColors(ProductColorDTO UpdatedColors)
        {

            if (UpdatedColors == null || string.IsNullOrEmpty(UpdatedColors.Colors) || UpdatedColors.ProductID<1||UpdatedColors.ColorsID<1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductColor Colors = OnlineStoreBusiness.clsProductColor.Find(UpdatedColors.ProductID);


            if (Colors == null)
            {
                return NotFound($"Colors not found.");
            }


            Colors.ProductID = UpdatedColors.ProductID;
            Colors.Colors = UpdatedColors.Colors;

            try
            {
                Colors.Save();

                return Ok(Colors.ProductColorDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
		[HttpDelete("Delete-Product-Color {ID}", Name = "DeleteProductColor")]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult DeleteProductColor(int ID)
		{
			if (ID < 0)
			{
				return BadRequest($"Not Accepted ID");
			}

			if (OnlineStoreBusiness.clsProductColor.Delete(ID))
				return Ok($"Product Color has been deleted.");
			else
				return NotFound($"Product Color not found. no rows deleted!");
		}
	}
}
