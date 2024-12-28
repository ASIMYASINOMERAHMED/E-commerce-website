const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
const qty = document.getElementById('qty');
const dropdownColor = document.getElementById('dropdownColor');
const dropdownSize = document.getElementById('dropdownSize');
const categoriesNav = document.getElementById('mainNav');
const search = document.getElementById('search');
const btnsearch = document.getElementById('btnserach');
let productID;
let thumbnail;
let productTitle;
let productPrice;
const similarProducts = document.getElementById('similarProducts');
const pagination = document.querySelector('.pagination');
let currentPageForSubCategoryID;
let totalPagesSubCategoryID;
let reviewsContainer = document.getElementById('reviewsContainer');
let reviewText = document.getElementById('reviewText');
let reviewForm = document.getElementById('reviewForm');
const ratingInputs = document.querySelectorAll('input[name="rating"]');
const ratingPercentage = document.getElementById('ratingPercentage');
const avrageRating = document.querySelector('.average-rating');
const ratingCount = document.getElementById('ratingCount');
const addToWishList = document.getElementById('addToWishList');
const btnSend = document.getElementById('sendMessage');
const message = document.getElementById('message');
let ratingValue=1;
window.onload = displayProductDetails();
window.onload = displayCartQtyAndPrice();
//window.onload = fetchCategories();
document.addEventListener('DOMContentLoaded', function() {
    const btnsearch = document.getElementById('btnsearch');
    const search = document.getElementById('search');

    btnsearch.onclick = async function(event) {
        event.preventDefault();
        if (search.value.trim() !== '') {
 
            console.log('Search value:', search.value); // Debugging line
            window.location.href = `searchedProducts.html?searchValue=${search.value}`;
        } else {
            console.log('Search input is empty.'); // Debugging line
        }
    };
});
btnSend.onclick=async function (event) {
    event.preventDefault();
    if(message.value == '')
        return;
    await addMessage();
}
async function addMessage()
{
  const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));
  const now = new Date();
    fetch("https://localhost:7171/api/Messages/AddMesaage", {
        method: "POST",
        mode: 'cors',
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
            messageID: 0,
            customerID: currentCustomer.customerID,
            message: message.value,
            dateTime: now.toISOString()
        })
      })
      .then(response => {
        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to send Message",
                showConfirmButton: false,
                timer: 1500
              });
          throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data);
        Swal.fire({
            position: "center",
            icon: "success",
            title: "Message has been sent",
            showConfirmButton: false,
            timer: 1500
          });
          document.getElementById('message').value='';
      })
      .catch(error => {
        console.error("Error:", error);
      });
}
$(function() {

    $('.nav-item.dropdown').mouseenter(function() {
        $(this).addClass('show');
        $(this).children('.dropdown-menu').addClass('show');
        $(this).children('.dropdown-toggle').attr('aria-expanded', 'true');
    }).mouseleave(function() {
        $(this).removeClass('show');
        $(this).children('.dropdown-menu').removeClass('show');
        $(this).children('.dropdown-toggle').attr('aria-expanded', 'false');
    });

    $('.img-small').on('mouseenter click', function() {
        var src = $(this).data('src');
        $('.img-large').css("background-image", "url('"+src+"')");
    });

    var imgLarge = $('.img-large');

    imgLarge.mousemove(function() {
        var relX = event.pageX - $(this).offset().left;
        var relY = event.pageY - $(this).offset().top;
        var width = $(this).width();
        var height = $(this).height();
        var x = (relX / width) * 100;
        var y = (relY / height) * 100;
        $(this).css("background-position", x+"% "+y+"%");
        console.log('hi');
    });

    imgLarge.mouseout(function() {
        $(this).css("background-position", "center");
        console.log('hi');

    });

    $( window ).resize(function() {
        setImgLarge();
        setImgSmall();
    });

    setImgLarge();
    setImgSmall();

});

function setImgLarge() {
    var imgLarge = $('.img-large');
    var width = imgLarge.width();
    imgLarge.height(width * 2/3);
}

function setImgSmall() {
    var imgSmall = $('.img-small');
    var width = imgSmall.width();
    imgSmall.height(width);
}

