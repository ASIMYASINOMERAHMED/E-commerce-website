const submit = document.getElementById('submit');
const currentUser = JSON.parse(localStorage.getItem('currentUser'));
let categoryID;

let Mood = 'create';

window.onload = fetchCategories();


async function fetchCategories()
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/ProductCategory/All`,{
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
       populateCategoriesTable(data);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populateCategoriesTable(data)
{
const tbody = document.getElementById('tbody');
tbody.innerHTML='';
data.forEach(category => {
   const row = document.createElement('tr');
   row.innerHTML = `
       <td>${category.categoryID}</td>
       <td>${category.categoryName}</td>
              <td><button onclick = "fetchSubCategories(${category.categoryID})" class ="tableButton"><i class="bi bi-bookmarks-fill"></i> &nbsp; SubCategories</button></td> 
       <td><button onclick = "EditCategory(${category.categoryID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
       <td><button onclick = "DeleteCategory(${category.categoryID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
   `;
   tbody.appendChild(row);
});

}

async function EditCategory(CategoryID) {
categoryID = CategoryID;
  try
  {
      const Response = await fetch(`https://localhost:7171/api/ProductCategory/CategoryID ${categoryID}`,{
          method: 'GET',
          mode: 'cors',
          headers: {
            'Content-Type': 'application/json'
          }
        });
 
      if(!Response.ok)
      {
         console.log('Unable to fetch category.');
      }
      
      const category = await Response.json();
      document.getElementById('categoryName').value = category.categoryName;
      getCategoryImage(category.categoryImage);
      submit.innerHTML = 'Update';
      Mood = 'update';
      scroll({top:0 , behavior: 'smooth'});
      document.getElementById('categoryImage').click();
  }
  catch(error)
  {
      console.log(error);
  }
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
async function DeleteCategory(categoryID) {
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
  fetch(`https://localhost:7171/api/ProductCategory/Delete-Category ${categoryID}`, {
    method: 'DELETE',
})
.then(response => console.log(response))
.then(data => {
    console.log(data);
    fetchCategories();
    clear();
    Swal.fire({
      title: "Deleted!",
      text: "Category has been deleted.",
      icon: "success"
    });
})
.catch((error) => {
    console.error('Error:', error);
});
}
});

}
async function fetchSubCategories(CategoryID)
{
    categoryID = CategoryID;
    try
    {
        const Response = await fetch(`https://localhost:7171/api/SubCategory/${categoryID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
   
        if(!Response.ok)
        {
           console.log('Unable to fetch subcategories.');
           populateSubCategories('');
        }
        
        const subcategories = await Response.json();
        populateSubCategories(subcategories);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateSubCategories(subcategories)
{
  const subcategoriesContainer = document.querySelector('.subCategories-container');
  if(subcategories!='')
  {
    
       let table = '';
       for(let i = 0; i < subcategories.length; i++)
       {
        table += `
        
        <tr class="text-center">
            <td scope="row">${subcategories[i].subCategoryID}</td>
            <td>${subcategories[i].subCategoryName}</td>
            <td><button onclick = "deleteSubCategory(${subcategories[i].subCategoryID})" class ="tableButton">Delete</button></td> 
        </tr>
`
       }
        // Populate subCategories in the subcategories container
        subcategoriesContainer.innerHTML = `
            <h4 class="text-secondary">Subcategories:</h4>
                 <div class="subcategoryInput">
                <input type="text" id="subCategoryInput" placeholder="Add SubCategory">
                <button onclick="addSubCategory()" id="addSubCategoryBtn">+</button>
              </div>
            <hr/>
            <div class="container">
            <table class="table table-bordered">
                <tr class="text-center">
                <th scope="col">SubCategoryID</th>
                <th scope="col">Title</th>
                <th scope="col">Delete</th>
                </tr>
            ${table}
              </table>
              </div>
              <div  class="d-flex justify-content-end">
            <button onClick="closeDetails()" class="btn-primary" id="closeBtn">Close</button>
            </div>
        `;
        subcategoriesContainer.showModal();
        closeDetails=()=>{
            subcategoriesContainer.close();
        }
      }
      else
      {
        subcategoriesContainer.innerHTML = `
        <h4 class="text-secondary">Subcategories:</h4>
             <div class="subcategoryInput">
            <input type="text" id="subCategoryInput" placeholder="Add SubCategory">
            <button onclick="addSubCategory()" id="addSubCategoryBtn">+</button>
          </div>
        <hr/>
          <p class="text-center primary">--No SubCategories--</p>
          <div  class="d-flex justify-content-end">
        <button onClick="closeDetails()" class="btn-primary" id="closeBtn">Close</button>
        </div>
    `;
    subcategoriesContainer.showModal();
    closeDetails=()=>{
        subcategoriesContainer.close();
    }
      }
 
}

async function deleteSubCategory(subCategoryID) {
  fetch(`https://localhost:7171/api/SubCategory/Delete-SubCategory ${subCategoryID}`, {
      method: 'DELETE',
  })
  .then(response => console.log(response))
  .then(data => {
      console.log(data);
      fetchSubCategories(categoryID);
  })
  .catch((error) => {
      console.error('Error:', error);
  });
}
async function addSubCategory() 
{
    const subcategoryName = document.getElementById('subCategoryInput').value;
    fetch(`https://localhost:7171/api/SubCategory/Check-SubCategory-Exist?SubCategoryName=${subcategoryName}`)
        .then(response => response.json())
        .then(data => {
            if (data === true) {
                alert('SubCategory already exists!');
            }
            else
            {
              fetch("https://localhost:7171/api/SubCategory/AddProductSubCategory", {
                method: "POST",
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                  subCategoryName: subcategoryName,
                  categoryID: categoryID,
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
                fetchSubCategories(categoryID);
                document.getElementById('subCategoryInput').value='';
              })
              .catch(error => {
                console.error("Error:", error);
              });
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
   
}

document.getElementById('categoryImage').addEventListener('change', function() {
  const files = Array.from(this.files);

  files.forEach(file => {
    const reader = new FileReader();
    reader.onload = function(e) {
      const imageUrl = e.target.result;
      displayCategoryImage(imageUrl);
    };
    reader.readAsDataURL(file);
  });
});
function displayCategoryImage(imageUrl)
{
    document.getElementById('imageContainer').innerHTML='';
    const imgContainer = document.createElement('div');
    imgContainer.classList.add('image-container');
    const img = document.createElement('img');
    img.src = imageUrl;


    const deleteBtn = document.createElement('button');
    deleteBtn.classList.add('delete-btn');
    deleteBtn.textContent = 'X';
    deleteBtn.addEventListener('click', function() {
      imgContainer.remove();
      document.getElementById('categoryImage').value='';
    });
  
    imgContainer.appendChild(img);
    imgContainer.appendChild(deleteBtn);
  
    document.getElementById('imageContainer').appendChild(imgContainer);
  
}

async function updateCategory(title)
{
  const fileInput = document.getElementById('categoryImage');
  const imageFile = fileInput.files[0];
  console.log(imageFile);
    if (imageFile == undefined) {
      Swal.fire({
        position: "center",
        icon: "warning",
        title: "Please select Category Image",
        showConfirmButton: false,
        timer: 1500
      });
        return;
    }

    const formData = new FormData();
    formData.append('imageFile', imageFile);

    try {
      const response = await fetch('https://localhost:7171/api/ProductImages/Upload', {
        method: 'POST',
        body: formData
      });
  
      if (response.ok)
     {
        const data = await response.json();
        fetch('https://localhost:7171/api/ProductCategory/UpdateProductCategory', {
          method: 'PUT',
          headers: {
              'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            categoryID:categoryID,
            categoryName: title,
            categoryImage: data.fileName,
            insertByUserID:currentUser.userID
          })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("Network response was not ok " + response.statusText);
          Swal.fire({
            position: "center",
            icon: "error",
            title: "Unable to update Category",
            showConfirmButton: false,
            timer: 1500
          });
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data);
        fetchCategories();
        clear();
        Swal.fire({
          position: "center",
          icon: "success",
          title: "Category has been updated",
          showConfirmButton: false,
          timer: 1500
        });
      })
      .catch(error => {
        console.error("Error:", error);
      });
      }
      else 
      {
        console.error('Error uploading Image:', response.statusText);
      }
    } catch (error) {
      console.error('An error occurred:', error);
    }
}
async function addCategory(title)
{
  const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  const fileInput = document.getElementById('categoryImage');
  const imageFile = fileInput.files[0];
  console.log(imageFile);
    if (imageFile == undefined) {
      Swal.fire({
        position: "center",
        icon: "warning",
        title: "Please select Category Image",
        showConfirmButton: false,
        timer: 1500
      });
        return;
    }

    const formData = new FormData();
    formData.append('imageFile', imageFile);

    try {
      const response = await fetch('https://localhost:7171/api/ProductImages/Upload', {
        method: 'POST',
        body: formData
      });
  
      if (response.ok)
     {
        const data = await response.json();
        fetch("https://localhost:7171/api/ProductCategory/AddProductCategory", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            categoryName: title,
            categoryImage: data.fileName,
            insertByUserID:currentUser.userID
          })
        })
        .then(response => {
          if (!response.ok) {
            Swal.fire({
              position: "center",
              icon: "error",
              title: "Unable to save Category",
              showConfirmButton: false,
              timer: 1500
            });
            throw new Error("Network response was not ok " + response.statusText);
          }
          return response.json();
        })
        .then(data => {
          console.log("Success:", data);
          fetchCategories();
          clear();
          Swal.fire({
            position: "center",
            icon: "success",
            title: "Category has been saved",
            showConfirmButton: false,
            timer: 1500
          });
        })
        .catch(error => {
          console.error("Error:", error);
        });
      }
      else 
      {
        console.error('Error uploading Image:', response.statusText);
      }
    } catch (error) {
      console.error('An error occurred:', error);
    }
}

function clear()
{
  document.getElementById('categoryName').value='';
  document.getElementById('categoryImage').value='';
  document.getElementById('imageContainer').innerHTML='';
  Mood='create';
  submit.innerHTML='Add';
}

submit.onclick = function(){

  const categoryName = document.getElementById('categoryName').value;
  if(categoryName=='')
  {
    Swal.fire({
      position: "center",
      icon: "warning",
      title: "Please select Category Name",
      showConfirmButton: false,
      timer: 1500
    });
    return;
  }
 
      if(Mood==='create')
        {
          fetch(`https://localhost:7171/api/ProductCategory/Check-Category-Exist?CategoryName=${categoryName}`)
          .then(response => response.json())
          .then(data => {
              if (data === true) {
                Swal.fire({
                  position: "center",
                  icon: "error",
                  title: "Category already exists!",
                  showConfirmButton: false,
                  timer: 1500
                });
                  return;
              }
              else
              {
                addCategory(categoryName);
              }
          })
          .catch((error) => {
              console.error('Error:', error);
          });
        }
        else
        {
           updateCategory(categoryName);
        }
}