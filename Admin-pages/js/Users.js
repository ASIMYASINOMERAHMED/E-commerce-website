
let nameInput = document.getElementById('name');
let phone = document.getElementById('phone');
let email = document.getElementById('email');
let username = document.getElementById('username');
let password = document.getElementById('password');
let address = document.getElementById('address');
const tbody = document.getElementById('tbody');
let Mood = 'create';
let updatedUserID;
let userImage=null;

window.onload = fetchUsers();

async function fetchUsers()
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/User/All-Users`,{
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
       populateUsersTable(data);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populateUsersTable(data)
{
tbody.innerHTML='';
data.forEach(user => {
   const row = document.createElement('tr');
   row.innerHTML = `
       <td>${user.userID}</td>
       <td>${user.name}</td>
        <td>${user.email}</td>
         <td>${user.phone}</td>
         <td>${user.address}</td>
          <td>${user.userName}</td>
       <td><button onclick = "EditUser(${user.userID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
       <td><button onclick = "DeleteUser(${user.userID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
   `;
   tbody.appendChild(row);
});

}
async function DeleteUser(userID) {
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
        customClass: {
          confirmButton: "confirm-button-class",
          cancelButton: "cancel-button-class"
        },
        buttonsStyling: false,
      }).then((result) => {
        if (result.isConfirmed) {
          fetch(`https://localhost:7171/api/User/Delete-User ${userID}`, {
            method: 'DELETE',
        })
        .then(response => console.log(response))
        .then(data => {
            console.log(data);
            fetchUsers();
            Swal.fire({
                position: "center",
                icon: "success",
                title: "User has been Deleted",
                showConfirmButton: false,
                timer: 1500
              });
        })
        .catch((error) => {
            console.error('Error:', error);
        });
        
        }
      });
}
function clear()
{
    document.getElementById('imageContainer').innerHTML='';
    userImage = null;
    nameInput.value ='';
    phone.value = '';
    email.value = '';
    username.value = '';
    address.value='';
    password.value = '';
    password.style.display = 'block';
    Mood='create';
    submit.innerHTML='Add';
}
document.getElementById('userImage').addEventListener('change', function() {
    const files = Array.from(this.files);
  
    files.forEach(file => {
      const reader = new FileReader();
      reader.onload = function(e) {
        const imageUrl = e.target.result;
        displayUserImage(imageUrl);
      };
      reader.readAsDataURL(file);
    });
  });

function displayUserImage(imageUrl)
{
    document.getElementById('imageContainer').innerHTML='';

    const imageContainer = document.createElement('div');
    imageContainer.classList.add('image-container');
  
    const img = document.createElement('img');
    img.src = imageUrl;
  
    imageContainer.appendChild(img);
  
    document.getElementById('imageContainer').appendChild(imageContainer);
}
async function getUserImage(fileName) {
    fetch(`https://localhost:7171/api/ProductImages/GetImage/${fileName}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Image not found.');
        }
        return response.blob();
    })
    .then(blob => {
        const imageUrl = URL.createObjectURL(blob);
        displayUserImage(imageUrl);
    })
    .catch((error) => {
        console.error('Error:', error);
    });
   
  }
async function EditUser(userID) {
    updatedUserID = userID;
    try
    {
        const Response = await fetch(`https://localhost:7171/api/User/UserID ${userID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
   
        if(!Response.ok)
        {
           console.log('Unable to fetch user.');
        }
        
        const user = await Response.json();
        nameInput.value = user.name;
        phone.value = user.phone;
        email.value = user.email;
        address.value = user.address;
        username.value = user.userName;
        getUserImage(user.imageURL)
        password.style.display = 'none';
        submit.innerHTML = 'Update';
        Mood = 'update';
        scroll({top:0 , behavior: 'smooth'});
        userImage = user.imageURL;
    }
    catch(error)
    {
        console.log(error);
    }
}
async function addUser()
{
    let userName = document.getElementById('username').value;
    let userExists = await checkUserExist(userName);
    if(!userExists)
    { 
     uploadImage();

            fetch("https://localhost:7171/api/User/AddUser", {
                method: "POST",
                mode: 'cors',
                headers: {
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    name: nameInput.value,
                    email: email.value,
                    phone: phone.value,
                    address: address.value,
                    userName: username.value,
                    password: password.value,
                    imageURL: userImage,
                    permissions:1
                })
              })
              .then(response => {
                if (!response.ok) {
                    Swal.fire({
                        position: "center",
                        icon: "error",
                        title: "Unable to save User",
                        showConfirmButton: false,
                        timer: 1500
                      });
                  throw new Error("Network response was not ok " + response.statusText);
                }
                return response.json();
              })
              .then(data => {
                console.log("Success:", data);
                fetchUsers();
                clear();
                Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "User has been saved",
                    showConfirmButton: false,
                    timer: 1500
                  });
              })
              .catch(error => {
                console.error("Error:", error);
              });
            }
      
}
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

  async function uploadImage() {

    const fileInput = document.getElementById('userImage');
    const imageFile = fileInput.files[0];
    console.log(imageFile);
      if (imageFile == undefined) {
  
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
          Swal.fire({
            position: "center",
            icon: "error",
            title: "Unable to upload Image",
            showConfirmButton: false,
            timer: 1500
          });
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data.fileName);
        userImage = data.fileName;
      })
      .catch(error => {
        console.error("Error:", error);
      });
    }
    catch (error) {
      console.error('An error occurred:', error);
    }
}