document.addEventListener('DOMContentLoaded', function() {
    const btnsearch = document.getElementById('btnsearch');
    const search = document.getElementById('search');

    btnsearch.onclick = async function(event) {
        event.preventDefault();
        if (search.value.trim() !== '') {
 
            console.log('Search value:', search.value); // Debugging line
            window.location.href = `searchedProducts.html?searchValue=${search.value}`;
        } else {
            console.log('Search input is empty.'); // Debugging line
        }
    };
});

ratingInputs.forEach(input => 
{ 
        input.addEventListener('click', function () 
        {
             ratingValue = this.value; 
             console.log('Selected Rating:',ratingValue);
        });
});

async function addReview(customerId) {
    const today = new Date();
    try {
        const response = await fetch("https://localhost:7171/api/Review/AddReview", {
            method: "POST",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                reviewID: 0,
                productID: productID,
                customerID: customerId,
                reviewText: reviewText.value,
                rating: ratingValue,
                reviewDate: today.toISOString()
            })
        });

        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to save Review",
                showConfirmButton: false,
                timer: 1500
            });
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);

        await fetchReviews(productID);

        Swal.fire({
            position: "center",
            icon: "success",
            title: "Thank you for the feedback 😊",
            showConfirmButton: false,
            timer: 1500
        });
    } catch (error) {
        console.error("Error:", error);
    }
}
async function isAddedToFavourits(customerId) {
    try {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/AddedToFavouriteByCustomerID?ProductID=${productID}&CustomerID=${customerId}`, {
            method: "GET",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to add to wishlist",
                showConfirmButton: false,
                timer: 1500
            });
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);
        return data;
 
    } catch (error) {
        console.error("Error:", error);
    }
}
async function AddToFavourit(customerId) {

    let addedToFavourits = await isAddedToFavourits(customerId);
    console.log(addedToFavourits);
    if(addedToFavourits===true)
    {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "Item Already Added To WishList 😊",
            showConfirmButton: false,
            timer: 1500
        });
        return;
    } 
    else
    {
    try {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/AddToFavourit?ProductID=${productID}&CustomerID=${customerId}`, {
            method: "GET",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to add to wishlist",
                showConfirmButton: false,
                timer: 1500
            });
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);
        Swal.fire({
            position: "center",
            icon: "success",
            title: "Item Added To WishList 😊",
            showConfirmButton: false,
            timer: 1500
        });
    } catch (error) {
        console.error("Error:", error);
    }
}
}
addToWishList.onclick = async function (event) {
    event.preventDefault();
    const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));
    
    if(currentCustomer==null)
    {
        localStorage.setItem('redirectAfterLogin', window.location.href);
        window.location.href='login.html';
    }
    else
    {

       await AddToFavourit(currentCustomer.customerID);
    }
}
reviewForm.onsubmit= async function(event)
{
    event.preventDefault();
    if(reviewText.value==='')
    {
       return;
    }
    else
    {
   
    const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));
    
    if(currentCustomer==null)
    {
        localStorage.setItem('redirectAfterLogin', window.location.href);
        window.location.href='login.html';
    }
    else
    {
       await addReview(currentCustomer.customerID);
    }
}
}
async function fetchAvrageRating(productID)
 {
console.log(productID);
    try 
    {
        const Response = await fetch(`https://localhost:7171/api/Review/GetAvrageRatingForProduct?ProductID=${productID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!Response.ok)
        {
           console.log('Unable to fetch data.');
           avrageRating.innerHTML = '';
        }
        const data = await Response.json();
        if(data=='0')
          avrageRating.innerHTML = '';
        else
          avrageRating.innerHTML = data;
    }
    catch(error)
    {
        console.log(error);
    }
}
async function fetchRatingPercentage(productID)
 {
console.log(productID);
    try 
    {
        const Response = await fetch(`https://localhost:7171/api/Review/GetRatingPersentage?ProductID=${productID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!Response.ok)
        {
           console.log('Unable to fetch data.');
           ratingPercentage.innerHTML = '';
           ratingCount.innerHTML='';
        }
        const data = await Response.json();
console.log(data);
        populateRatingPercentage(data);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateRatingPercentage(data)
{
    let ratingList='';
    let count=0;
     for(const rating of data)
     {
        count+=rating.ratingCount;
        ratingList+=` <li>
                                                            <div class="progress">
                                                                <div class="progress-bar bg-dark" role="progressbar" style="width: ${rating.ratingPerserntage}%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100">${rating.ratingPerserntage}%</div>
                                                            </div>
                                                            <div class="rating-progress-label">
                                                                ${rating.rating}<i class="fas fa-star ml-1"></i>
                                                            </div>
                                                        </li>`
     }
      ratingPercentage.innerHTML=ratingList;
      ratingCount.innerHTML = `of ${count} reviews`;
}
async function fetchReviews(productID)
 {
console.log(productID);
    try 
    {
        const Response = await fetch(`https://localhost:7171/api/Review/Reviews-For-ProductID ${productID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!Response.ok)
        {
           console.log('Unable to fetch reviews.');
           reviewsContainer.innerHTML = '';
        }
        const reviews = await Response.json();

        populateReviews(reviews);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateReviews(reviews)
{
    let reviewsList = ''; 
    for (const review of reviews) 
    {
        let rating = ``;
        for(let i=1;i<=5;i++)
        {
            if(i<=review.rating)
            {
                rating +=`<i class="fas fa-star"></i>`; 
            }
            else
            {
                rating+=`<i class="far fa-star"></i>`;
            }
        }
        reviewsList+=`     <div class="col-12 text-justify py-2 mb-3 bg-gray">
                                                <div class="row">
                                                 <div class="col-12">
                                                        <strong class="mr-2">${review.customer}</strong>
                                                        <small>
                                                          ${rating}
                                                        </small>
                                                    </div>
                                                    <div class="col-12">
                                                        ${review.reviewText}
                                                    </div>
                                                    <div class="col-12">
                                                        <small>
                                                            <i class="fas fa-clock mr-2"></i>${review.reviewDate}
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>                            
`;
    }
    reviewsContainer.innerHTML = reviewsList;
}
async function fetchCategories()
 {

    try 
    {
        const categoriesResponse = await fetch("https://localhost:7171/api/ProductCategory/All",{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!categoriesResponse.ok)
        {
           console.log('Unable to fetch categoies.');
        }
        const categories = await categoriesResponse.json();

        populateCategories(categories);
    }
    catch(error)
    {
        console.log(error);
    }
}
async function fetchSubCategories(categoryID) {
    
       try
       {
        const subcategoiesResponse = await fetch(`https://localhost:7171/api/SubCategory/${categoryID}`,{
               method: 'GET',
               mode: 'cors',
               headers: {
                 'Content-Type': 'application/json'
               }
             });
           if(!subcategoiesResponse.ok)
           {
               console.log('an error occurd');
           }
           const data = await subcategoiesResponse.json();
           return data;
       }
       catch(error)
       {
           console.log(error);
       }
}


async function populateCategories(categories)
{

    let categoriesNavItems = `   <ul class="navbar-nav mx-auto mt-2 mt-lg-0">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="index.html"> Home <span class="sr-only">(current)</span></a>
                                        </li>`
        for(let i=0;i<categories.length;i++)
        {
            let subcategorieslist = await fetchSubCategories(categories[i].categoryID);
            let subcategories='';
            for(let j=0;j<subcategorieslist.length;j++)
            {
               subcategories+= `<a class="dropdown-item" href="category.html">${subcategorieslist[j].subCategoryName}</a>`
            }
        categoriesNavItems+=`
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="${categories[i].categoryID}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${categories[i].categoryName}</a>
                                            <div class="dropdown-menu" aria-labelledby="${categories[i].categoryID}">
                                                ${subcategories}
                                            </div>
                                        </li>
 
    `
    }
    categoriesNavItems+=`</ul>`
    categoriesNav.innerHTML = categoriesNavItems;
}


function displayCartQtyAndPrice() 
{ 
    const cartItems = []; 
    for (let i = 0; i < localStorage.length; i++) 
    { 
        const key = localStorage.key(i); 
        if (key.startsWith('cartItem_')) 
        { 
            const item = JSON.parse(localStorage.getItem(key)); 
            cartItems.push(item); 
        } 
    } 
    if(cartItems.length==0)
    {
        headerqty.textContent = ``;
        headerPrice.textContent = ``;
        return;
    }
    else
    {
        let totalPrice =0;
        for (const item of cartItems) {
            totalPrice+=item.totalItemsPrice;
        }
        headerqty.textContent = `${cartItems.length}`;
        headerPrice.textContent = `$${totalPrice}`;
    }
}
// Function to get query parameter by name 
function getQueryParameter(name)
 { 
    const urlParams = (new URL(document.location)).searchParams; 
    return urlParams.get(name);
 } 
 async function fetchTotalPagesForSubCategoryID(subCategoryID)
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/Total-Pages-For-SubCategoryID?SubCategoryID=${subCategoryID}`,{
           method: 'GET',
           mode: 'cors',
           headers: {
             'Content-Type': 'application/json'
           }
         });
       if(!response.ok)
       {
           console.log('an error occurd');
       }
       const data = await response.json();
       totalPagesSubCategoryID = data;
       populatePaginationForSubCategoryID(totalPagesSubCategoryID);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populatePaginationForSubCategoryID(totalPages)
{
  let content='<a href="javascript:handlePrevForSubCategoryID()">Prev</a>';
  for(let i=1;i<=totalPages;i++)
  {
     content+=`<a href="javascript:fetchProductsForSubCategoryID(${subCategoryID},${i})" id="subCategoryPage${i}">${i}</a>`;
  }
  content+=`<a href="javascript:handleNextForSubCategoryID()">Next</a>`;
  pagination.innerHTML = content;
}
function handleNextForSubCategoryID()
{
    currentPageForSubCategoryID==totalPagesSubCategoryID? fetchProductsForSubCategoryID(subCategoryID,1):fetchProductsForSubCategoryID(subCategoryID,currentPageForSubCategoryID+1);
}
function handlePrevForSubCategoryID()
{
    currentPageForSubCategoryID==1? fetchProductsForSubCategoryID(subCategoryID,totalPagesSubCategoryID):fetchProductsForSubCategoryID(subCategoryID,currentPageForSubCategoryID-1);
}
 async function fetchProductsForSubCategoryID(subCategoryID,pageNumber) {
    fetchTotalPagesForSubCategoryID(subCategoryID);
    currentPageForSubCategoryID = pageNumber;
    try
    {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/Page ${pageNumber}/${subCategoryID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            console.log('an error occurd');
        }
        const products = await response.json();
        await populateProducts(products);
        const activePages = pagination.querySelectorAll('.active');

        if(activePages!=null)
        {
          activePages.forEach(page => {
            if(page.classList.contains('active'))
            {
              page.classList.remove('active');
            }
            });
        }
      
        document.getElementById(`subCategoryPage${currentPageForSubCategoryID}`).classList.add("active");
        pagination.style.display = 'block';
    }
    catch(error)
    {
        console.log(error);
    }  
}

 async function getProductThumbnail(imageFile) {
    try {
        console.log(imageFile);
        const response = await fetch(`https://localhost:7171/api/ProductImages/GetImage/${imageFile}`);
        
        if (!response.ok) {
            throw new Error('Image not found.');
        }

        const blob = await response.blob();
        const imageUrl = URL.createObjectURL(blob);
        return imageUrl;
    } catch (error) {
        console.error('Error:', error);
        return null;
    }
}

