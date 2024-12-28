using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsProductCatalogData;
using static OnlineStoreDataAccess.clsReportData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductCatalogController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllProducts")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetAllProducts()
        {
            List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetAllProducts();
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
		[HttpGet("TopSellingProducts", Name = "GetTopSellingProducts")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<ProductCatalogDTO>> GetTopSellingProducts()
		{
			List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetTopSellingProducts();
			if (ProductCatalogList.Count == 0)
			{
				return NotFound("No Products Found!");
			}
			return Ok(ProductCatalogList);
		}
		[HttpGet("NewArrivalProducts {PageNumber}", Name = "GetNewArrivalProducts")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetNewArrivalProducts(int PageNumber)
		{
			List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetNewArrivalProducts(PageNumber);
			if (ProductCatalogList.Count == 0)
			{
				return NotFound("No Products Found!");
			}
			return Ok(ProductCatalogList);
		}
		[HttpGet("Page {PageNumber}", Name = "GetProductsPerPage")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductsPerPage(int PageNumber)
        {
            List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsPerPage(PageNumber);
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
		[HttpGet("Page-View{PageNumber}", Name = "GetProductsPerPageView")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductsPerPageView(int PageNumber)
		{
			List<ProductCatalogDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsPerPageView(PageNumber);
			if (ProductCatalogList.Count == 0)
			{
				return NotFound("No Products Found!");
			}
			return Ok(ProductCatalogList);
		}
		[HttpGet("Page {PageNumber}/{SubCategoryID}", Name = "GetProductsPerPageForSubCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductsPerPageForSubCategoryID(int PageNumber,int SubCategoryID)
        {
            List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsPerPageForSubCategoryID(PageNumber,SubCategoryID);
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
        [HttpGet("SubCategory {SubCategoryID}", Name = "GetProductsForSubCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductsForSubCategoryID(int SubCategoryID)
        {
            List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsForSubCategoryID(SubCategoryID);
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
        [HttpGet("Page {PageNumber}/CategoryID {CategoryID}", Name = "GetProductsPerPageForCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductsPerPageForCategoryID(int PageNumber,int CategoryID)
        {
            List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsPerPageForCategoryID(PageNumber,CategoryID);
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
        [HttpGet("CategoryID {CategoryID}", Name = "GetProductsForCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDTO>> GetProductsForCategoryID(int CategoryID)
        {
            List<ProductCatalogDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.GetProductsForCategoryID(CategoryID);
            if (ProductCatalogList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductCatalogList);
        }
        [HttpGet("Most-Sold-Products From {From} To {To}", Name = "GetMostSoldProducts")]
        [ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ProductCatalogDTO>> GetMostSoldProducts(string From , string To)
        {
            if(string.IsNullOrEmpty(From)||string.IsNullOrEmpty(To)||DateTime.TryParse(From,out DateTime DateFrom)&& DateTime.TryParse(To, out DateTime DateTo))
            {
                return BadRequest("Invalid Input");
            }
            List<MostSoldProductsDTO> ProductList = OnlineStoreBusiness.clsProductCatalog.GetMostSoldProducts(From,To);
            if (ProductList.Count == 0)
            {
                return NotFound("No Products Found!");
            }
            return Ok(ProductList);
        }
        [HttpGet("Favourits-For-CustomerID {CustomerID}", Name = "GetFavouritesForCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<FavouritsDTO>> GetFavouritesForCustomerID(int CustomerID)
        {
            List<FavouritsDTO> ProductList = OnlineStoreBusiness.clsProductCatalog.GetAllFavouritesForCustomerID(CustomerID);
            if (ProductList.Count == 0)
            {
                return NotFound("No Favourits Found!");
            }
            return Ok(ProductList);
        }
        [HttpGet("ProductID {ProductID}", Name = "GetProductCatalogByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductCatalogByID(int ProductID)
        {
            if (ProductID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsProductCatalog productCatalog = OnlineStoreBusiness.clsProductCatalog.Find(ProductID);

            if (productCatalog == null)
            {
                return NotFound($"Product not found.");
            }

            ProductCatalogDataDTO DTO = productCatalog.ProductCatalogDataDTO;

            return Ok(DTO);
        }
        [HttpGet("{ProductName}", Name = "GetProductCatalogByName")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ProductCatalogDataDTO>> GetProductCatalogByName(string ProductName)
        {

			List<ProductCatalogDataDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.Find(ProductName);

			if (ProductCatalogList.Count == 0)
			{
				return NotFound("No Products Found!");
			}
            return Ok(ProductCatalogList);
		}
		[HttpGet("Find-By-Name {ProductName}", Name = "FindProductCatalogByName")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public ActionResult<IEnumerable<ProductCatalogDTO>> FindProductCatalogByName(string ProductName)
		{

			List<ProductCatalogDTO> ProductCatalogList = OnlineStoreBusiness.clsProductCatalog.FindByName(ProductName);

			if (ProductCatalogList.Count == 0)
			{
				return NotFound("No Products Found!");
			}
			return Ok(ProductCatalogList);
		}
		[HttpPost("AddProductCatalog", Name = "AddProductCatalog")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductCatalogDataDTO> AddProductCatalog(ProductCatalogDataDTO NewProduct)
        {

            if (NewProduct == null || string.IsNullOrEmpty(NewProduct.ProductName) || string.IsNullOrEmpty(NewProduct.ShortDescription)
                || NewProduct.CategoryID < 1 || string.IsNullOrEmpty(NewProduct.ImageURL) || string.IsNullOrEmpty(NewProduct.LongDescription) || NewProduct.Price < 1
                || NewProduct.QuantityInStock < 1 || NewProduct.SubCategoryID < 1||NewProduct.InsertByUserID<=0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductCatalog productCatalog = new OnlineStoreBusiness.clsProductCatalog(new ProductCatalogDataDTO(NewProduct.ProductID, NewProduct.ProductName, NewProduct.ShortDescription, NewProduct.LongDescription, NewProduct.Price,
                                                                                            NewProduct.QuantityInStock, NewProduct.CategoryID, NewProduct.SubCategoryID, NewProduct.ImageURL, NewProduct.VideoURL, NewProduct.Taxes, NewProduct.ADS, NewProduct.Discount,NewProduct.InsertByUserID));

            try
            {
                productCatalog.Save();
                NewProduct.ProductID = productCatalog.ProductID;
                return CreatedAtRoute("GetProductCatalogByID", new { ProductID = NewProduct.ProductID }, NewProduct);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Product {ProductID}", Name = "DeleteProductCatalog")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteProductCatalog(int ProductID)
        {
            if (ProductID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsProductCatalog.Delete(ProductID))
                return Ok($"Product has been deleted.");
            else
                return NotFound($"Product not found. no rows deleted!");
        }
        [HttpPut("UpdateProductCatalog", Name = "UpdateProductCatalog")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ProductCatalogDataDTO> UpdateProductCatalog(ProductCatalogDataDTO UpdatedProduct)
        {

            if (UpdatedProduct == null || string.IsNullOrEmpty(UpdatedProduct.ProductName) || string.IsNullOrEmpty(UpdatedProduct.ShortDescription)
                || UpdatedProduct.CategoryID < 1 || string.IsNullOrEmpty(UpdatedProduct.ImageURL) || string.IsNullOrEmpty(UpdatedProduct.LongDescription) || UpdatedProduct.Price < 1
                || UpdatedProduct.QuantityInStock < 1 || UpdatedProduct.SubCategoryID < 1||UpdatedProduct.InsertByUserID<=0)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsProductCatalog Product = OnlineStoreBusiness.clsProductCatalog.Find(UpdatedProduct.ProductID);


            if (Product == null)
            {
                return NotFound($"Product not found.");
            }


            Product.ProductID = UpdatedProduct.ProductID;
            Product.ProductName = UpdatedProduct.ProductName;
            Product.CategoryID = UpdatedProduct.CategoryID;
            Product.SubCategoryID = UpdatedProduct.SubCategoryID;
            Product.Discount = UpdatedProduct.Discount;
            if(UpdatedProduct.ImageURL!="")
            {
				Product.ImageURL = UpdatedProduct.ImageURL;
			}
            Product.LongDescription = UpdatedProduct.LongDescription;
            Product.ShortDescription = UpdatedProduct.ShortDescription;
            Product.Price = UpdatedProduct.Price;
            Product.QuantityInStock = UpdatedProduct.QuantityInStock;
            if (UpdatedProduct.VideoURL != "")
            {
                Product.VideoURL = UpdatedProduct.VideoURL;
            } 
            Product.Taxes = UpdatedProduct.Taxes;
            Product.ADS = UpdatedProduct.ADS;
            Product.InsertByUserID = UpdatedProduct.InsertByUserID;
            try
            {
                Product.Save();

                return Ok(Product.ProductCatalogDataDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }
        }
        [HttpGet("AddToFavourit", Name = "AddToFavourit")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> AddToFavourit(int ProductID,int CustomerID)
        {
            if(ProductID<1||CustomerID<1)
            {
                return BadRequest("Invalid Data");
            }
            bool AddToFavourit = OnlineStoreBusiness.clsProductCatalog.AddToFavourit(ProductID,CustomerID);
            return Ok(AddToFavourit);
        }
        [HttpGet("AddedToFavouriteByCustomerID", Name = "AddedToFavouriteByCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> AddedToFavouriteByCustomerID(int ProductID, int CustomerID)
        {
            if (ProductID < 1 || CustomerID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool AddedToFavourite = OnlineStoreBusiness.clsProductCatalog.AddedToFavouriteByCustomerID(ProductID, CustomerID);
            return Ok(AddedToFavourite);
        }
        [HttpGet("RemoveFormFavourit", Name = "RemoveFormFavourit")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<bool>> RemoveFormFavourit(int ProductID, int CustomerID)
        {
            if (ProductID < 1 || CustomerID < 1)
            {
                return BadRequest("Invalid Data");
            }
            bool RemoveFormFavourit = OnlineStoreBusiness.clsProductCatalog.RemoveFormFavourit(ProductID, CustomerID);
            return Ok(RemoveFormFavourit);
        }
        [HttpGet("Total-Pages", Name = "GetTotalPages")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public ActionResult<IEnumerable<int>> GetTotalPages()
        {
            int TotalPages = OnlineStoreBusiness.clsProductCatalog.GetTotalPages();
            return Ok(TotalPages);
        }
		[HttpGet("New-Arrival-Total-Pages", Name = "GetNewArrivalTotalPages")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		public ActionResult<IEnumerable<int>> GetNewArrivalTotalPages()
		{
			int TotalPages = OnlineStoreBusiness.clsProductCatalog.GetNewArrivalTotalPages();
			return Ok(TotalPages);
		}
		[HttpGet("Total-Pages-For-SubCategoryID", Name = "GetTotalPagesForSubCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<int>> GetTotalPagesForSubCategoryID(int SubCategoryID)
        {
            if(SubCategoryID<1)
            {
                return BadRequest("Invalid Data");
            }
            int TotalPages = OnlineStoreBusiness.clsProductCatalog.GetTotalPagesForSubCategoryID(SubCategoryID);
            return Ok(TotalPages);
        }
        [HttpGet("Total-Pages-For-CategoryID", Name = "GetTotalPagesForCategoryID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<int>> GetTotalPagesForCategoryID(int CategoryID)
        {
            if (CategoryID < 1)
            {
                return BadRequest("Invalid Data");
            }
            int TotalPages = OnlineStoreBusiness.clsProductCatalog.GetTotalPagesForCategoryID(CategoryID);
            return Ok(TotalPages);
        }
        [HttpPost("Video")]
        public async Task<IActionResult> UploadVideo(IFormFile videoFile)
        {
            if (videoFile == null || videoFile.Length == 0)
                return BadRequest("No file uploaded.");

            var uploadDirectory = @"C:\MyUploads\";
            var fileName = Guid.NewGuid().ToString() + Path.GetExtension(videoFile.FileName);
            var filePath = Path.Combine(uploadDirectory, fileName);

            if (!Directory.Exists(uploadDirectory))
            {
                Directory.CreateDirectory(uploadDirectory);
            }

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await videoFile.CopyToAsync(stream);
            }

            return Ok(new { filePath });
        }
        [HttpGet("GetVideo/{fileName}")]
        [Produces("video/mp4", "video/x-msvideo", "video/quicktime", "video/x-ms-wmv")]
        [ProducesResponseType(typeof(FileResult), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetVideo(string fileName)
        {
            var uploadDirectory = @"C:\MyUploads";
            var filePath = Path.Combine(uploadDirectory, fileName);

            if (!System.IO.File.Exists(filePath))
                return NotFound("Video not found.");

            var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 4096, useAsync: true);
            var mimeType = GetMimeTypeVideo(filePath);

            return File(stream, mimeType);
        }
	

		private string GetMimeTypeVideo(string filePath)
        {
            var extension = Path.GetExtension(filePath).ToLowerInvariant();
            return extension switch
            {
                ".mp4" => "video/mp4",
                ".avi" => "video/x-msvideo",
                ".mov" => "video/quicktime",
                ".wmv" => "video/x-ms-wmv",
                _ => "application/octet-stream",
            };
        }
    }
}
