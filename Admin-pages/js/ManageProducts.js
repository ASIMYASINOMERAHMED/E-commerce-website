

const currentUser = JSON.parse(localStorage.getItem('currentUser'));
let title = document.getElementById('title');
let price = document.getElementById('price');
let taxes = document.getElementById('taxes');
let ads = document.getElementById('ads');
let discount = document.getElementById('discount');
let total = document.getElementById('total');
let count = document.getElementById('count');
let dropdownCategory = document.getElementById('dropdownCategories');
let dropdownSubcategory = document.getElementById('dropdownSubCategories');
let submit = document.getElementById('submit');
const sizeTagInput = document.getElementById('sizeTagInput');
const addSizeBtn = document.getElementById('addSizeBtn');
const sizeTagsContainer = document.getElementById('sizeTagsContainer');
const colorTagInput = document.getElementById('colorTagInput');
const addColorBtn = document.getElementById('addColorBtn');
const colorTagsContainer = document.getElementById('colorTagsContainer');
const pagination = document.querySelector('.pagination');
const shortDescription = document.getElementById('shortDescription');
const longDescription = document.getElementById('longDescription');
const quantityInStock = document.getElementById('count');
let videoPath='';
let productThumbnail='';
let productColors=[];
let productSize=[];
let Mood = 'create';
let currentPage;
let totalPages;
let updateProductID;
let imageFilesArray = [];
let imageUrls = [];

window.onload=fetchCategoriesInDropDown();
window.onload= fetchProducts(1);

function getQueryParameter(name)
 { 
    const urlParams = (new URL(document.location)).searchParams; 
    return urlParams.get(name);
 } 