async function populateProducts(products) {
 
    let productList = '';
    for (const product of products) {
        let originalPrice = +product.price+ +product.taxes+ +product.ads;
        let priceContent;
        if(product.discount!=0&&product.discount!=null)
        {
            let discountedPrice =  calculateDiscountedPrice(originalPrice,product.discount);
            priceContent=` 
                <span class="product-price">
                    $${discountedPrice}
                </span>
                    <span class="product-price-old">
                    $${originalPrice}
                </span>`;
        }
        else
        {
            priceContent=` 
            <span class="product-price">
                $${originalPrice}
            </span> `;
        }
        const productImage = await getProductThumbnail(product.imageURL);
     productList+=`        <!-- Product -->
                                <div class="col-xl-2 col-lg-3 col-sm-6 my-3">
                                    <div class="col-12 bg-white text-center h-100 product-item">
                                        <div class="row h-100">
                                            <div class="col-12 p-0 mb-3">
                                                <a href="product.html?id=${product.productID}">
                                                    <img src="${productImage}" class="img-fluid">
                                                </a>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <a href="product.html?id=${product.productID}" class="product-name">${product.productName}</a>
                                            </div>
                                            <div class="col-12 mb-3">
                                                  ${priceContent}
                                            </div>
                                            <div class="col-12 mb-3 align-self-end">
                                                <button onclick="addToCart(${product.productID})" class="btn btn-outline-dark" type="button"><i class="fas fa-cart-plus mr-2"></i>Add to cart</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Product -->`
    }
    similarProducts.innerHTML = productList;
}
function addToCart(productID)
{
    window.location.href = `product.html?id=${productID}`;
}
 // Function to fetch and display product details 
 async function displayProductDetails() 
 { 
    const productId =parseInt(getQueryParameter('id'), 10);
    if (isNaN(productId))
         { console.error('Invalid product ID');
         document.getElementById('product-details').innerHTML = 'Product not found.';
          return;
         } 
    console.log('Product ID:', productId);

    try
    {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/ProductID ${productId}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            console.log('an error occurd');
        }
        const product = await response.json();
        productID = product.productID;
        productTitle = product.shortDescription;
        thumbnail = product.imageURL;
        await populateProductInfo(product);
        await getThumbnail(product.imageURL);
        await getProductImages(productId);
        await populateProductPrice(product);
        await fetchProductColors(productId);
        await fetchProductSize(productId);
        await fetchRatingPercentage(productId);
        await fetchAvrageRating(productId);
        await fetchReviews(productId);
        await fetchProductsForSubCategoryID(product.subCategoryID,1);

    }
    catch(error)
    {
        console.log(error);
    }    
}
async function getThumbnail(imageFile) {
    fetch(`https://localhost:7171/api/ProductImages/GetImage/${imageFile}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Image not found.');
        }
        return response.blob();
    })
    .then(blob => {
        const imageUrl = URL.createObjectURL(blob);
         document.getElementById('productThumbnail').innerHTML = '';
        document.getElementById('productThumbnail').innerHTML = `<div class="img-large border" style="background-image: url('${imageUrl}')"></div>`;

         setImgLarge();
         var imgLarge = $('.img-large');

         imgLarge.mousemove(function() {
             var relX = event.pageX - $(this).offset().left;
             var relY = event.pageY - $(this).offset().top;
             var width = $(this).width();
             var height = $(this).height();
             var x = (relX / width) * 100;
             var y = (relY / height) * 100;
             $(this).css("background-position", x+"% "+y+"%");

         });
     
         imgLarge.mouseout(function() {
             $(this).css("background-position", "center");
     
         });

    })
    .catch((error) => {
        console.error('Error:', error);
    });
   
  }


async function getProductImages(productID) {
    fetch(`https://localhost:7171/api/ProductImages/ProductID ${productID}`, {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json'
      }
  })
  .then(response => response.json())
  .then(data => {console.log(data)
   displayProductImages(data);
  })
  .catch((error) => {
      console.error('Error:', error);
  });
  
  }
  async function displayProductImages(data) {

     document.getElementById('imageGrid').innerHTML = ''; 
     let images = '';
      const imagePromises = data.map(item => 
        fetch(`https://localhost:7171/api/ProductImages/GetImage/${item.imageUrl}`)
       .then(response => 
        { 
            if (!response.ok) 
                { 
                    throw new Error('Image not found.'); 
                } 
                return response.blob(); // Assume response is JSON containing the image URL
        }) 
       .then(blob => {
        const imageUrl = URL.createObjectURL(blob);
                    return `<div class="col-sm-2 col-3"> 
                    <div class="img-small border" style="background-image: url('${imageUrl}')" data-src="${imageUrl}"></div>
                     </div>`; 
        })
       .catch((error) => { 
        console.error('Error:', error); 
        return ''; // Return empty string if there's an error
        }) );
                          const imageElements = await Promise.all(imagePromises);
                          images = imageElements.join('');
                           document.getElementById('imageGrid').innerHTML=images;
                           setImgSmall();
                           $('.img-small').on('mouseenter click', function() {
                            var src = $(this).data('src');
                            $('.img-large').css("background-image", "url('"+src+"')");
                        });
}
function displayImage(imageUrl) {

    const imageContainer = document.createElement('div');
    imageContainer.classList.add('img-small');
  
    imageContainer.style.backgroundImage = "url('" + imageUrl + "')";

    document.getElementById('imageGrid').appendChild(imageContainer);
console.log(imageContainer);
  }
