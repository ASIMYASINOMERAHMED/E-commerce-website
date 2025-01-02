using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsProductCategoryData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductCategoryController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllCategories")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCategoryDTO>> GetAllCategories()
        {
            List<ProductCategoryDTO> ProductCategoriesList = OnlineStoreBusiness.clsProductCategory.GetAllCategories();
            if (ProductCategoriesList.Count == 0)
            {
                return NotFound("No Categories Found!");
            }
            return Ok(ProductCategoriesList);
        }
        [HttpGet("CategoryID {CategoryID}", Name = "GetProductCategoryByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductCategoryDTO>> GetProductCategoryByID(int CategoryID)
        {
            if (CategoryID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsProductCategory Category = OnlineStoreBusiness.clsProductCategory.Find(CategoryID);

            if (Category == null)
            {
                return NotFound($"Category not found.");
            }

            ProductCategoryDTO DTO = Category.ProductCategoryDTO;

            return Ok(DTO);
        }
        [HttpGet("CategoryName {CategoryName}", Name = "GetProductCategoryByName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductCategoryDTO>> GetProductCategoryByName(string CategoryName)
        {
           
            OnlineStoreBusiness.clsProductCategory Category = OnlineStoreBusiness.clsProductCategory.Find(CategoryName);

            if (Category == null)
            {
                return NotFound($"Category not found.");
            }

            ProductCategoryDTO DTO = Category.ProductCategoryDTO;

            return Ok(DTO);
        }
        [HttpPost("AddProductCategory", Name = "AddProductCategory")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductCategoryDTO> AddProductCategory(ProductCategoryDTO Category)
        {

            if  (Category == null || string.IsNullOrEmpty(Category.CategoryName) || string.IsNullOrEmpty(Category.CategoryImage))
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductCategory category = new OnlineStoreBusiness.clsProductCategory(new ProductCategoryDTO( Category.CategoryID, Category.CategoryName, Category.CategoryImage,Category.InsertByUserID));

            try
            {
                category.Save();
                return CreatedAtRoute("GetProductCategoryByID", new { CategoryID = category.CategoryID }, Category);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Category {CategoryID}", Name = "DeleteProductCategory")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteProductCategory(int CategoryID)
        {
            if (CategoryID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsProductCategory.Delete(CategoryID))
                return Ok($"Category has been deleted.");
            else
                return NotFound($"Category not found. no rows deleted!");
        }
        [HttpPut("UpdateProductCategory", Name = "UpdateProductCategory")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductCategoryDTO> UpdateProductCategory(ProductCategoryDTO UpdatedCategory)
        {

            if (UpdatedCategory == null || string.IsNullOrEmpty(UpdatedCategory.CategoryName) || string.IsNullOrEmpty(UpdatedCategory.CategoryImage)||UpdatedCategory.InsertByUserID<=0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductCategory category = OnlineStoreBusiness.clsProductCategory.Find(UpdatedCategory.CategoryID);


            if (category == null)
            {
                return NotFound($"Category not found.");
            }


            category.CategoryID = UpdatedCategory.CategoryID;
            category.CategoryName = UpdatedCategory.CategoryName;
            category.CategoryImage = UpdatedCategory.CategoryImage;
            category.InsertByUserID = UpdatedCategory.InsertByUserID;
  
            try
            {
                category.Save();

                return Ok(category.ProductCategoryDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
        [HttpGet("Check-Category-Exist", Name = "IsCategoryExist")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> IsCategoryExist(string CategoryName)
        {

            bool CategoryExist = OnlineStoreBusiness.clsProductCategory.IsCategoryExist(CategoryName);
            return Ok(CategoryExist);
        }
    }
}