window.onload = async function() {
  const searchValue = getQueryParameter('searchValue');
  if(searchValue!=''){
    await SearchByTitle(searchValue);
    scroll({ top: document.body.scrollHeight, behavior: 'smooth' });
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

async function deleteColor(ID) {
  console.log(ID);
  fetch(`https://localhost:7171/api/ProductColor/Delete-Product-Color ${ID}`, {
    method: 'DELETE',
    mode: 'cors'
})
.then(response => console.log(response))
.then(data => {
    console.log(data);
})
.catch((error) => {
    console.error('Error:', error);
}); 
}
 function addColor(color = colorTagInput.value.trim()) {
  console.log(productColors.length);
  const tagValue = color;
  if (tagValue !== '') {//&& !productColors.contains(tagValue)
    const tagElement = document.createElement('div');
    tagElement.textContent = tagValue;
    tagElement.className = 'tag';
    tagElement.addEventListener('click', function() {
        colorTagsContainer.removeChild(tagElement);
        if(productColors.length!=0)
          var index = productColors.indexOf(tagValue);
        if (index !== -1) {
          productColors.splice(index, 1);
        }
    });
    colorTagsContainer.appendChild(tagElement);

    productColors.push(tagValue);
    
    colorTagInput.value = '';
  }
}

async function deleteSize(ID) {
  console.log(ID);
  fetch(`https://localhost:7171/api/ProductSize/Delete-Product-Size ${ID}`, {
    method: 'DELETE',
    mode: 'cors'
})
.then(response => console.log(response))
.then(data => {
    console.log(data);
})
.catch((error) => {
    console.error('Error:', error);
}); 
}
 function addSize(size = sizeTagInput.value.trim()) {
  const tagValue = size;
  if (tagValue !== '' ) {//&& !productSize.contains(tagValue)
    const tagElement = document.createElement('div');
    tagElement.textContent = tagValue;
    tagElement.className = 'tag';
    tagElement.addEventListener('click', function() {
        sizeTagsContainer.removeChild(tagElement);
       if(productSize.length!=0)
       {
            var index = productSize.indexOf(tagValue);
        if (index !== -1) {
          productSize.splice(index, 1);
        }
      }
    });
    sizeTagsContainer.appendChild(tagElement);
 
    productSize.push(tagValue);
  
    sizeTagInput.value = '';
  }
}
  
async function fetchCategoriesInDropDown()
{
  dropdownCategory.innerHTML=`<option value="0">--SELECT CATEGORY--</option>`;
    fetch('https://localhost:7171/api/ProductCategory/All')
    .then(response => response.json())
    .then(data => {
        data.forEach(category => {
            const option = document.createElement('option');
            option.value = category.categoryID;
            option.textContent =category.categoryName;

            dropdownCategory.appendChild(option);
        });
    })
    .catch(error => console.error('Error fetching data:', error));
}

async function fetchSubCategoriesInDropDown(categoryID,subCategoryID=0)
{
dropdownSubcategory.innerHTML=`<option value="0">--SELECT SUBCATEGORY--</option>`;
    fetch(`https://localhost:7171/api/SubCategory/${categoryID}`)
    .then(response => response.json())
    .then(data => {
        data.forEach(subcategory => {
            const option = document.createElement('option');
            option.value = subcategory.subCategoryID;
            option.textContent =subcategory.subCategoryName;

            dropdownSubcategory.appendChild(option);
        });
        dropdownSubcategory.value = subCategoryID;
    })
    .catch(error => console.error('Error fetching data:', error));
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
function getTotal()
{
    if(price.value !='')
    {
      let result
      if(+discount.value==0)
      {
         result = (+price.value + +taxes.value+ +ads.value);
      }
      else
      {
        let originalPrice = (+price.value + +taxes.value+ +ads.value);
        result = calculateDiscountedPrice(originalPrice,+discount.value)
      }
        total.innerHTML = result;
        total.style.background = '#040';
    }
    else
    {
        total.innerHTML = '[???]';
        total.style.background = '#fe0808';
    }
}


async function addProductInfo() {
  await UploadVideo();
  await UploadThumbnail();

  const productInfo = {
      productID: 0,
      productName: title.value,
      shortDescription: shortDescription.value,
      longDescription: longDescription.value,
      price: +price.value,
      quantityInStock: quantityInStock.value,
      categoryID: dropdownCategory.value,
      subCategoryID: dropdownSubcategory.value,
      imageURL: productThumbnail,
      videoURL: videoPath,
      taxes: taxes.value==''?0:taxes.value,
      ads: ads.value==''?0:ads.value,
      discount: discount.value==''?0:discount.value,
      insertByUserID:currentUser.userID
  };

  if (productInfo.productName !== '' && productInfo.quantityInStock >= 1 && productInfo.price !== 0 
      && productInfo.shortDescription !== '' && productInfo.longDescription !== '' 
      && productInfo.categoryID !== 0 && productInfo.subCategoryID !== 0 
      && productInfo.imageURL !== '') {
      try {
          const response = await fetch("https://localhost:7171/api/ProductCatalog/AddProductCatalog", {
              method: "POST",
              mode: 'cors',
              headers: {
                  "Content-Type": "application/json"
              },
              body: JSON.stringify(productInfo)
          });

          if (!response.ok) {
            Swal.fire({
              position: "top-end",
              icon: "error",
              title: "Unable to save product",
              showConfirmButton: false,
              timer: 1500
            });
              throw new Error("Network response was not ok " + response.statusText);
          }

          const data = await response.json();
          console.log("Success:", data);

    
          await uploadProductImages();
          await saveProductImagesInDB(data.productID);
          await uploadProductColors(data.productID);
          await uploadProductSize(data.productID);
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Product has been saved",
            showConfirmButton: false,
            timer: 1500
          });

      } catch (error) {
          console.error("Error:", error);
        }
    }
}
async function updateProduct() {
 
 if(document.getElementById('ProductThumbnail').files.length > 0)
 {
    await UploadThumbnail();
 }
if(document.getElementById('videoFile').files.length > 0)
{ 
   await UploadVideo();
}
  
 
  const productInfo = {
      productID: updateProductID,
      productName: title.value,
      shortDescription: shortDescription.value,
      longDescription: longDescription.value,
      price: Number(total.innerHTML),
      quantityInStock: quantityInStock.value,
      categoryID: dropdownCategory.value,
      subCategoryID: dropdownSubcategory.value,
      imageURL: productThumbnail,
      videoURL: videoPath,
      taxes: taxes.value==''?0:taxes.value,
      ads: ads.value==''?0:ads.value,
      discount: discount.value==''?0:discount.value,
      insertByUserID:currentUser.userID
  };
console.log(productInfo);
  if (productInfo.productName !== '' && productInfo.quantityInStock >= 1 && productInfo.price !== 0 
    && productInfo.shortDescription !== '' && productInfo.longDescription !== '' 
    && productInfo.categoryID !== 0 && productInfo.subCategoryID !== 0 
    && productInfo.imageURL !== '') {
    try {
        const response = await fetch("https://localhost:7171/api/ProductCatalog/UpdateProductCatalog", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(productInfo)
        });

        if (!response.ok) {
          Swal.fire({
            position: "top-end",
            icon: "error",
            title: "Unable to save product",
            showConfirmButton: false,
            timer: 1500
          });
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);

      if(imageFilesArray.length!=0)
      {
        await uploadProductImages();
        await saveProductImagesInDB(data.productID);
      }     
      if(productColors.length!=0)
      {
        await uploadProductColors(data.productID);
      }
      if(productSize.length!=0)
      {
        await uploadProductSize(data.productID);
      }
      Mood = 'create'
      submit.innerHTML = 'Create';
        Swal.fire({
          position: "center",
          icon: "success",
          title: "Product has been updated",
          showConfirmButton: false,
          timer: 1500
        });

    } catch (error) {
        console.error("Error:", error);
      }
  }
    
      
}
submit.onclick = async function(){

    if(Mood==='create')
    {
     await addProductInfo();
     ClearData();
     fetchProducts(currentPage); 
    
    }
    else
    {
      await updateProduct();
      ClearData();
      fetchProducts(currentPage); 
    }
    


}