async function fetchProductColors(productID)
{
    dropdownColor.innerHTML=`<option value="0">--SELECT COLOR--</option>`;
    fetch(`https://localhost:7171/api/ProductColor/${productID}`)
    .then(response => response.json())
    .then(data => {
        data.forEach(color => {
            const option = document.createElement('option');
            option.value = color.colorsID;
            option.textContent =color.colors;

            dropdownColor.appendChild(option);
        });
    })
    .catch(error => console.error('Error fetching data:', error));
}
async function fetchProductSize(productID)
{
    dropdownSize.innerHTML=`<option value="0">--SELECT SIZE--</option>`;
    fetch(`https://localhost:7171/api/ProductSize/${productID}`)
    .then(response => response.json())
    .then(data => {
        data.forEach(size => {
            const option = document.createElement('option');
            option.value = size.sizeID;
            option.textContent =size.size;

            dropdownSize.appendChild(option);
        });
    })
    .catch(error => console.error('Error fetching data:', error));
}
async function populateProductInfo(product)
{
    document.getElementById('product-Info').innerHTML=`
                                <div class="col-12 product-name large">
                                    ${product.shortDescription}
                                   <!--  <small>By <a href="#">Dell</a></small> -->
                                </div>
                                <div class="col-12 px-0">
                                    <hr>
                                </div>
                                <div class="col-12">
                                    ${product.longDescription}
                                </div>
                            </div>

                 `;

}
function calculateDiscountedPrice(originalPrice, discountPercentage) 
{ // Ensure values are valid numbers 
  if (originalPrice <= 0 || discountPercentage < 0 || discountPercentage > 100)
  {
    throw new Error('Invalid values.'); 
  } 
      const discountMultiplier = 1 - (discountPercentage / 100);
      const discountedPrice = originalPrice * discountMultiplier;
      return discountedPrice.toFixed(2); // Return the discounted price with two decimal places
}
async function populateProductPrice(product)
{
    let originalPrice = +product.price+ +product.taxes+ +product.ads;
    if(product.discount!=0)
    {
        let discountedPrice =  calculateDiscountedPrice(originalPrice,product.discount);
        productPrice = discountedPrice;
        document.getElementById('price').innerHTML=` 
            <span class="detail-price">
                $${discountedPrice}
            </span>
                <span class="detail-price-old">
                $${originalPrice}
            </span>`;
    }
    else
    {
        productPrice = originalPrice;
        document.getElementById('price').innerHTML=` 
        <span class="detail-price">
            $${originalPrice}
        </span> `;
    }
   
}


