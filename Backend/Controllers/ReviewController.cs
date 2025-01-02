using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using static OnlineStoreDataAccess.clsReviewData;

namespace OnlineStoreRestApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewController : ControllerBase
    {
        [HttpGet("All", Name = "GetAllReviews")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ReviewDTO>> GetAllReviews()
        {
            List<ReviewDTO> ReviewList = OnlineStoreBusiness.clsReview.GetAllReviews();
            if (ReviewList.Count == 0)
            {
                return NotFound("No Reviews Found!");
            }
            return Ok(ReviewList);
        }
		[HttpGet("GetRatingPersentage", Name = "GetRatingPersentage")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<RatingPersentageDTO>> GetRatingPersentage(int ProductID)
		{
			List<RatingPersentageDTO> List = OnlineStoreBusiness.clsReview.GetRatingPersentage(ProductID);
			if (List.Count == 0)
			{
				return NotFound("No Ratings Found!");
			}
			return Ok(List);
		}
		[HttpGet("GetAvrageRatingForProduct", Name = "GetAvrageRatingForProduct")]
		[ProducesResponseType(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public ActionResult<IEnumerable<decimal>> GetAvrageRatingForProduct(int ProductID)
		{

			decimal AvrageRating = OnlineStoreBusiness.clsReview.GetAvrageRatingForProductID(ProductID);
			return Ok(AvrageRating);
		}
		[HttpGet("Reviews-For-CustomerID {CustomerID}", Name = "GetAllReviewsForCustomerID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<ReviewDTO>> GetAllReviewsForCustomerID(int CustomerID)
        {
            List<ReviewDTO> ReviewList = OnlineStoreBusiness.clsReview.GetAllReviewsForCustomerID(CustomerID);
            if (ReviewList.Count == 0)
            {
                return NotFound("No Reviews Found!");
            }
            return Ok(ReviewList);
        }
        [HttpGet("Reviews-For-ProductID {ProductID}", Name = "GetAllReviewsForProductID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<IEnumerable<DetailedReviewDTO>> GetAllReviewsForProductID(int ProductID)
        {
            List<DetailedReviewDTO> ReviewList = OnlineStoreBusiness.clsReview.GetAllReviewsForProductID(ProductID);
            if (ReviewList.Count == 0)
            {
                return NotFound("No Reviews Found!");
            }
            return Ok(ReviewList);
        }
        [HttpGet("{ReviewID}", Name = "GetReviewByID")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult<IEnumerable<ReviewDTO>> GetReviewByID(int ReviewID)
        {
            if (ReviewID < 1)
            {
                return BadRequest($"Not Accepted ID");
            }
            OnlineStoreBusiness.clsReview review = OnlineStoreBusiness.clsReview.Find(ReviewID);

            if (review == null)
            {
                return NotFound($"Review not found.");
            }

            ReviewDTO DTO = review.ReviewDTO;

            return Ok(DTO);
        }
        [HttpPost("AddReview", Name = "AddReview")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ReviewDTO> AddReview(ReviewDTO reviewDTO)
        {

            if (reviewDTO == null || string.IsNullOrEmpty(reviewDTO.ReviewText) || reviewDTO.CustomerID < 1 || reviewDTO.ProductID < 1 || reviewDTO.Rating < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsReview review = new OnlineStoreBusiness.clsReview(new ReviewDTO(reviewDTO.ReviewID, reviewDTO.ProductID, reviewDTO.CustomerID, reviewDTO.ReviewText, reviewDTO.Rating, reviewDTO.ReviewDate));

            try
            {
                review.Save();
                return CreatedAtRoute("GetReviewByID", new { ReviewID = review.ReviewDTO }, reviewDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }

        [HttpPut("UpdateReview", Name = "UpdateReview")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public ActionResult<ReviewDTO> UpdateReview(ReviewDTO UpdatedReview)
        {

            if (UpdatedReview == null || string.IsNullOrEmpty(UpdatedReview.ReviewText) || UpdatedReview.CustomerID < 1 || UpdatedReview.ProductID < 1 || UpdatedReview.Rating < 1)
            {
                return BadRequest("Invalid data.");
            }

            OnlineStoreBusiness.clsReview review = OnlineStoreBusiness.clsReview.Find(UpdatedReview.ReviewID);


            if (review == null)
            {
                return NotFound($"Review not found.");
            }


            review.ReviewID = UpdatedReview.ReviewID;
            review.CustomerID = UpdatedReview.CustomerID;
            review.ProductID = UpdatedReview.ProductID;
            review.Rating = UpdatedReview.Rating;
            review.ReviewText = UpdatedReview.ReviewText;
            review.ReviewDate = UpdatedReview.ReviewDate;
            try
            {
                review.Save();

                return Ok(review.ReviewDTO);
            }
            catch (Exception e)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { Message = e.Message });
            }

        }
        [HttpDelete("Delete-Review {ReviewID}", Name = "DeleteReview")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult DeleteReview(int ReviewID)
        {
            if (ReviewID < 0)
            {
                return BadRequest($"Not Accepted ID");
            }

            if (OnlineStoreBusiness.clsReview.Delete(ReviewID))
                return Ok($"Review has been deleted.");
            else
                return NotFound($"Review not found. no rows deleted!");
        }
    }
}

