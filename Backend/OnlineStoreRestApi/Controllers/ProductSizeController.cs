using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsProductSizeData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductSizeController : ControllerBase
    {
        [HttpGet("{ProductID}", Name = "GetProductSizes")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductSizeDTO>> GetProductSizes(int ProductID)
        {
            List<ProductSizeDTO>  ProductSizeList = OnlineStoreBusiness.clsProductSize.GetProductSizes(ProductID);
            if (ProductSizeList.Count==0)
            {
                return NotFound("No Product Size Found!");
            }
            return Ok(ProductSizeList);
        }
      
        [HttpGet("Product {ProductID} Size", Name = "GetProductSizeByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductSizeDTO>> GetProductSizeByID(int ProductID)
        {
            if (ProductID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsProductSize ProductSize = OnlineStoreBusiness.clsProductSize.Find(ProductID);

            if (ProductSize == null)
            {
                return NotFound($"Product Size not found.");
            }

            ProductSizeDTO DTO = ProductSize.ProductSizeDTO;

            return Ok(DTO);
        }
        [HttpPost("AddProductSize", Name = "AddProductSize")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductSizeDTO> AddProductSize(ProductSizeDTO productSizeDTO)
        {

            if (productSizeDTO == null || string.IsNullOrEmpty(productSizeDTO.Size) || productSizeDTO.ProductID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductSize productSize = new OnlineStoreBusiness.clsProductSize(new ProductSizeDTO(productSizeDTO.SizeID, productSizeDTO.Size, productSizeDTO.ProductID));

            try
            {
                productSize.Save();
                return CreatedAtRoute("GetProductSizeByID", new { ProductID = productSize.ProductID }, productSizeDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }

        [HttpPut("UpdateProductSize", Name = "UpdateProductSize")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductSizeDTO> UpdateProductSize(ProductSizeDTO UpdatedproductSize)
        {

            if (UpdatedproductSize == null || string.IsNullOrEmpty(UpdatedproductSize.Size) || UpdatedproductSize.ProductID < 1 || UpdatedproductSize.SizeID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductSize productSize = OnlineStoreBusiness.clsProductSize.Find(UpdatedproductSize.ProductID);


            if (productSize == null)
            {
                return NotFound($"product Size not found.");
            }


            productSize.ProductID = UpdatedproductSize.ProductID;
            productSize.Size = UpdatedproductSize.Size;

            try
            {
                productSize.Save();

                return Ok(productSize.ProductSizeDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
		[HttpDelete("Delete-Product-Size {ID}", Name = "DeleteProductSize")]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult DeleteProductSize(int ID)
		{
			if (ID < 0)
			{
				return BadRequest($"Not Accepted ID");
			}

			if (OnlineStoreBusiness.clsProductSize.Delete(ID))
				return Ok($"Product Size has been deleted.");
			else
				return NotFound($"Product Size not found. no rows deleted!");
		}
	}
}
