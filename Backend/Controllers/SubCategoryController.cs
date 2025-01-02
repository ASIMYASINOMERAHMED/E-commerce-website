using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsReportData;
using static OnlineStoreDataAccess.clsSubCategoryData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/SubCategory")]
    [ApiController]
    public class SubCategoryController : ControllerBase
    {
        [HttpGet("{CategoryID}", Name = "GetAllSubCategories")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<SubCategoryDTO>> GetAllSubCategories(int CategoryID)
        {
            List<SubCategoryDTO> SubCategoriesList = OnlineStoreBusiness.clsSubCategory.GetAllSubCategories(CategoryID);
            if (SubCategoriesList.Count == 0)
            {
                return NotFound("No SubCategories Found!");
            }
            return Ok(SubCategoriesList);
        }
        [HttpGet("SubCategoryID {SubCategoryID}", Name = "GetProductSubCategoryByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<SubCategoryDTO>> GetProductSubCategoryByID(int SubCategoryID)
        {
            if (SubCategoryID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsSubCategory SubCategory = OnlineStoreBusiness.clsSubCategory.Find(SubCategoryID);

            if (SubCategory == null)
            {
                return NotFound($"SubCategory not found.");
            }

            SubCategoryDTO DTO = SubCategory.SubCategoryDTO;

            return Ok(DTO);
        }
        [HttpGet("SubCategoryName {SubCategoryName}", Name = "GetProductSubCategoryByName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<SubCategoryDTO>> GetProductSubCategoryByName(string SubCategoryName)
        {
          
            OnlineStoreBusiness.clsSubCategory SubCategory = OnlineStoreBusiness.clsSubCategory.Find(SubCategoryName);

            if (SubCategory == null)
            {
                return NotFound($"SubCategory not found.");
            }

            SubCategoryDTO DTO = SubCategory.SubCategoryDTO;

            return Ok(DTO);
        }
        [HttpPost("AddProductSubCategory", Name = "AddProductSubCategory")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<SubCategoryDTO> AddProductSubCategory(SubCategoryDTO SubCategoryDTO)
        {

            if (SubCategoryDTO == null || string.IsNullOrEmpty(SubCategoryDTO.SubCategoryName) || SubCategoryDTO.CategoryID<1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsSubCategory subCategory = new OnlineStoreBusiness.clsSubCategory(new SubCategoryDTO(SubCategoryDTO.SubCategoryID, SubCategoryDTO.SubCategoryName, SubCategoryDTO.CategoryID));

            try
            {
                subCategory.Save();
                return CreatedAtRoute("GetProductSubCategoryByID", new { SubCategoryID = subCategory.SubCategoryID }, SubCategoryDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-SubCategory {SubCategoryID}", Name = "DeleteProductSubCategory")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteProductSubCategory(int SubCategoryID)
        {
            if (SubCategoryID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsSubCategory.Delete(SubCategoryID))
                return Ok($"SubCategory has been deleted.");
            else
                return NotFound($"SubCategory not found. no rows deleted!");
        }
        [HttpGet("Check-SubCategory-Exist", Name = "SubCategoryExist")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<bool>> SubCategoryExist(string SubCategoryName)
        {

            bool SubCategoryExist = OnlineStoreBusiness.clsSubCategory.IsSubCategoryExist(SubCategoryName);
            return Ok(SubCategoryExist);
        }
        [HttpPut("UpdateProductSubCategory", Name = "UpdateProductSubCategory")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<SubCategoryDTO> UpdateProductSubCategory(SubCategoryDTO UpdatedSubCategory)
        {

            if (UpdatedSubCategory == null || string.IsNullOrEmpty(UpdatedSubCategory.SubCategoryName) || UpdatedSubCategory.CategoryID < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsSubCategory subcategory = OnlineStoreBusiness.clsSubCategory.Find(UpdatedSubCategory.SubCategoryID);


            if (subcategory == null)
            {
                return NotFound($"SubCategory not found.");
            }


            subcategory.CategoryID = UpdatedSubCategory.CategoryID;
            subcategory.SubCategoryName = UpdatedSubCategory.SubCategoryName;

            try
            {
                subcategory.Save();

                return Ok(subcategory.SubCategoryDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
    }
}
