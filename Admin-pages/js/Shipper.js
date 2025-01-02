let DarkMode;
const toggleCheck = document.getElementById('toggleCheck');
const sideBar = document.getElementById('accordionSidebar');
const mainContent = document.getElementById('content');
const heading = document.getElementById('pageHeading'); 
const topBar = document.getElementById('topBar');
const shippingTable = document.getElementById('shippingsTable');
const carrierId =parseInt(getQueryParameter('carrierID'), 10);
let shipperInfo=""

const pickr = Pickr.create({
    el: '.color-picker',
    theme: 'classic', // or 'monolith', or 'nano'

    swatches: [
        'rgba(244, 67, 54, 1)',
        'rgba(233, 30, 99, 0.95)',
        'rgba(156, 39, 176, 0.9)',
        'rgba(103, 58, 183, 0.85)',
        'rgba(63, 81, 181, 0.8)',
        'rgba(33, 150, 243, 0.75)',
        'rgba(3, 169, 244, 0.7)',
        'rgba(0, 188, 212, 0.7)',
        'rgba(0, 150, 136, 0.75)',
        'rgba(76, 175, 80, 0.8)',
        'rgba(139, 195, 74, 0.85)',
        'rgba(205, 220, 57, 0.9)',
        'rgba(255, 235, 59, 0.95)',
        'rgba(255, 193, 7, 1)'
    ],

    components: {

        // Main components
        preview: true,
        opacity: true,
        hue: true,

        // Input / output Options
        interaction: {
            hex: true,
            rgba: true,
            hsla: true,
            hsva: true,
            cmyk: true,
            input: true,
            clear: true,
            save: true
        }
    }
});
pickr.on('change', (color, source, instance) => {
    const rgbaColor = color.toRGBA().toString();
    sideBar.style.background = rgbaColor;
    topBar.style.background = rgbaColor;
});
window.onload =switchMode();
function switchMode()
{
    
       DarkMode = toggleCheck.checked;
       localStorage.setItem('DarkMode',  DarkMode);

   
   

    console.log(DarkMode);
    if(DarkMode)
    {
        sideBar.style.background = '#18191A';
        topBar.style.background = '#242526';
        mainContent.style.background = '#2b2a2a';
        mainContent.style.color = '#FFFFFF';
        heading.style.color = '#FFFFFF';
        if(shippingTable!=null)
        {
            shippingTable.style.color = '#FFFFFF';
            shippingTable.style.background = '#2b2a2a'
        }
    }
    else
    {
        sideBar.style.background = "#4E73DF"; 
        topBar.style.background = '#FFFFFF';
        mainContent.style.background = '#F8F9FC';
        mainContent.style.color = '#5A5C69';
        heading.style.color = '#5A5C69';
        if(shippingTable!=null)
            shippingTable.style.color = '#5A5C69';

    }
  
}


window.onload = getShippingOrders(carrierId);
window.onload = fetchShipperInfo();


openSettings=()=>{
    document.getElementById('settings').click();
  }
  function getQueryParameter(name)
 { 
    const urlParams = (new URL(document.location)).searchParams; 
    return urlParams.get(name);
 }
