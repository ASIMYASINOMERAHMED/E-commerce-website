let totalPrice = 0;
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
const categoriesNav = document.getElementById('mainNav');
let cartNum = 0;
let totalAmount = 0;

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
document.addEventListener('DOMContentLoaded', loadCartData);
//window.onload = fetchCategories();
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
function checkout()
{
    const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));

    if(currentCustomer==null)
    {
        localStorage.setItem('redirectAfterLogin', `checkout.html?totalAmount=${totalPrice}`);
        window.location.href='login.html';
    }
    else
    {
        window.location.href=`checkout.html?totalAmount=${totalPrice}`;
    }
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
           console.log('Unable to fetch categories.');
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
                                            <a class="nav-link" href="index.html">Home <span class="sr-only">(current)</span></a>
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

function getCartItems() 
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
    } return cartItems; 
}
async function loadCartData() 
{ 
   // const cart = JSON.parse(localStorage.getItem('cart')) || [];
    //const cart = getCartItems();
    const tableBody = document.querySelector('#cartItems tbody');
    const tfoot = document.querySelector('#cartItems tfoot');
    tableBody.innerHTML = ''; // Clear any existing rows
    tfoot.innerHTML ='';
    const cartItems = getCartItems();
    if(cartItems.length==0)
    {
        headerqty.textContent = ``;
        headerPrice.textContent = ``;
        document.getElementById('shoppingCart').innerHTML=`<div class="text-center">--Empty Cart Items--</div>`
        return;
    }
    for (const item of cartItems) {
        totalPrice+=item.totalItemsPrice;
        const thumbnail = await getProductImage(item.imageURL);

        const row = document.createElement('tr');
        row.classList.add('cart-item');
        row.innerHTML = `
                <td>
                         <a href="product.html?id=${item.productId}">
                                                              <img src="${thumbnail}" class="img-fluid"> 
                                                     </a>     
                </td>
                <td>
                        ${item.title}
                </td>
                <td>
                        ${item.color}
                </td>
                  <td>
                        ${item.size}
                </td>
                <td class="price">
                        $${item.price}
                </td>
                <td>
                        <input class="quantity" onchange="calculatePrice(this, ${item.productId})" type="number" min="1" value="${item.quantity}">
                </td>
                <td class="total-item-price">
                       Subtotal (${item.quantity} items): $${item.totalItemsPrice}
                </td>
                <td>
                        <button onclick="deleteCartItem(${item.productId})" class="btn btn-link text-danger"><i class="fas fa-times"></i></button>
                </td>`;
        tableBody.appendChild(row);
        console.log(tableBody);
    }
    headerqty.textContent = `${cartItems.length}`;
    headerPrice.textContent=`${totalPrice}`;
     const row = document.createElement('tr');
        row.innerHTML = `<th colspan="7" class="text-right">Total</th>
                                                <th id="totalCartPrice">$${totalPrice}</th>
                                                <th></th>`;
        tfoot.appendChild(row);
  
}
function calculatePrice(input, productID)
{ 
    totalPrice=0;
    const cart = getCartItems();
    const cartItem = cart.find(item => item.productId === productID); 
    const quantity = parseInt(input.value); 
    if (cartItem) 
    { 
        cartItem.quantity = quantity; 
        cartItem.totalItemsPrice = cartItem.price * quantity; 
        localStorage.setItem(`cartItem_${productID}`, JSON.stringify(cartItem)); 
    } 
    loadCartData(); // Reload the cart to reflect the changes 
}
function deleteCartItem(productID)
{
    totalPrice=0;
    const itemKey = `cartItem_${productID}`;
    localStorage.removeItem(itemKey);
    console.log(`Cart item with productID ${productID} removed.`);
    loadCartData();
}


async function getProductImage(imageFile) {
    try 
    { 
        const response = await fetch(`https://localhost:7171/api/ProductImages/GetImage/${imageFile}`);
        if (!response.ok) 
        { 
            throw new Error('Image not found.');
        } 
        const blob = await response.blob(); 
        const imageUrl = URL.createObjectURL(blob);
        return imageUrl; 
    } 
    catch (error)
    {
        console.error('Error:', error);
        return null; 
    }
   
}