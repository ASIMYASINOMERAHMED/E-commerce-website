using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static OnlineStoreDataAccess.clsProductImagesData;
using System.Net;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductImagesController : ControllerBase
    {
        [HttpGet("ProductID {ProductID}", Name = "GetProductImagesByProductID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductImagesDTO>> GetProductImagesByID(int ProductID)
        {
            if (ProductID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            List<ProductImagesDTO> ProductImages = OnlineStoreBusiness.clsProductImages.GetProductImages(ProductID);

            if (ProductImages.Count==0)
            {
                return NotFound($"Product Images not found.");
            }
            else
                return Ok(ProductImages);
        }
     
        [HttpPost("AddProductImage", Name = "AddProductImage")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductImagesDTO> AddProductImage(ProductImagesDTO productImagesDTO)
        {

            if (productImagesDTO == null || string.IsNullOrEmpty(productImagesDTO.ImageUrl) || productImagesDTO.ProductID<1||productImagesDTO.ImageOrder<0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductImages productImages = new OnlineStoreBusiness.clsProductImages(new ProductImagesDTO(productImagesDTO.ID, productImagesDTO.ImageUrl, productImagesDTO.ProductID, productImagesDTO.ImageOrder));

            try
            {
                productImages.Save();
                return CreatedAtRoute("GetProductImagesByProductID", new { ProductID = productImages.ProductID }, productImagesDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Product-Images {ID}", Name = "DeleteProductImages")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteProductImages(int ID)
        {
            if (ID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsProductImages.Delete(ID))
                return Ok($"Product Images has been deleted.");
            else
                return NotFound($"Product Images not found. no rows deleted!");
        }
        [HttpPut("UpdateProductImage", Name = "UpdateProductImage")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductImagesDTO> UpdateProductImage(ProductImagesDTO UpdatedProductImages)
        {

            if (UpdatedProductImages == null || string.IsNullOrEmpty(UpdatedProductImages.ImageUrl) || UpdatedProductImages.ProductID < 1 || UpdatedProductImages.ImageOrder < 0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductImages productImages = OnlineStoreBusiness.clsProductImages.Find(UpdatedProductImages.ID);


            if (productImages == null)
            {
                return NotFound($"Product Images not found.");
            }


            productImages.ProductID = UpdatedProductImages.ProductID;
            productImages.ImageOrder = UpdatedProductImages.ImageOrder;
            productImages.ImageUrl = UpdatedProductImages.ImageUrl;

            try
            {
                productImages.Save();

                return Ok(productImages.ProductImagesDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpPost("Upload")]
        public async Task<IActionResult> UploadImage(IFormFile imageFile)
        {
            // Check if no file is uploaded
            if (imageFile == null || imageFile.Length == 0)
                return BadRequest("No file uploaded.");

            // Directory where files will be uploaded
            var uploadDirectory = @"C:\MyUploads";

            // Generate a unique filename
            var fileName = Guid.NewGuid().ToString() + Path.GetExtension(imageFile.FileName);
            var filePath = Path.Combine(uploadDirectory, fileName);

            // Ensure the uploads directory exists, create if it doesn't
            if (!Directory.Exists(uploadDirectory))
            {
                Directory.CreateDirectory(uploadDirectory);
            }

            // Save the file to the server
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await imageFile.CopyToAsync(stream);
            }

            // Return the file path as a response
            return Ok(new { fileName });
        }
        [HttpGet("GetImage/{fileName}")]
        public IActionResult GetImage(string fileName)
        {
            // Directory where files are stored
            var uploadDirectory = @"C:\MyUploads";
            var filePath = Path.Combine(uploadDirectory, fileName);

            // Check if the file exists
            if (!System.IO.File.Exists(filePath))
                return NotFound("Image not found.");

            // Open the image file for reading
            var image = System.IO.File.OpenRead(filePath);
            var mimeType = GetMimeType(filePath);

            // Return the file with the correct MIME type
            return File(image, mimeType);
        }
		[HttpDelete("DeleteMedia/{fileName}")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		[ProducesResponseType(StatusCodes.Status500InternalServerError)]
		public IActionResult DeleteMedia(string fileName)
		{
			// Directory where files are stored
			var uploadDirectory = @"C:\MyUploads";
			var filePath = Path.Combine(uploadDirectory, fileName);

			// Check if the file exists
			if (!System.IO.File.Exists(filePath))
				return NotFound("File not found.");

			try
			{
				// Delete the file
				System.IO.File.Delete(filePath);
				return Ok(new { Message = "File deleted successfully." });
			}
			catch (Exception ex)
			{
				// Handle any errors that may occur
				return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = ex.Message });
			}
		}



		// Helper method to get the MIME type based on file extension
		/*
         This code defines a  method called GetMimeType that takes a file path as a parameter 
         and returns the corresponding MIME type as a string. 
         MIME types are used to indicate the nature and format of a file, 
         especially in web contexts where you need to specify the type of content you're sending, 
         like images, text, etc.

        MIME type stands for Multipurpose Internet Mail Extensions type. 
        It's a standard way to indicate the nature and format of a file or content. 
        MIME types are used to tell browsers, email clients, and 
        other software about the type of data they're handling, so they can process it correctly.
         */
		private string GetMimeType(string filePath)
        {
            var extension = Path.GetExtension(filePath).ToLowerInvariant();
            return extension switch
            {
                ".jpg" or ".jpeg" => "image/jpeg",
                ".png" => "image/png",
                ".gif" => "image/gif",
                _ => "application/octet-stream",
            };
        }


    }
}