function ClearData()
{
title.value = '';
price.value ='';
taxes.value = '';
ads.value = '';
discount.value = '';
total.innerHTML = '';
count.value = '';
dropdownCategory.value = 0;
dropdownSubcategory.innerHTML=`<option value="0">--SELECT SUBCATEGORY--</option>`;
dropdownSubcategory.value = 0;
total.innerHTML = '[???]';
total.style.background = '#fe0808';
colorTagInput.value='';
colorTagsContainer.innerHTML='';
sizeTagInput.value = '';
sizeTagsContainer.innerHTML='';
shortDescription.value='';
longDescription.value='';
document.getElementById('imageGrid').innerHTML='';
document.getElementById('videoContainer').innerHTML='';
document.getElementById('thumbnailContainer').innerHTML='';
document.getElementById('thumbnailContainer').value='';
productColors=[];
productSize=[];
imageUrls=[];
imageFilesArray=[];
}




let searchMood = 'Title';
function SearchBy(mood)
{ 
    let search = document.getElementById('search');
    mood!='serchTitle'?search.setAttribute("type", "number"):search.setAttribute("type", "text");
    
    search.focus();
    mood == 'serchTitle'? searchMood = 'Title': searchMood = 'CategoryID';
    search.placeholder = 'search by '+searchMood;
    search.value = '';
}
async function SearchByTitle(value)
{
  try
  {
      const response = await fetch(`https://localhost:7171/api/ProductCatalog/Find-By-Name ${value}`,{
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
      await populateProductsTable(data);
      pagination.style.display = 'none';
  }
  catch(error)
  {
      console.log(error);
  }
}
async function SearchByCategoryID(value)
{
  try
  {
      const response = await fetch(`https://localhost:7171/api/ProductCatalog/CategoryID ${value}`,{
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
      populateProductsTable(data);
      pagination.style.display = 'none';
  }
  catch(error)
  {
      console.log(error);
  }
}
async function Search(value)
{
  value==''? fetchProducts(1): searchMood == 'Title'? await SearchByTitle(value):await SearchByCategoryID(value);
}










async function UploadThumbnail() {
    if(Mood=='update'&&productThumbnail!='')
    {
      DeleteFileDirectory(productThumbnail)
    }
    const fileInput = document.getElementById('ProductThumbnail');
    const imageFile = fileInput.files[0];
    console.log(imageFile);
      if (imageFile == undefined) {
          alert('Please select Product Thumbnail.');
          return;
      }
  
      const formData = new FormData();
      formData.append('imageFile', imageFile);
  
    try {
      const response = await fetch('https://localhost:7171/api/ProductImages/Upload', {
        method: 'POST',
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data.fileName);
        productThumbnail = data.fileName;
      })
      .catch(error => {
        console.error("Error:", error);
      });
    }
    catch (error) {
      console.error('An error occurred:', error);
    }
}

async function addProductColor(color,productID) {
   
  console.log(color);
  fetch("https://localhost:7171/api/ProductColor/AddProductColors", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        productID: productID,
        colors: color,
      })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      console.log("Success:", data);
    })
    .catch(error => {
      console.error("Error:", error);
    });

}
async function addProductSize(size,productID) {

  console.log(size);
      fetch("https://localhost:7171/api/ProductSize/AddProductSize", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            productID: productID,
            size: size,
          })
        })
        .then(response => {
          if (!response.ok) {
            throw new Error("Network response was not ok " + response.statusText);
          }
          return response.json();
        })
        .then(data => {
          console.log("Success:", data);
        })
        .catch(error => {
          console.error("Error:", error);
        });

}

