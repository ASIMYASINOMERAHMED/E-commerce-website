const search = document.getElementById('search');
const btnsearch = document.getElementById('btnserach');
const productsContainer = document.getElementById('productsContainer');
const btnSend = document.getElementById('sendMessage');
const message = document.getElementById('message');
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
window.onload=searchedProducts();
window.onload = displayCartQtyAndPrice();
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
async function searchedProducts() {
    const urlParams = new URLSearchParams(window.location.search);
const searchValue = urlParams.get('searchValue'); 
    console.log('Search Value:', searchValue);
    fetchProducts(searchValue);
}
async function fetchProducts(searchValue) {
    try {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/${searchValue}`, {
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
                title: "Unable to get products",
                showConfirmButton: false,
                timer: 1500
            });
            productsContainer.innerHTML=`  <div class="col-12 text-center text-uppercase"> 
            <div class="text-center">
               <p class="lead text-gray-800 mb-5">Product Not Found</p>
               <a href="index.html">&larr; Back to home</a>
           </div>
           </div>`;
            throw new Error("Product Not Found " + response.statusText);
            return response;
        }

        const products = await response.json();
        console.log("Success:", products);
        populateProducts(products);
    } catch (error) {
        console.error("Error:", error);
    }
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
 
    if(products.length==0)
    {
        productsContainer.innerHTML=`  <div class="col-12 text-center text-uppercase"> 
        <div class="text-center">
           <p class="lead text-gray-800 mb-5">Product Not Found</p>
           <a href="index.html">&larr; Back to home</a>
       </div>
       </div>`;
       return;
    }
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
    productsContainer.innerHTML = productList;
}
btnsearch.onclick=async function() {
    console.log(search.value);
    fetchProducts(search.value);
}