async function updateUser()
{
    if(document.getElementById('userImage').files.length > 0 && userImage!=null)
    {
       await DeleteFileDirectory(userImage);
       await uploadImage();
    }
    
    fetch('https://localhost:7171/api/User/Update-User', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            userID:updatedUserID,
            name: nameInput.value,
            email: email.value,
            phone: phone.value,
            address: address.value,
            userName: username.value,
            password: '',
            imageURL: userImage,
            permissions:1
        })
    })
    .then(response => {
    
        if (!response.ok) {
            throw new Error("Network response was not ok " + response.statusText);
            Swal.fire({
                position: "center",
                icon: "error",
                title: "Unable to update user",
                showConfirmButton: false,
                timer: 1500
              });
      }
      return response.json();
    })
    .then(data => {
      console.log("Success:", data);
      fetchUsers();
      clear();
      Swal.fire({
        position: "center",
        icon: "success",
        title: "user has been updated",
        showConfirmButton: false,
        timer: 1500
      });
    })
    .catch(error => {
      console.error("Error:", error);
    });
}
async function checkUserExist(username)
{
    fetch(`https://localhost:7171/api/User/Check-User-Exist?UserName=${username}`)
    .then(response => response.json())
    .then(data => {
        if (data === true) {
            Swal.fire({
                position: "center",
                icon: "error",
                title: `User with userName ${username} already exists!`,
                showConfirmButton: false,
                timer: 1500
              });
              return true;
            }
            else
            {
                return false;
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}
submit.onclick = function(){

  
      Mood==='create'?  addUser(): updateUser();  
   
      
  }

  let searchMood = 'UserName';
function SearchBy(mood)
{ 
    let search = document.getElementById('search');
  
    mood!='serchUserName'?search.setAttribute("type", "number"):search.setAttribute("type", "text");
    search.focus();
    mood == 'serchID'? searchMood = 'ID': searchMood = 'UserName';
    search.placeholder = 'search by '+searchMood;
    search.value = '';
}
async function SearchByID(value)
{
  try
  {
      const response = await fetch(`https://localhost:7171/api/User/UserID ${value}`,{
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
      tbody.innerHTML='';
         const row = document.createElement('tr');
         row.innerHTML = `
             <td>${data.userID}</td>
             <td>${data.name}</td>
              <td>${data.phone}</td>
               <td>${data.email}</td>
               <td>${data.address}</td>
                <td>${data.userName}</td>
             <td><button onclick = "EditUser(${data.userID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
             <td><button onclick = "DeleteUser(${data.userID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
         `;
         tbody.appendChild(row);
      
  }
  catch(error)
  {
      console.log(error);
  }
}
async function SearchByUserName(value)
{
  try
  {
      const response = await fetch(`https://localhost:7171/api/User/UserName ${value}`,{
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
      tbody.innerHTML='';
      const row = document.createElement('tr');
      row.innerHTML = `
       <td>${data.userID}</td>
             <td>${data.name}</td>
              <td>${data.phone}</td>
               <td>${data.email}</td>
               <td>${data.address}</td>
                <td>${data.userName}</td>
             <td><button onclick = "EditUser(${data.userID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
             <td><button onclick = "DeleteUser(${data.userID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
   `;
   tbody.appendChild(row);

  }
  catch(error)
  {
      console.log(error);
  }
}
async function Search(value)
{
  value==''? fetchUsers(): searchMood == 'ID'? await SearchByID(value):await SearchByUserName(value);
}