async function uploadProductColors(productID) {
  if (productColors.length === 0) {
      alert('Please select at least one Color.');
      return;
  }

  for (const color of productColors) {
      await addProductColor(color,productID);
  }

  // Clear the array after saving all colors
  productColors = [];

}
async function uploadProductSize(productID) {
  if (productSize.length === 0) {
      alert('Please select at least one Size.');
      return;
  }

  for (const size of productSize) {
      await addProductSize(size,productID);
  }

  // Clear the array after saving all colors
  productSize = [];

}


async function uploadImage(imageFile) {
  const formData = new FormData();
  formData.append('imageFile', imageFile);

  try {
      const response = await fetch('https://localhost:7171/api/ProductImages/Upload', {
          method: 'POST',
          body: formData
      });

      if (response.ok) {
          const data = await response.json();
          console.log("Success:", data.fileName);
          imageUrls.push(data.fileName);
      }
      else
      {
          console.error('Error uploading image:', response.statusText);
      }
  } catch (error) {
      console.error('An error occurred:', error);
  }
}

async function uploadProductImages() {
  if (imageFilesArray.length === 0) {
      alert('Please select at least one image.');
      return;
  }

  for (const imageFile of imageFilesArray) {
      await uploadImage(imageFile);
  }

  // Clear the array after uploading all images
  imageFilesArray = [];

}
async function saveProductImagesInDB(productID) {
  if (imageUrls.length === 0) {
      alert('Please select at least one image.');
      return;
  }

  for(let i = 0;i < imageUrls.length;i++)
  {
     SaveImageInDB(imageUrls[i],i,productID);
  }

  // Clear the array after saving all images
  imageUrls = [];

}
async function SaveImageInDB(imageUrl,imageOrder,productID)
{

        fetch("https://localhost:7171/api/ProductImages/AddProductImage", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              imageUrl: imageUrl,
              productID: productID,
              imageOrder: imageOrder,
            })
          })
          .then(response => {
            if (!response.ok) {
              throw new Error("Network response was not ok " + response.statusText);
            }
            return response.json();
          })
          .then(data => {
            console.log("Success:", data);
          })
          .catch(error => {
            console.error("Error:", error);
          });

}


document.getElementById('ProductThumbnail').addEventListener('change', function() {
  const files = Array.from(this.files);

  files.forEach(file => {
    const reader = new FileReader();
    reader.onload = function(e) {
      const imageUrl = e.target.result;
    
      displayThumbnail(imageUrl);
    };
    reader.readAsDataURL(file);
  });
});


function displayThumbnail(imageUrl)
{
  document.getElementById('thumbnailContainer').innerHTML='';

  const imageContainer = document.createElement('div');
  imageContainer.classList.add('image-container');

  const img = document.createElement('img');
  img.src = imageUrl;

  imageContainer.appendChild(img);

  document.getElementById('thumbnailContainer').appendChild(imageContainer);
}

function storeImageFiles() {
  const fileInput = document.getElementById('ProductImages');
  const files = fileInput.files; // Get the files from the input

  for (const file of files) {
      imageFilesArray.push(file); // Store each file in the array
  }
  console.log(imageFilesArray);

  fileInput.value = ''; // Reset the input so the same files can be selected again if needed
}

