document.addEventListener('DOMContentLoaded', function() {
    const btnsearch = document.getElementById('btnserach');
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
const btnSend = document.getElementById('sendMessage');
const message = document.getElementById('message');
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
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
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

const productsContainer = document.getElementById('productsContainer');

window.onload = displayCartQtyAndPrice();
window.onload = fetchProducts();
async function fetchProducts() {
    const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));
    console.log(currentCustomer);
    try
    {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/Favourits-For-CustomerID ${currentCustomer.customerID}`,{
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
        console.log(products);
        await populateProducts(products);
     
      
    }
    catch(error)
    {
        console.log(error);
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
productsContainer.innerHTML = productList;
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
