const categoriesNav = document.getElementById('mainNav');
const sidebar = document.getElementById('sidebar');
const openSidebarBtn = document.getElementById('openSidebarBtn'); 
const closeSidebarBtn = document.getElementById('closeSidebarBtn'); 
const overlay = document.getElementById('overlay'); 
const productsContainer = document.getElementById('productsContainer');
const pagination = document.querySelector('.pagination');
let categoryID;
let subCategoryID;
let currentPageForCategoryID;
let currentPageForSubCategoryID
let totalPagesSubCategoryID;
let totalPagesCategoryID;
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
const btnSend = document.getElementById('sendMessage');
const message = document.getElementById('message');
window.onload = displayCartQtyAndPrice();

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
window.onload = fetchCategories();
window.onload = displayProducts()
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

sidebar.addEventListener('transitionend', function(event) 
{ 
   if (!sidebar.classList.contains('open')) 
   { 
           openSidebarBtn.classList.remove('hide'); // Show the open button after transition 
   }
});

async function fetchTotalPagesForCategoryID(categoryID)
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCatalog/Total-Pages-For-CategoryID?CategoryID=${categoryID}`,{
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
       totalPagesCategoryID = data;
       populatePaginationForCategoryID(totalPagesCategoryID);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populatePaginationForCategoryID(totalPages)
{
  let content='<a href="javascript:handlePrevForCategoryID()">Prev</a>';
  for(let i=1;i<=totalPages;i++)
  {
     content+=`<a href="javascript:fetchProductsForCategoryID(${categoryID},${i})" id="categoryPage${i}">${i}</a>`;
  }
  content+=`<a href="javascript:handleNextForCategoryID()">Next</a>`;
  pagination.innerHTML = content;
}
function handleNextForCategoryID()
{
    currentPageForCategoryID==totalPagesCategoryID? fetchProductsForCategoryID(categoryID,1):fetchProductsForCategoryID(categoryID,currentPageForCategoryID+1);
}
function handlePrevForCategoryID()
{
    currentPageForCategoryID==1? fetchProductsForCategoryID(categoryID,totalPagesCategoryID):fetchProductsForCategoryID(categoryID,currentPageForCategoryID-1);
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
                             <button class="category-btn" onclick="handleCategoryClick('${categories[i].categoryID}')"> ${categories[i].categoryName} <span class="dropdown-toggle" onclick="toggleSubcategories(event, '${categories[i].categoryID}')"></span> </button> 
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



 async function displayProducts() 
 { 
    categoryID = parseInt(getQueryParameter('categoryID'),10);

    if (isNaN(categoryID)||categoryID<=0)
    {    
         subCategoryID = parseInt(getQueryParameter('subCategoryID'),10); 
        if (isNaN(subCategoryID)||subCategoryID<=0)
        {
            console.error('Invalid ID');
            document.getElementById('title').innerHTML = '<h2>--Not Found--</h2>';
            document.getElementById('productsContainer').innerHTML = '';
            return;
        }
        else
        {
            console.log('subcategory ID:', subCategoryID);
            fetchProductsForSubCategoryID(subCategoryID,1);
        }
       
  
    }
    else
    {
       console.log('category ID:', categoryID);
       fetchProductsForCategoryID(categoryID,1);
    }
}
async function fetchProductsForCategoryID(categoryID,pageNumber) {
    fetchTotalPagesForCategoryID(categoryID);
    currentPageForCategoryID = pageNumber;
    try
    {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/Page ${pageNumber}/CategoryID ${categoryID}`,{
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
      
        document.getElementById(`categoryPage${currentPageForCategoryID}`).classList.add("active");
        pagination.style.display = 'block';
    }
    catch(error)
    {
        console.log(error);
    }  
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
async function getCategory(categoryID) {
    fetch(`https://localhost:7171/api/ProductCategory/CategoryID ${categoryID}`) 
    .then(response => { 
       if (!response.ok) 
        { 
            throw new Error('Network response was not ok ' + response.statusText);
        } 
         return response.json();
     }) 
     .then(data => { 
        document.getElementById('title').innerHTML = `<h2>${data.categoryName}</h2>`;
        getCategoryImage(data.categoryImage);
     }) 
     .catch(error => { 
        console.error('There has been a problem with your fetch operation:', error); 
     });
}
async function getSubCategoryTitle(subCategoryID) {
    fetch(`https://localhost:7171/api/SubCategory/SubCategoryID ${subCategoryID}`) 
    .then(response => { 
       if (!response.ok) 
        { 
            throw new Error('Network response was not ok ' + response.statusText);
        } 
         return response.json();
     }) 
     .then(data => { 
        document.getElementById('title').innerHTML = `<h2>${data.subCategoryName}</h2>`;
        document.getElementById('categoryImage').style.display='none';
     }) 
     .catch(error => { 
        console.error('There has been a problem with your fetch operation:', error); 
     });
}
async function getCategoryImage(categoryImage) {
    fetch(`https://localhost:7171/api/ProductImages/GetImage/${categoryImage}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Image not found.');
        }
        return response.blob();
    })
    .then(blob => {
        const imageUrl = URL.createObjectURL(blob);
        displayCategoryImage(imageUrl);
    })
    .catch((error) => {
        console.error('Error:', error);
    });
  }
function displayCategoryImage(imageUrl)
{
    const categoryImageDiv = document.getElementById('categoryImage'); 
    const imgElement = document.createElement('img'); 
    imgElement.src = imageUrl; 
    imgElement.alt = 'Category Banner'; 
    imgElement.className = 'img-fluid'; 
    imgElement.style.width = '100%'; 
    imgElement.style.height = '100%'; 
    imgElement.style.borderRadius = '1rem';
    categoryImageDiv.appendChild(imgElement);
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
    productsContainer.innerHTML = productList;
    categoryID>=1?getCategory(categoryID):getSubCategoryTitle(subCategoryID);
}
function addToCart(productID)
{
    window.location.href = `product.html?id=${productID}`;
}