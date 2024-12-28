const categoriesNav = document.getElementById('mainNav');
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
const topSellingProducts = document.getElementById('topSellingProducts');
const pagination = document.querySelector('.pagination');
const newArrivalPagination = document.querySelector('.newArrivalPagination');
let totalPages;
let newArrivalTotalPages;
let currentPage;
let newArrivalCurrentPage;

window.onload = fetchCategories();
window.onload = fetchtopSellingProducts();
window.onload = fetchProducts(1);
window.onload = fetchNewArrivalProducts(1);
window.onload = displayCartQtyAndPrice();

const sidebar = document.getElementById('sidebar');
const openSidebarBtn = document.getElementById('openSidebarBtn'); 
const closeSidebarBtn = document.getElementById('closeSidebarBtn'); 
const overlay = document.getElementById('overlay'); 
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


// Event listener to open the sidebar
 openSidebarBtn.addEventListener('click', function() 
 { 

    sidebar.classList.toggle('open'); 
    overlay.classList.toggle('show'); 
    openSidebarBtn.classList.add('hide'); 
});
     // Event listener to close the sidebar when clicking on the close button
  closeSidebarBtn.addEventListener('click', function() 
  { 
    sidebar.classList.remove('open'); 
    overlay.classList.remove('show'); 
 
}); 
// Event listener to close the sidebar when clicking outside of it 
  overlay.addEventListener('click', function() 
  { 
    sidebar.classList.remove('open'); 
    overlay.classList.remove('show'); 
   
});
sidebar.addEventListener('transitionend', function(event) 
{ 
    if (!sidebar.classList.contains('open')) 
    { 
            openSidebarBtn.classList.remove('hide'); // Show the open button after transition 
    }
});

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
async function fetchTotalPages()
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/Total-Pages`,{
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
       totalPages = data;
       populatePagination(totalPages);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populatePagination(totalPages)
{
  let content='<a href="javascript:handlePrev()">Prev</a>';
  for(let i=1;i<=totalPages;i++)
  {
     content+=`<a href="javascript:fetchProducts(${i})" id="page${i}">${i}</a>`;
  }
  content+=`<a href="javascript:handleNext()">Next</a>`;
  pagination.innerHTML = content;
}
function handleNext()
{
 currentPage==totalPages? fetchProducts(1):fetchProducts(currentPage+1);
}
function handlePrev()
{
  currentPage==1? fetchProducts(totalPages):fetchProducts(currentPage-1);
}

async function fetchProducts(pageNumber)
{
   fetchTotalPages();
   currentPage=pageNumber;
   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/Page ${pageNumber}`,{
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
       populateProducts(data);
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
     
       document.getElementById(`page${currentPage}`).classList.add("active");
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
async function populateProducts(data)
{
    let productList = '';
    for (const product of data) {
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
     productList+=`   <!-- Product -->
                                     <div class="col-lg-3 col-sm-6 my-3">
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
                                                     <a href="product.html?id=${product.productID}" class="product-name">${product.shortDescription}</a>
                                                 </div>
                                                    <div class="col-12 mb-3">
                                                  ${priceContent}
                                                   </div>
                                                 <div class="col-12 mb-3 align-self-end">
                                                     <button onclick="addToCart(${product.productID})" class="btn btn-outline-dark" type="button"><i class="fas fa-cart-plus mr-2"></i>Add to cart</button>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>`
    }
    document.getElementById('featuredProducts').innerHTML=productList;

}
function addToCart(productID)
{
    window.location.href = `product.html?id=${productID}`;
}

async function fetchNewArrivalTotalPages()
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/New-Arrival-Total-Pages`,{
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
       newArrivalTotalPages = data;
       populateNewArrivalPagination(newArrivalTotalPages);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populateNewArrivalPagination(totalPages)
{
    if(totalPages==1)
    {
        return;
    }
  let content='<a href="javascript:newArrivalhandlePrev()">Prev</a>';
  for(let i=1;i<=totalPages;i++)
  {
     content+=`<a href="javascript:fetchNewArrivalProducts(${i})" id="newArrivalPage${i}">${i}</a>`;
  }
  content+=`<a href="javascript:newArrivalhandleNext()">Next</a>`;
  newArrivalPagination.innerHTML = content;
}
function newArrivalhandleNext()
{
 newArrivalCurrentPage==newArrivalTotalPages? fetchNewArrivalProducts(1):fetchNewArrivalProducts(newArrivalCurrentPage+1);
}
function newArrivalhandlePrev()
{
  newArrivalCurrentPage==1? fetchNewArrivalProducts(newArrivalTotalPages):fetchNewArrivalProducts(newArrivalCurrentPage-1);
}
async function fetchNewArrivalProducts(pageNumber)
{
    fetchNewArrivalTotalPages();
   newArrivalCurrentPage=pageNumber;
   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/NewArrivalProducts ${pageNumber}`,{
           method: 'GET',
           mode: 'cors',
           headers: {
             'Content-Type': 'application/json'
           }
         });
       if(!response.ok)
       {
           console.log('an error occurd');
           document.getElementById('latestProducts').innerHTML=``;
           document.getElementById('latestProducts').style.display='none';
           newArrivalPagination.style.display='none';
       }
       const data = await response.json();
       await populateNewArrivalProducts(data);
       const activePages = newArrivalPagination.querySelectorAll('.active');

       if(activePages!=null)
       {
         activePages.forEach(page => {
           if(page.classList.contains('active'))
           {
             page.classList.remove('active');
           }
           });
       }
     
       document.getElementById(`newArrivalPage${newArrivalCurrentPage}`).classList.add("active");
       newArrivalPagination.style.display = 'block';
   }
   catch(error)
   {
       console.log(error);
   }
}
async function populateNewArrivalProducts(data)
{
    if(data.length==0)
    {
        document.getElementById('latestProducts').innerHTML=``;
        document.getElementById('latestProducts').style.display = 'none';
        newArrivalPagination.style.display='none';
        return;
    }
    let productList = ` <div class="row">
                                    <div class="col-12 text-center text-uppercase">
                                        <h2>Latest Products</h2>
                                    </div>
                                </div>
                                <div class="row">`;
                                for (const product of data) {
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
                                 productList+=`   <!-- Product -->
                                                                 <div class="col-lg-3 col-sm-6 my-3">
                                                                     <div class="col-12 bg-white text-center h-100 product-item">
                                                                        <span class="new">New</span>
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
                                                                                 <a href="product.html?id=${product.productID}" class="product-name">${product.shortDescription}</a>
                                                                             </div>
                                                                                <div class="col-12 mb-3">
                                                                              ${priceContent}
                                                                               </div>
                                                                             <div class="col-12 mb-3 align-self-end">
                                                                                 <button onclick="addToCart(${product.productID})" class="btn btn-outline-dark" type="button"><i class="fas fa-cart-plus mr-2"></i>Add to cart</button>
                                                                             </div>
                                                                         </div>
                                                                     </div>
                                                                 </div>`
                                }
    productList+=`</div>`;
    document.getElementById('latestProducts').innerHTML=productList;
    document.getElementById('latestProducts').style.display = 'block';
    newArrivalPagination.style.display='block';

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
                                            <a class="nav-link" href="index.html">Home <span class="sr-only">(current)</span></a>
                                        </li>`
        for(let i=0;i<categories.length;i++)
        {
            let subcategorieslist = await fetchSubCategories(categories[i].categoryID);
            let subcategories='';
            for(let j=0;j<subcategorieslist.length;j++)
            {
               subcategories+= `<a class="dropdown-item" href="category.html?subCategoryID=${subcategorieslist[j].subCategoryID}">${subcategorieslist[j].subCategoryName}</a>`
            }
        categoriesNavItems+=`
                                  

                                              <div class="category-dropdown">
                             <button class="category-btn" onclick="handleCategoryClick(${categories[i].categoryID})"> ${categories[i].categoryName} <span class="dropdown-toggle" onclick="toggleSubcategories(event, '${categories[i].categoryID}')"></span> </button> 
                             <div id="${categories[i].categoryID}" class="subcategories collapse"> 
                             ${subcategories}
                             </div>
                             </div>
    `
    }

    categoriesNav.innerHTML = categoriesNavItems;
}
function toggleSubcategories(event, subcategoryId) 
{ 
    event.stopPropagation(); 
    // Prevent the parent button click event 
    const subcategories = document.getElementById(subcategoryId); 
    if (subcategories.classList.contains('show')) 
    { 
        subcategories.classList.remove('show'); 
    } 
    else 
    { 
        subcategories.classList.add('show'); 
    } 
}
async function handleCategoryClick(categoryID) 
{
   window.location.href = `category.html?categoryID=${categoryID}`;
}

async function fetchtopSellingProducts() {
    
    try
    {
     const response = await fetch(`https://localhost:7171/api/ProductCatalog/TopSellingProducts`,{
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
        await populateTopSellingProducts(data);
    }
    catch(error)
    {
        console.log(error);
    }
}

async function populateTopSellingProducts(data)
{
    let productList = '';
    for (const product of data) {
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
     productList+=`   <!-- Product -->
                                     <div class="col-lg-3 col-sm-6 my-3">
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
                                                     <a href="product.html?id=${product.productID}" class="product-name">${product.shortDescription}</a>
                                                 </div>
                                                    <div class="col-12 mb-3">
                                                  ${priceContent}
                                                   </div>
                                                 <div class="col-12 mb-3 align-self-end">
                                                     <button onclick="addToCart(${product.productID})" class="btn btn-outline-dark" type="button"><i class="fas fa-cart-plus mr-2"></i>Add to cart</button>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>`
    }
   document.getElementById('topSellingProducts').innerHTML=productList;
}