document.getElementById('ProductImages').addEventListener('change', function() {

    const files = Array.from(this.files);
  
    files.forEach(file => {
      const reader = new FileReader();
      reader.onload = function(e) {
        const imageUrl = e.target.result;
        displayImage(imageUrl);
      };
      reader.readAsDataURL(file);
    });
    storeImageFiles();
  });
  async function DeleteFileDirectory(fileName) {
    fetch(`https://localhost:7171/api/ProductImages/DeleteMedia/${fileName}`, {
      method: 'DELETE',
      mode: 'cors'
  })
  .then(response => console.log(response))
  .then(data => {
      console.log(data);
  })
  .catch((error) => {
      console.error('Error:', error);
  }); 
  }
 async function DeleteImage(fileName,ID) {
  await DeleteFileDirectory(fileName);
  fetch(`https://localhost:7171/api/ProductImages/Delete-Product-Images ${ID}`, {
    method: 'DELETE',
    mode: 'cors'
})
.then(response => console.log(response))
.then(data => {
    console.log(data);
})
.catch((error) => {
    console.error('Error:', error);
}); 
 }

   function displayImage(imageUrl,ID=null,fileName) {
    const imageContainer = document.createElement('div');
    imageContainer.classList.add('image-container');
  
    const img = document.createElement('img');
    img.src = imageUrl;
  
    const deleteBtn = document.createElement('button');
    deleteBtn.classList.add('delete-btn');
    deleteBtn.textContent = 'X';
    deleteBtn.addEventListener('click',async function() {
      imageContainer.remove();
      await DeleteImage(fileName,ID);
        
    });
  
    imageContainer.appendChild(img);
    imageContainer.appendChild(deleteBtn);
  
    document.getElementById('imageGrid').appendChild(imageContainer);
  }

async function UploadVideo()
{
    const videoInput = document.getElementById('videoFile');
    const videoFile = videoInput.files[0]; // Get the file from the input

    if (!videoFile) {
        console.error('No video file selected.');
        return;
    }


    const formData = new FormData();
    formData.append('videoFile', videoFile);

    try {
        const response = await fetch('https://localhost:7171/api/ProductCatalog/Video', {
            method: 'POST',
            body: formData
        });

        if (response.ok) {
            const data = await response.json();
            console.log('Video uploaded successfully. File path:', data.filePath);
            videoPath = data.filePath;
        } else {
            console.error('Error uploading video:', response.statusText);
        }
    } catch (error) {
        console.error('An error occurred:', error);
    }

}

