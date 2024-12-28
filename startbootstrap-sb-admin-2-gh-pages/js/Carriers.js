
let carrierName = document.getElementById('name');
let phone = document.getElementById('phone');
let email = document.getElementById('email');
let username = document.getElementById('username');
let password = document.getElementById('password');
const tbody = document.getElementById('tbody');
let Mood = 'create';
let updatedCarrierID;

window.onload = fetchCarriers();

async function fetchCarriers()
{

   try
   {
       const response = await fetch(`https://localhost:7171/api/Shippers/All`,{
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
       populateCarriersTable(data);
   }
   catch(error)
   {
       console.log(error);
   }
}
function populateCarriersTable(data)
{
tbody.innerHTML='';
data.forEach(carrier => {
   const row = document.createElement('tr');
   row.innerHTML = `
       <td>${carrier.carrierID}</td>
       <td>${carrier.carrierName}</td>
        <td>${carrier.phone}</td>
         <td>${carrier.email}</td>
          <td>${carrier.userName}</td>
       <td><button onclick = "EditCarrier(${carrier.carrierID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
       <td><button onclick = "DeleteCarrier(${carrier.carrierID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
   `;
   tbody.appendChild(row);
});

}
async function DeleteCarrier(carrierID) {
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
          fetch(`https://localhost:7171/api/Shippers/Delete-Carrier ${carrierID}`, {
            method: 'DELETE',
        })
        .then(response => console.log(response))
        .then(data => {
            console.log(data);
            fetchCarriers();
            Swal.fire({
                position: "center",
                icon: "success",
                title: "Carrier has been Deleted",
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
    document.getElementById('name').value ='';
    document.getElementById('phone').value = '';
    document.getElementById('email').value = '';
    document.getElementById('username').value = '';
    document.getElementById('password').style.display = 'block';
    document.getElementById('password').value='';
    Mood='create';
    submit.innerHTML='Add';
}

async function EditCarrier(carrierID) {
    updatedCarrierID = carrierID;
    try
    {
        const Response = await fetch(`https://localhost:7171/api/Shippers/ ${carrierID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
   
        if(!Response.ok)
        {
           console.log('Unable to fetch carrier.');
        }
        
        const carrier = await Response.json();
        document.getElementById('name').value = carrier.carrierName;
        document.getElementById('phone').value = carrier.phone;
        document.getElementById('email').value = carrier.email;
        document.getElementById('username').value = carrier.userName;
        document.getElementById('password').style.display = 'none';
        submit.innerHTML = 'Update';
        Mood = 'update';
        scroll({top:0 , behavior: 'smooth'});
    }
    catch(error)
    {
        console.log(error);
    }
}
async function addCarrier()
{
  const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    fetch("https://localhost:7171/api/Shippers/AddCarrier", {
        method: "POST",
        mode: 'cors',
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
            carrierName: carrierName.value,
            email: email.value,
            phone: phone.value,
            userName: username.value,
            password: password.value,
            insertByUserID:currentUser.userID
        })
      })
      .then(response => {
        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to save Carrier",
                showConfirmButton: false,
                timer: 1500
              });
          throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data);
        fetchCarriers();
        clear();
        Swal.fire({
            position: "center",
            icon: "success",
            title: "Carrier has been saved",
            showConfirmButton: false,
            timer: 1500
          });
      })
      .catch(error => {
        console.error("Error:", error);
      });
}
async function updateCarrier()
{
    fetch('https://localhost:7171/api/Shippers/UpdateCarrier', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            carrierID:updatedCarrierID,
            carrierName: carrierName.value,
            email: email.value,
            phone: phone.value,
            userName: username.value,
            password: ''
        })
    })
    .then(response => {
      if (!response.ok) {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "Unable to update Carrier",
            showConfirmButton: false,
            timer: 1500
          });
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      console.log("Success:", data);
      fetchCarriers();
      clear();
      Swal.fire({
        position: "center",
        icon: "success",
        title: "Carrier has been updated",
        showConfirmButton: false,
        timer: 1500
      });
    })
    .catch(error => {
      console.error("Error:", error);
    });
}
submit.onclick = function(){

   let userName = document.getElementById('username').value;
        if(Mood==='create')
          {
            fetch(`https://localhost:7171/api/Shippers/Check-Shipper-Exist?UserName=${userName}`)
            .then(response => response.json())
            .then(data => {
                if (data === true) {
                    Swal.fire({
                        position: "center",
                        icon: "error",
                        title: `carrier with userName ${userName} already exists!`,
                        showConfirmButton: false,
                        timer: 1500
                      });
                    return;
                }
                else
                {
                  addCarrier();
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
          }
          else
          {
             updateCarrier();
          }
  }

  let searchMood = 'Name';
function SearchBy(mood)
{ 
    let search = document.getElementById('search');
    search.focus();
    mood == 'searchName'? searchMood = 'Name': searchMood = 'UserName';
    search.placeholder = 'search by '+searchMood;
    search.value = '';
}
async function SearchByName(value)
{
  try
  {
      const response = await fetch(`https://localhost:7171/api/Shippers/CarrierName ${value}`,{
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
             <td>${data.carrierID}</td>
             <td>${data.carrierName}</td>
              <td>${data.phone}</td>
               <td>${data.email}</td>
                <td>${data.userName}</td>
             <td><button onclick = "EditCarrier(${data.carrierID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
             <td><button onclick = "DeleteCarrier(${data.carrierID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
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
      const response = await fetch(`https://localhost:7171/api/Shippers/UserName ${value}`,{
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
       <td>${data.carrierID}</td>
       <td>${data.carrierName}</td>
        <td>${data.phone}</td>
         <td>${data.email}</td>
          <td>${data.userName}</td>
       <td><button onclick = "EditCarrier(${data.carrierID})" class ="tableButton"><i class="bi bi-pencil-square"></i> &nbsp; Edit</button></td> 
       <td><button onclick = "DeleteCarrier(${data.carrierID})" class ="tableButton"><i class="bi bi-trash3-fill"></i> &nbsp; Delete</button></td>
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
  value==''? fetchCarriers(): searchMood == 'searchName'? await SearchByName(value):await SearchByUserName(value);
}