document.getElementById('addToCart').addEventListener('click', function() {
   
const quantity = qty.value;
const size = dropdownSize.selectedOptions[0].text;
const color = dropdownColor.selectedOptions[0].text;
const price = parseFloat(productPrice); 
const totalItemsPrice = quantity * price; 

if(size=='--SELECT SIZE--'||size==null||color=='--SELECT COLOR--'||color==null)
{
    Swal.fire({
        position: "center",
        icon: "error",
        title: "Please choose size and color",
        showConfirmButton: false,
        timer: 1500
    });
    return;
}

const cartItem = 
{ 
  productId: productID,
  title: productTitle,
  quantity: quantity,
  size: size, 
  color: color, 
  price: price, 
  totalItemsPrice: totalItemsPrice,
  imageURL: thumbnail
}; 
  // Retrieve existing cart from local storage or initialize a new array 
  const itemKey = `cartItem_${productID}`;
   // Save the cart item with its unique key 
   localStorage.setItem(itemKey, JSON.stringify(cartItem))
  // Add the new cart item 
  displayCartQtyAndPrice();
  console.log('Cart item added:', cartItem)

    Swal.fire({
        title: "Added to cart",
        text: "Item added to cart",
        icon: "success",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Go to Cart",
        customClass: {
          confirmButton: 'confirm-button-class',
          cancelButton: "cancel-button-class"
        },
        buttonsStyling: false,
      }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'cart.html';
        }})

})