document.getElementById('videoFile').addEventListener('change', function() {
    const files = Array.from(this.files);
  
    files.forEach(file => {
      const reader = new FileReader();
      reader.onload = function(e) {
        const VideoUrl = e.target.result;
        displayVideo(VideoUrl);
      };
      reader.readAsDataURL(file);
    });
  });
  
  function displayVideo(VideoUrl) {
    const videoContainer = document.createElement('div');
    videoContainer.classList.add('video-container');
  
    const video = document.createElement('video');
    video.src = VideoUrl;

    video.controls = true;
    video.width = 640;
    video.height = 360;

    const deleteBtn = document.createElement('button');
    deleteBtn.classList.add('delete-btn');
    deleteBtn.textContent = 'X';
    deleteBtn.addEventListener('click', function() {
      videoContainer.remove();
      document.getElementById('videoFile').value='';
    });
  
    videoContainer.appendChild(video);
    videoContainer.appendChild(deleteBtn);
  
    document.getElementById('videoContainer').appendChild(videoContainer);
  }


  async function fetchProducts(pageNumber)
 {
    fetchTotalPages();
    currentPage=pageNumber;
    try
    {
        const response = await fetch(`https://localhost:7171/api/ProductCatalog/Page-View${pageNumber}`,{
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
        await populateProductsTable(data);
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
async function populateProductsTable(data)
{
const tbody = document.getElementById('tbody');
tbody.innerHTML='';
data.forEach(product => {
    const row = document.createElement('tr');
    row.innerHTML = `
        <td>${product.productID}</td>
        <td>${product.productName}</td>
        <td>${product.price}</td>
        <td>${product.discount}</td>
        <td>${product.quantityInStock}</td>
        <td>${product.category}</td>
        <td>${product.subCategory}</td>
        <td><button onclick = "EditProduct(${product.productID})" id="Edit" class ="tableButton mx-2"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
        <td><button onclick = "DeleteProduct(${product.productID})" id="Delete" class ="tableButton mx-2"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
    `;
    tbody.appendChild(row);
});
}
async function DeleteProduct(productID) {
  Swal.fire({
    title: "Are you sure?",
    text: "You won't be able to revert this!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, delete it!",
    customClass: {
      confirmButton: 'confirm-button-class',
      cancelButton: "cancel-button-class"
    },
    buttonsStyling: false,
  }).then((result) => {
    if (result.isConfirmed) {
      fetch(`https://localhost:7171/api/ProductCatalog/Delete-Product ${productID}`, {
        method: 'DELETE',
    })
    .then(response => console.log(response))
    .then(data => {
        console.log(data);
        fetchProducts(currentPage);
        Swal.fire({
          title: "Deleted!",
          text: "Product has been deleted.",
          icon: "success"
        });
    })
    .catch((error) => {
        console.error('Error:', error);
    });
    
    }
  });
 
}
function displayProductColors(data)
{
  document.getElementById('colorTagsContainer').innerHTML='';
  for(let i=0;i<data.length;i++)
  {
      const tagValue = data[i].colors;
    if (tagValue !== '') 
      {
      const tagElement = document.createElement('div');
      tagElement.textContent = tagValue;
      tagElement.className = 'tag';
      tagElement.addEventListener('click', function() {
          colorTagsContainer.removeChild(tagElement);
            deleteColor(data[i].colorsID);
          
      });
      colorTagsContainer.appendChild(tagElement);

    }
  }
}
async function fetchProductColors(productID)
{
  fetch(`https://localhost:7171/api/ProductColor/${productID}`, {
    method: 'GET',
    headers: {
        'Content-Type': 'application/json'
    }
})
.then(response => response.json())
.then(data => {console.log(data)
  displayProductColors(data);
})
.catch((error) => {
    console.error('Error:', error);
});
 
}

function displayProductSize(data)
{
  document.getElementById('sizeTagsContainer').innerHTML='';
  for(let i=0;i<data.length;i++)
  {
    const tagValue = data[i].size;
    if (tagValue !== '' )
      {
        const tagElement = document.createElement('div');
        tagElement.textContent = tagValue;
        tagElement.className = 'tag';
        tagElement.addEventListener('click', function() {
            sizeTagsContainer.removeChild(tagElement);
            deleteSize(data[i].sizeID); 
        });
        sizeTagsContainer.appendChild(tagElement);
      }
  }
}
async function fetchProductSize(productID)
{
  fetch(`https://localhost:7171/api/ProductSize/${productID}`, {
    method: 'GET',
    headers: {
        'Content-Type': 'application/json'
    }
})
.then(response => response.json())
.then(data => {console.log(data)
  displayProductSize(data);
})
.catch((error) => {
    console.error('Error:', error);
});
 
}


function displayProductImages(data)
{
  document.getElementById('imageGrid').innerHTML='';
   for(let i=0;i<data.length;i++)
   {
    fetch(`https://localhost:7171/api/ProductImages/GetImage/${data[i].imageUrl}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Image not found.');
        }
        return response.blob();
    })
    .then(blob => {
        const imageUrl = URL.createObjectURL(blob);
        displayImage(imageUrl,data[i].id,data[i].imageUrl);
    })
    .catch((error) => {
        console.error('Error:', error);
    });
   }
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
      displayThumbnail(imageUrl);
  })
  .catch((error) => {
      console.error('Error:', error);
  });
 
}
async function EditProduct(productID)
{

    try
    {
        const Response = await fetch(`https://localhost:7171/api/ProductCatalog/ProductID ${productID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
   
        if(!Response.ok)
        {
           console.log('Unable to fetch product.');
        }
        
        const product = await Response.json();

        title.value = product.productName;
        price.value = product.price;
        taxes.value = product.taxes;
        ads.value = product.ads;
        if(product.discount==''||product.discount==null)
          discount.value = 0;
        else
          discount.value=product.discount;
        getTotal();
        count.value = product.quantityInStock;
        dropdownCategory.value = product.categoryID;
        await fetchSubCategoriesInDropDown(product.categoryID,product.subCategoryID);
        shortDescription.value = product.shortDescription;
        longDescription.value = product.longDescription;
        await getProductImages(productID);
        await fetchProductColors(productID);
        await fetchProductSize(productID);
        await getThumbnail(product.imageURL);
        productThumbnail = product.imageURL;
        videoPath = product.videoURL;
        updateProductID = productID;
        submit.innerHTML = 'Update'   
        Mood = 'update';
        scroll({top:0 , behavior: 'smooth'});
    }
    catch(error)
    {
        console.log(error);
    }
  
  
}