async function fetchShipperInfo()
{

    if (isNaN(carrierId))
         { 
          console.error('Invalid carrier ID');
          return;
         } 
    try
    {
        const Response = await fetch(`https://localhost:7171/api/Shippers/ ${carrierId}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!Response.ok)
        {
           console.log('Unable to fetch Info.');
        }
        shipperInfo = await Response.json();
         const lbUser = document.querySelector('#userDropdown span');
         lbUser.textContent = shipperInfo.carrierName;
    
    }
    catch(error)
    {
        console.log(error);
    }
}
async function populateShipperInfo(mood='view') {
    const profileContainer = document.getElementById('profileContainer');

    if (mood === 'view') {
        profileContainer.innerHTML = `
        <h4 class="text-secondary">
         <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
        Shipper Info</h4>  
        <p class="text-secondary">CarrierID: &nbsp;&nbsp;&nbsp;${shipperInfo.carrierID}</p>
        <p class="text-secondary">CarrierName: &nbsp;&nbsp;&nbsp;${shipperInfo.carrierName}</p>
        <p class="text-secondary">Email: &nbsp;&nbsp;&nbsp;${shipperInfo.email}</p>
        <p class="text-secondary">Phone: &nbsp;&nbsp;&nbsp;${shipperInfo.phone}</p>
        <p class="text-secondary">UserName: &nbsp;&nbsp;&nbsp;${shipperInfo.userName}</p>
        <hr/>
          <div  class="d-flex justify-content-end">
        <button onClick="closeProfileInfo()" class="btn btn-primary" id="closeBtn">Close</button>
        </div>
    `;

    profileContainer.showModal();
    closeProfileInfo=()=>{
       profileContainer.close();
    }
    } else {
        profileContainer.innerHTML = `
    <h4 class="text-secondary">
        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
        Edit Info
    </h4>  
    <p class="mb-2"><strong>CarrierID:</strong> ${shipperInfo.carrierID}</p>
    <label for="shipper-name" class="text-secondary">Name:</label>
    <input type="text" class="form-control mb-2" value="${shipperInfo.carrierName}" id="shipper-name" placeholder="Name">
    <label for="shipper-email" class="text-secondary">Email:</label>
    <input type="text" class="form-control mb-2" value="${shipperInfo.email}" id="shipper-email" placeholder="Email">
    <label for="shipper-phone" class="text-secondary">Phone:</label>
    <input type="text" class="form-control mb-2" value="${shipperInfo.phone}" id="shipper-phone" placeholder="Phone">
    <label for="userName" class="text-secondary">Username:</label>
    <input type="text" class="form-control mb-2" value="${shipperInfo.userName}" id="userName" placeholder="Username">
    <label for="shipper-password" class="text-secondary">Password:</label>
    <input type="password" class="form-control mb-2" id="shipper-password" placeholder="Password">
    <label for="confirm-password" class="text-secondary">Confirm Password:</label>
    <input type="password" class="form-control mb-2" id="confirm-password" placeholder="Confirm Password">
    <hr/>
    <div class="d-flex justify-content-end">
        <button onClick="closeProfileInfo()" class="btn btn-danger" id="closeBtn">Close</button>
        <button onClick="updateUserInfo()" class="btn btn-primary" id="updateBtn">Update</button>
    </div>
`;


        profileContainer.showModal();
        closeProfileInfo = () => {
            profileContainer.close();
        }
        
        updateUserInfo = () => {
            if(document.getElementById('shipper-password').value!=document.getElementById('confirm-password').value)
            {
                alert('Password does not match.');
                return;
            }
            fetch('https://localhost:7171/api/Shippers/UpdateCarrier', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                carrierID:shipperInfo.carrierID,
                carrierName: document.getElementById('shipper-name').value,
                email: document.getElementById('shipper-email').value,
                phone: document.getElementById('shipper-phone').value,
                userName: document.getElementById('userName').value,
                password: document.getElementById('shipper-password').value,
                insertByUserID:0
            })
        })
        .then(response => {
        if (!response.ok) {
            alert('Unable to update information 🙁.');
            throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
        })
        .then(data => {
        console.log("Success:", data);
        alert('Updated Successfully😊.');
        fetchShipperInfo();
        profileContainer.close();
        })
        .catch(error => {
        console.error("Error:", error);
        });

        }
    }
}


function showManageShippings(pageHeading,hasRecords)
{
    const lbUser = document.querySelector('#userDropdown span');
   if(hasRecords)
   {
            document.getElementById('mainContent').innerHTML=`<h1 class="h3 mb-1" id="pageHeading">${pageHeading}</h1>
                    
                    <p class="mb-4">Your journey with us makes all the difference! Thank you for being an essential link in our delivery chain. 🚚✨ Safe travels ${lbUser.textContent}</p>

                <div class = "container mt-5" id ="shippingContainer" style="overflow-x:auto ;">
                          <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Shipping Table</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                     
                            <table class="table table-bordered" width="100%" cellspacing="0" id = "shippingsTable">
                                <thead>
                                    <tr>
                                         <th class="text-center" scope="col" id="Col1">ShippingID</th>
                                         <th class="text-center" scope="col" id="Col2">OrderID</th>
                                         <th class="text-center" scope="col" id="Col3">Customer</th>
                                         <th class="text-center" scope="col" id="Col4">TrackingNumber</th>
                                         <th class="text-center" scope="col" id="Col5">ShippingStatus</th>
                                         <th class="text-center" scope="col" id="Col6">EstimatedDeliveryDate</th>
                                         <th class="text-center" scope="col" id="Col7">actualDeliveryDate</th>
                                         <th class="text-center" scope="col" id="detailsCol">Details</th>
                          
                                            <dialog class="details-container">
                                            
                                            
                                            </dialog>
                                    
                                        <th class="text-center" scope="col" id="actionCol">Action</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th class="text-center" scope="col">ShippingID</th>
                                        <th class="text-center" scope="col">OrderID</th>
                                        <th class="text-center" scope="col">Customer</th>
                                        <th class="text-center" scope="col">TrackingNumber</th>
                                        <th class="text-center" scope="col">ShippingStatus</th>
                                        <th class="text-center" scope="col">EstimatedDeliveryDate</th>
                                        <th class="text-center" scope="col">actualDeliveryDate</th>
                                        <th class="text-center" scope="col">Details</th>
                                        <th class="text-center" scope="col" id="actionColfoot">Action</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                 
                                    
                                </tbody>
                            </table>

                            </div>   
                        </div>  
                    </div>  
                    </div>  
                 `
   }
   else
   {
    document.getElementById('mainContent').innerHTML=`<h1 class="h3 mb-1" id="pageHeading">${pageHeading}</h1>
                    
    <p class="mb-4">Your journey with us makes all the difference! Thank you for being an essential link in our delivery chain. 🚚✨ Safe travels ${lbUser.textContent}</p>


        <div class = "container mt-5" id ="shippingContainer" style="overflow-x:auto ;">
            <p class="text-center primary">--No ${pageHeading}--</p>
        </div>
        `
   }
  
}

async function getShippingOrders(carrierID)
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Shipping/All-Shippings${carrierID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            console.log('an error occurd');
            showManageShippings('Shippings Orders',false);
        }
        else
        {
            const data = await response.json();
            populateShippingsOrders(data);
        }
    }
    catch(error)
    {
        console.log(error);
    }
}

function populateShippingsOrders(data)
{
    showManageShippings('Shippings Orders',true);
    const tableBody = document.querySelector('#shippingsTable tbody');
    tableBody.innerHTML = ''; // Clear any existing rows
    data.forEach(shipping => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${shipping.shippingID}</td>
            <td>${shipping.orderID}</td>
            <td>${shipping.customerName}</td>
            <td>${shipping.trackingNumber}</td>
            <td>${shipping.shippingStatus}</td>
            <td>${shipping.estimatedDeliveryDate}</td>
            <td>${shipping.actualDeliveryDate}</td>
            <td><button onclick = "fetchOrderDetails(${shipping.orderID})" class ="tableButton">Details</button></td> 
            <td>
            <div class="button-wrapper"> 
                <button onclick="deliverOrder(${shipping.shippingID})" class="tableButton" id="deliverBtn"><i class="bi bi-check-circle-fill"></i>&nbsp;Deliver</button>
                <button onclick="cancelOrder(${shipping.shippingID})" class="tableButton" id="cancelBtn"><i class="bi bi-x-circle-fill"></i>&nbsp;Cancel</button>
            </div>
          </td>
        `;
        tableBody.appendChild(row);
    });
    document.getElementById('actionCol').style.display = "block";
    document.getElementById('actionColfoot').style.display = "block";
    shippingTable.style.display = "table";  
}
async function cancelOrder(shippingID)
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Shipping/Cancel-Order?ShippingID=${shippingID}`,{
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
        else
        {
            const data = await response.json();
            console.log(data);
            getShippingOrders(carrierId);
        }
    }
    catch(error)
    {
        console.log(error);
    }
}
async function deliverOrder(shippingID)
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Shipping/Deliver-Order?ShippingID=${shippingID}`,{
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
        else
        {
            const data = await response.json();
            console.log(data);
            getShippingOrders(carrierId);
        }
    }
    catch(error)
    {
        console.log(error);
    }
}
async function getDeliverdOrders()
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Shipping/Delivered-Shippings${carrierId}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            console.log('an error occurd');
            showManageShippings('Deliverd Orders',false);
        }
        else
        {
            const data = await response.json();
            populateDeliverdOrders(data);
        }
    }
    catch(error)
    {
        console.log(error);
    }
}

function populateDeliverdOrders(data)
{
    showManageShippings('Deliverd Orders',true);
    const tableBody = document.querySelector('#shippingsTable tbody');
    tableBody.innerHTML = ''; // Clear any existing rows
    data.forEach(shipping => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${shipping.shippingID}</td>
            <td>${shipping.orderID}</td>
            <td>${shipping.customerName}</td>
            <td>${shipping.trackingNumber}</td>
            <td>${shipping.shippingStatus}</td>
            <td>${shipping.estimatedDeliveryDate}</td>
            <td>${shipping.actualDeliveryDate}</td>
            <td><button onclick = "fetchOrderDetails(${shipping.orderID})" class ="tableButton">Details</button></td> 

        `;
        tableBody.appendChild(row);
    });
    document.getElementById('actionCol').style.display = "none";
    document.getElementById('actionColfoot').style.display = "none";
    shippingTable.style.display = "table";  
}

async function fetchOrderDetails(orderID)
{
    try
    {
        const orderDetailsResponse = await fetch(`https://localhost:7171/api/Order/OrderID ${orderID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        const orderItemsResponse = await fetch(`https://localhost:7171/api/OrderItem/OrderID ${orderID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!orderDetailsResponse.ok||!orderItemsResponse.ok)
        {
           console.log('Unable to fetch order details.');
        }
        const orderDetails = await orderDetailsResponse.json();
        const orderItems = await orderItemsResponse.json();
        populateOrderDetails(orderDetails,orderItems);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateOrderDetails(orderDetails , orderItems)
{
    const detailsContainer = document.querySelector('.details-container');
    
       let table = '';
       for(let i = 0; i < orderItems.length; i++)
       {
        table += `
        
        <tr class="text-center">
            <td scope="row">${orderItems[i].productName}</td>
            <td>${orderItems[i].quantity}</td>
            <td>${orderItems[i].price}</td>
        </tr>
`
       }
        // Populate order details in the details container
        detailsContainer.innerHTML = `
            <h4 class="text-secondary">Order Details</h4>
            <p class="text-secondary">Order ID: &nbsp;&nbsp;&nbsp;${orderDetails.orderID}</p>
            <p class="text-secondary">Customer Name: &nbsp;&nbsp;&nbsp;${orderDetails.name}</p>
            <p class="text-secondary">Email: &nbsp;&nbsp;&nbsp;${orderDetails.email}</p>
            <p class="text-secondary">Phone: &nbsp;&nbsp;&nbsp;${orderDetails.phone}</p>
            <p class="text-secondary">Delivery Adress: &nbsp;&nbsp;&nbsp;${orderDetails.address}</p>
            <p class="text-secondary">Order Date: &nbsp;&nbsp;&nbsp;${orderDetails.orderDate}</p>
            <p class="text-secondary">Total Amount: &nbsp;&nbsp;&nbsp;${orderDetails.totalAmount}</p>
            <p class="text-secondary">Status: &nbsp;&nbsp;&nbsp;${orderDetails.orderStatus}</p>
            <hr/>
            <h4 class="text-secondary">Order Items</h4>
            <div class="container">
            <table class="table table-bordered">
                <tr class="text-center">
                <th scope="col">Product Name</th>
                <th scope="col">Quantity</th>
                <th scope="col">Price</th>
                </tr>
            ${table}
              </table>
              </div>
              <div  class="d-flex justify-content-end">
            <button onClick="closeDetails()" class="btn btn-primary" id="closeBtn">Close</button>
            </div>
        `;
        detailsContainer.showModal();
        closeDetails=()=>{
            detailsContainer.close();
        }
 
}
