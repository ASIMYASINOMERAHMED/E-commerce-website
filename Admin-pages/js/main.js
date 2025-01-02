
const toggleCheck = document.getElementById('toggleCheck');
const sideBar = document.getElementById('accordionSidebar');
const mainContent = document.getElementById('content');
const heading = document.getElementById('pageHeading');
const topBar = document.getElementById('topBar');
const ordersTable = document.getElementById('ordersTable');
const messagesContainer = document.getElementById('messagesContainer');
const notificationsContainer = document.getElementById('notificationContainer');
const messagesDropdown = document.getElementById('messagesDropdown');
const messagesNum = document.querySelector('#messagesDropdown span');
const notificationsNum = document.querySelector('#alertsDropdown span');
const container = document.getElementById('ordersContainer');
const searchBar = document.getElementById('searchBar');
const btnSearch = document.getElementById('btnSearch');

let messagesList;
let notificationsList;
let messages="";
let notifications="";
let userInfo=""

window.onload = showDashboard();
window.onload = fetchMessages();
window.onload = fetchNotfications();
window.onload = fetchUserInfo();

btnSearch.onclick=function()
{
    if(searchBar.value=='')
        return;
    showManageProducts(searchBar.value);
}
async function fetchMessages()
{
    try
    {
        const messagesResponse = await fetch(`https://localhost:7171/api/Messages/All`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!messagesResponse.ok)
        {
           console.log('Unable to fetch Messages.');
        }
        messages = await messagesResponse.json();
        messagesNum.textContent = `${messages.length}`;

    }
    catch(error)
    {
        console.log(error);
    }
}
function displayMessages()
{
    messagesList = ` 
    <h6 class="dropdown-header">
        Message Center
    </h6>`;
    for(let i=0;i<messages.length;i++)
    {
       
        messagesList +=`      <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">${messages[i].message}.</div>
                                        <div class="small text-gray-500">${messages[i].customerName} · ${messages[i].dateTime}</div>
                                    </div>
                                </a>`
    }
    messagesContainer.innerHTML=`${messagesList}`;

}








async function fetchNotfications()
{
    try
    {
        const notificationsResponse = await fetch(`https://localhost:7171/api/OwnerNotification/All`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!notificationsResponse.ok)
        {
           console.log('Unable to fetch Notifications.');
        }
        notifications = await notificationsResponse.json();
        notificationsNum.textContent = `${notifications.length}`;

    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchCustomerInfo(customerID)
{
    try
    {
        const Response = await fetch(`https://localhost:7171/api/User/UserID ${customerID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!Response.ok)
        {
           console.log('Unable to fetch Customer Info.');
        }
        let customerInfo = await Response.json();

        return customerInfo.name;
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchPayment(paymentID)
{
    try
    {
        const Response = await fetch(`https://localhost:7171/api/Payment/${paymentID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!Response.ok)
        {
           console.log('Unable to fetch Payment.');
        }
        let payment = await Response.json();

        return payment.paymentMethod;
    }
    catch(error)
    {
        console.log(error);
    }
}
 function displayNotifications()
{
    notificationsList = ` 
    <h6 class="dropdown-header">
       Alerts Center
    </h6>`;
    let notificationType='';
    for(let i=0;i<notifications.length;i++)
    {
       if(notifications[i].newCustomerID!=null)
       {
             notificationType = 'New Visitor';
             notificationsList +=`        <a class="dropdown-item d-flex align-items-center" href="#">
             <div class="mr-3">
                 <div class="icon-circle bg-success">
                     <i class="fas fa-exclamation-triangle text-white"></i>
                 </div>
             </div>
             <div>
                 <div class="small text-gray-500">${notifications[i].dateTime}</div>
                 <span class="font-weight-bold">${notificationType}</span>
             </div>
         </a>`
       }
       else
       {
            notificationType = 'New Order';
            notificationsList +=`        <a class="dropdown-item d-flex align-items-center" href="#">
            <div class="mr-3">
                <div class="icon-circle bg-primary">
                    <i class="fas fa-file-alt text-white"></i>
                </div>
            </div>
            <div>
                <div class="small text-gray-500">${notifications[i].dateTime}</div>
                <span class="font-weight-bold">${notificationType}</span>
            </div>
        </a>`
       }
      
    }
    notificationsContainer.innerHTML=`${notificationsList}`;

}
let DarkMode;

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
        if(ordersTable!=null)
            ordersTable.style.color = '#FFFFFF';
    }
    else
    {
        sideBar.style.background = "#4E73DF"; 
        topBar.style.background = '#FFFFFF';
        mainContent.style.background = '#F8F9FC';
        mainContent.style.color = '#5A5C69';
        heading.style.color = '#5A5C69';
        if(ordersTable!=null)
            ordersTable.style.color = '#5A5C69';
    }
  
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
            <td>${orderItems[i].totalItemsPrice}</td>
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
                <th scope="col">Total Items Price</th>
                </tr>
            ${table}
              </table>
              </div>
              <div  class="d-flex justify-content-end">
            <button onClick="closeDetails()" class="btn btn-secondary" id="closeBtn">Close</button>
            </div>
        `;
        detailsContainer.showModal();
        closeDetails=()=>{
            detailsContainer.close();
        }
 
}

function getQueryParameter(name)
 { 
    const urlParams = (new URL(document.location)).searchParams; 
    return urlParams.get(name);
 } 
async function fetchUserInfo()
{
    const userId = parseInt(getQueryParameter('userId'), 10);
    console.log(userId);
    if (isNaN(userId))
         { 
          console.error('Invalid user ID');
          return;
         } 
    try
    {
        const Response = await fetch(`https://localhost:7171/api/User/UserID ${userId}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });

        if(!Response.ok)
        {
           console.log('Unable to fetch User Info.');
        }
         userInfo = await Response.json();
         const lbUser = document.querySelector('#userDropdown span');
         lbUser.textContent = userInfo.name;
    
    }
    catch(error)
    {
        console.log(error);
    }
}



async function populateUserInfo(mood='view') {
    const profileContainer = document.getElementById('profileContainer');

    if (mood === 'view') {
        profileContainer.innerHTML = `
            <h4 class="text-secondary">
                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                User Info
            </h4>  
            <p class="text-secondary">UserID: &nbsp;&nbsp;&nbsp;${userInfo.userID}</p>
            <p class="text-secondary">Name: &nbsp;&nbsp;&nbsp;${userInfo.name}</p>
            <p class="text-secondary">Email: &nbsp;&nbsp;&nbsp;${userInfo.email}</p>
            <p class="text-secondary">Phone: &nbsp;&nbsp;&nbsp;${userInfo.phone}</p>
            <p class="text-secondary">Address: &nbsp;&nbsp;&nbsp;${userInfo.address}</p>
            <p class="text-secondary">UserName: &nbsp;&nbsp;&nbsp;${userInfo.userName}</p>
            <hr/>
            <div class="d-flex justify-content-end">
                <button onClick="closeProfileInfo()" class="btn-primary" id="closeBtn">Close</button>
            </div>
        `;

        profileContainer.showModal();
        closeProfileInfo = () => {
            profileContainer.close();
        }
    } else {
        profileContainer.innerHTML = `
    <h4 class="text-secondary">
        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
        Edit User Info
    </h4>  
    <p class="mb-2"><strong>UserID:</strong> ${userInfo.userID}</p>
    <label for="user-name" class="text-secondary">Name:</label>
    <input type="text" class="form-control mb-2" value="${userInfo.name}" id="user-name" placeholder="Name">
    <label for="user-email" class="text-secondary">Email:</label>
    <input type="text" class="form-control mb-2" value="${userInfo.email}" id="user-email" placeholder="Email">
    <label for="user-phone" class="text-secondary">Phone:</label>
    <input type="text" class="form-control mb-2" value="${userInfo.phone}" id="user-phone" placeholder="Phone">
    <label for="user-address" class="text-secondary">Address:</label>
    <input type="text" class="form-control mb-2" value="${userInfo.address}" id="user-address" placeholder="Address">
    <label for="userName" class="text-secondary">Username:</label>
    <input type="text" class="form-control mb-2" value="${userInfo.userName}" id="userName" placeholder="Username">
    <label for="user-password" class="text-secondary">Password:</label>
    <input type="password" class="form-control mb-2" id="user-password" placeholder="Password">
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
            if(document.getElementById('user-password').value!=document.getElementById('confirm-password').value)
            {
                alert('Password does not match.');
                return;
            }
            fetch('https://localhost:7171/api/User/Update-User', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                userID:userInfo.userID,
                name: document.getElementById('user-name').value,
                email: document.getElementById('user-email').value,
                phone: document.getElementById('user-phone').value,
                address: document.getElementById('user-address').value,
                userName: document.getElementById('userName').value,
                password: document.getElementById('user-password').value,
                imageURL: null,
                permissions:-1
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
        fetchUserInfo();
        profileContainer.close();
        })
        .catch(error => {
        console.error("Error:", error);
        });

        }
    }
}


openSettings=()=>{
  document.getElementById('settings').click();
}




async function fetchShippingOrders()
 {
    try
    {
        const response = await fetch('https://localhost:7171/api/Shipping/All',{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            showManageOrders('Shipping Orders',false);
        }
        const data = await response.json();
        populateShippingOrdersTable(data);
    }
    catch(error)
    {
        console.log(error);
    }
}

function populateShippingOrdersTable(data)
{
    showManageOrders('Shipping Orders',true);
    const tableBody = document.querySelector('#ordersTable tbody');
    const actionCol = document.getElementById('actionCol').style.display = 'none';
    const Col1 = document.getElementById('Col1').textContent = 'ShippingID';
    const Col2 = document.getElementById('Col2').textContent = 'OrderID';
    const Col3 = document.getElementById('Col3').textContent = 'Customer';
    const Col4 = document.getElementById('Col4').textContent = 'Carrier';
    const Col5 = document.getElementById('Col5').textContent = 'Tracking.No';
    const Col6 = document.getElementById('Col6').textContent = 'Status';
    const Col7 = document.getElementById('Col7').textContent = 'Estimated Date';
    const Col8 = document.getElementById('Col8').textContent = 'Actual Date';
    const detailsCol = document.getElementById('detailsCol').setAttribute("colspan","2");
    tableBody.innerHTML = ''; // Clear any existing rows

    data.forEach(shipping => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${shipping.shippingID}</td>
            <td>${shipping.orderID}</td>
            <td>${shipping.customerName}</td>
            <td>${shipping.carrierName}</td>
            <td>${shipping.trackingNumber}</td>
            <td>${shipping.shippingStatus}</td>
            <td>${shipping.estimatedDeliveryDate}</td>
            <td>${shipping.actualDeliveryDate}</td>
              <td colspan="2"><button onclick = "fetchOrderDetails(${shipping.orderID})" class ="tableButton">Details</button></td> 
        `;
        tableBody.appendChild(row);
    });
    
}



async function fetchAllOrders()
 {

    try 
    {
        const response = await fetch('https://localhost:7171/api/Order/All',{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            showManageOrders('All Orders',false);

        }
        const data = await response.json();
        populateAllOrdersTable(data);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateAllOrdersTable(data)
{
    showManageOrders('All Orders',true);
    const tableBody = document.querySelector('#ordersTable tbody');

    tableBody.innerHTML = ''; // Clear any existing rows
    setTableStructure(false);

    data.forEach(Order => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${Order.orderID}</td>
            <td>${Order.name}</td>
            <td>${Order.email}</td>
            <td>${Order.phone}</td>
            <td>${Order.address}</td>
            <td>${Order.orderDate}</td>
            <td>${Order.totalAmount}</td>
            <td>${Order.orderStatus}</td>
             <td><button onclick = "fetchOrderDetails(${Order.orderID})" class ="tableButton">Details</button></td> 
        `;
        tableBody.appendChild(row);
    });
    document.getElementById('actionCol').style.display='none';
    document.getElementById('tfActionCol').style.display='none';

}

async function fetchPendingOrders()
 {

    try 
    {
        const response = await fetch('https://localhost:7171/api/Order/Pending-Orders',{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            showManageOrders('Pending Orders',false);

        }
        const data = await response.json();
        populatePendingOrdersTable(data);
    }
    catch(error)
    {
        console.log(error);
    }
}
function setTableStructure(showActionCol=true)
{
    if(showActionCol){
         document.getElementById('actionCol').style.display = 'block';
         document.getElementById('tfActionCol').style.display='block';
    }
    else{
         document.getElementById('actionCol').style.display = 'none';
         document.getElementById('tfActionCol').style.display='none';
    }     
    const Col1 = document.getElementById('Col1').textContent = 'OrderID';
    const Col2 = document.getElementById('Col5').textContent = 'Address';
    const Col6 = document.getElementById('Col6').textContent = 'OrderDate';
    const Col7 = document.getElementById('Col2').textContent = 'Name';
    const Col3 = document.getElementById('Col3').textContent = 'Email';
    const Col4 = document.getElementById('Col4').textContent = 'Phone';
    const Col5 = document.getElementById('Col7').textContent = 'TotalAmount';
    const Col8 = document.getElementById('Col8').textContent = 'Status';

}
function populatePendingOrdersTable(data)
{
    showManageOrders('Pending Orders',true);
    const tableBody = document.querySelector('#ordersTable tbody');
    tableBody.innerHTML = ''; // Clear any existing rows
    setTableStructure();

    data.forEach(Order => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${Order.orderID}</td>
            <td>${Order.name}</td>
            <td>${Order.email}</td>
            <td>${Order.phone}</td>
            <td>${Order.address}</td>
            <td>${Order.orderDate}</td>
            <td>${Order.totalAmount}</td>
            <td>${Order.orderStatus}</td>
             <td><button onclick = "fetchOrderDetails(${Order.orderID})" class ="tableButton">Details</button></td> 
            <td><button onclick = "processOrder(${Order.orderID})" class ="tableButton">Processing</button></td>
        `;
        tableBody.appendChild(row);
    });
}

async function processOrder(orderID) {
    try 
    {
        const Response = await fetch(`https://localhost:7171/api/Order/ProcessOrder${orderID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!Response.ok)
        {
           console.log('Unable to process order.');
           return;
        }
        const data = await Response.json();
        console.log(data);
        await fetchPendingOrders();
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchProcessingOrders()
 {
  
    try
    {
        const response = await fetch('https://localhost:7171/api/Order/Processing-Orders',{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            showManageOrders('Processing Orders',false);
        }
        const data = await response.json();
        populateProcessingOrdersTable(data);
    }
    catch(error)
    {
        console.log(error);
    }
}


function populateProcessingOrdersTable(data)
{
    showManageOrders('Processing Orders',true);
    const tableBody = document.querySelector('#ordersTable tbody');
    tableBody.innerHTML = ''; // Clear any existing rows
    setTableStructure();
    data.forEach(Order => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${Order.orderID}</td>
            <td>${Order.name}</td>
            <td>${Order.email}</td>
            <td>${Order.phone}</td>
            <td>${Order.address}</td>
            <td>${Order.orderDate}</td>
            <td>${Order.totalAmount}</td>
            <td>${Order.orderStatus}</td>
             <td><button onclick = "fetchOrderDetails(${Order.orderID})" class ="tableButton">Details</button></td> 
            <td><button onclick = "completeOrder(${Order.orderID})" class ="tableButton">Complete</button></td>
        `;
        tableBody.appendChild(row);
    });

}
async function completeOrder(orderID) {
    try 
    {
        const Response = await fetch(`https://localhost:7171/api/Order/CompeleteOrder ${orderID}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!Response.ok)
        {
           console.log('Unable to complete order.');
           return;
        }
        const data = await Response.json();
        console.log(data);
        fetchProcessingOrders();
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchCompleteOrders()
 {

    try
    {
        const response = await fetch('https://localhost:7171/api/Order/Compelete-Orders',{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            showManageOrders('Complete Orders',false);
        }
        const data = await response.json();
        populateCompleteOrdersTable(data);
    }
    catch(error)
    {
        console.log(error);
    }
}
function populateCompleteOrdersTable(data) {
    showManageOrders('Complete Orders', true);
    const tableBody = document.querySelector('#ordersTable tbody');
    tableBody.innerHTML = '';
    setTableStructure();

    data.forEach(Order => {
        const row = document.createElement('tr');

        let buttonsHtml;
        if (Order.orderStatus === 'Shipped') {
            buttonsHtml = `
                <td colspan="2"><button onclick="fetchOrderDetails(${Order.orderID})" class="tableButton">Details</button></td>
            `;
        } else {
            buttonsHtml = `
                <td><button onclick="fetchOrderDetails(${Order.orderID})" class="tableButton">Details</button></td>
                <td><button onclick="fetchShippingData(${Order.orderID})" class="tableButton">Shipping</button></td>
            `;
        }

        row.innerHTML = `
            <td>${Order.orderID}</td>
            <td>${Order.name}</td>
            <td>${Order.email}</td>
            <td>${Order.phone}</td>
            <td>${Order.address}</td>
            <td>${Order.orderDate}</td>
            <td>${Order.totalAmount}</td>
            <td>${Order.orderStatus}</td>
            ${buttonsHtml}
        `;
        tableBody.appendChild(row);
    });
}


async function fetchShippingData(orderID)
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
        const shippersResponse = await fetch(`https://localhost:7171/api/Shippers/All`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!orderDetailsResponse.ok||!shippersResponse.ok)
        {
           console.log('Unable to fetch data.');
        }
        const orderDetails = await orderDetailsResponse.json();
        const shippers = await shippersResponse.json();
        await populateShipping(orderDetails,shippers);
    }
    catch(error)
    {
        console.log(error);
    }
}
function generateTrackingNumber() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    let trackingNumber = '';

    // Generate two random letters
    for (let i = 0; i < 2; i++) {
        const randomIndex = Math.floor(Math.random() * letters.length);
        trackingNumber += letters[randomIndex];
    }

    // Generate seven random digits
    for (let i = 0; i < 7; i++) {
        const randomDigit = Math.floor(Math.random() * 10);
        trackingNumber += randomDigit;
    }

    return trackingNumber;
}

async function populateShipping(orderDetails, shippers) {
   
    const shippingInfoContainer = document.querySelector('.ShippingInfo-Container');
  
    let trackingNumber = generateTrackingNumber();
    const today = new Date();
    const estimatedDeliveryDate = new Date(today);
    estimatedDeliveryDate.setDate(today.getDate() + 3);

    let shippersOptions = shippers.map(shipper => 
        `<option value="${shipper.carrierID}">${shipper.carrierName}</option>`
    ).join('');
shippingInfoContainer.innerHTML = `
        <h4 class="text-secondary">Order Details</h4>
        <p class="text-secondary">Order ID: &nbsp;&nbsp;&nbsp;${orderDetails.orderID}</p>
        <p class="text-secondary">Customer Name: &nbsp;&nbsp;&nbsp;${orderDetails.name}</p>
        <p class="text-secondary">Email: &nbsp;&nbsp;&nbsp;${orderDetails.email}</p>
        <p class="text-secondary">Phone: &nbsp;&nbsp;&nbsp;${orderDetails.phone}</p>
        <p class="text-secondary">Delivery Address: &nbsp;&nbsp;&nbsp;${orderDetails.address}</p>
        <p class="text-secondary">Order Date: &nbsp;&nbsp;&nbsp;${orderDetails.orderDate}</p>
        <p class="text-secondary">Total Amount: &nbsp;&nbsp;&nbsp;${orderDetails.totalAmount}</p>
        <p class="text-secondary">Status: &nbsp;&nbsp;&nbsp;${orderDetails.orderStatus}</p>
        <hr/>
        <p class="text-secondary">Tracking Number: &nbsp;&nbsp;&nbsp;${trackingNumber}</p>
        <p class="text-secondary">Carriers:</p>
        <select class="form-control" id="carriersDropdown">
            <option value="0">--SELECT CARRIER--</option>
            ${shippersOptions}
        </select>
        <p class="text-secondary">Estimated Delivery Date:</p>
        <input type="date" class="form-control" id="estimatedDeliveryDate" value="${estimatedDeliveryDate.toISOString().split('T')[0]}" min="${today.toISOString().split('T')[0]}" />
            <p class="text-secondary">Actual Delivery Date: &nbsp;&nbsp;&nbsp;UNKNOWN</p>
        <div class="button-container">
            <button onClick="closeDetails()" type="button" class="btn btn-secondary" id="closeButton">Close</button>
            <button type="button" class="btn btn-primary" id="confirmButton">Confirm</button>
        </div>
    `;
    shippingInfoContainer.showModal();
     
  

    document.getElementById('confirmButton').addEventListener('click', () => {

        const carriersDropdown = document.getElementById('carriersDropdown'); 
        const estimatedDeliveryDateInput = document.getElementById('estimatedDeliveryDate'); 
        const selectedCarrier = carriersDropdown.value; 
        const selectedDate = new Date(estimatedDeliveryDateInput.value); 
        console.log(selectedCarrier);
        if (selectedCarrier === '0' || selectedCarrier == null) 
        {
            alert('Please select a carrier');
             return; 
        } 
        if (selectedDate < today) 
        { 
            alert('Estimated delivery date cannot be in the past');
             return;
        }
        addShipping(orderDetails.orderID,selectedCarrier,trackingNumber,selectedDate)
    });
}
closeDetails=()=>{
    const shippingInfoContainer = document.querySelector('.ShippingInfo-Container');
    shippingInfoContainer.close();
}
async function addShipping(orderID, carrierID, trackingNumber, estimatedDeliveryDate) {
    try {
        const response = await fetch("https://localhost:7171/api/Shipping/AddShipping", {
            method: "POST",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                orderID: orderID,
                carrierID: carrierID,
                trackingNumber: trackingNumber,
                status: 4,
                estimatedDeliveryDate: estimatedDeliveryDate,
                actualDeliveryDate: null
            })
        });

        if (!response.ok) {
            alert('Unable to save Shipping');
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);

        alert('Shipping added successfully 😊');
        closeDetails();
        await fetchCompleteOrders();
    } catch (error) {
        console.error("Error:", error);
    }
}


function showManageOrders(pageHeading,hasRecords)
{
   if(hasRecords)
   {
            document.getElementById('mainContent').innerHTML=`<h1 class="h3 mb-1" id="pageHeading">${pageHeading}</h1>
                    
                    <p class="mb-4">Welcome to the heart of your operations! Here in the Manage Orders section, you hold the reins to track and oversee every detail of your transactions. From the first click to the final delivery, ensure excellence at every step. Dive in and keep the wheels of commerce turning smoothly. 📦✨</p>


                        <div class = "container mt-5" id ="ordersContainer" style="overflow-x:auto ;">
                        
                     
                            <table class="table table-bordered" width="100%" cellspacing="0" id = "ordersTable">
                                <thead>
                                    <tr>
                                        <th class="text-center" scope="col" id="Col1">OrderID</th>
                                        <th class="text-center" scope="col" id="Col2">Name</th>
                                        <th class="text-center" scope="col" id="Col3">Email</th>
                                        <th class="text-center" scope="col" id="Col4">Phone</th>
                                        <th class="text-center" scope="col" id="Col5">Address</th>
                                        <th class="text-center" scope="col" id="Col6">OrderDate</th>
                                        <th class="text-center" scope="col" id="Col7">TotalAmount</th>
                                        <th class="text-center" scope="col" id="Col8">Status</th>
                                        <th class="text-center" scope="col" id="detailsCol">Details</th>
                          
                                            <dialog class="details-container">
                                            
                                            
                                            </dialog>
                                    
                                        <th class="text-center" scope="col" id="actionCol">Action</th>

                                        <dialog class="ShippingInfo-Container">
                                                        
                                                        
                                        </dialog>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th scope="col">OrderID</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">OrderDate</th>
                                        <th scope="col">TotalAmount</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Details</th>
                                        <th scope="col" id="tfActionCol">Action</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                 
                                    
                                </tbody>
                            </table>
                            </div>   
                 `
   }
   else
   {
    document.getElementById('mainContent').innerHTML=`<h1 class="h3 mb-1" id="pageHeading">${pageHeading}</h1>
                    
    <p class="mb-4">Welcome to the heart of your operations! Here in the Manage Orders section, you hold the reins to track and oversee every detail of your transactions. From the first click to the final delivery, ensure excellence at every step. Dive in and keep the wheels of commerce turning smoothly. 📦✨</p>


        <div class = "container mt-5" id ="ordersContainer" style="overflow-x:auto ;">
            <p class="text-center primary">--No ${pageHeading}--</p>
        </div>
        `
   }
  
}

function showManageProducts(searchValue='')
{
  
    document.getElementById('mainContent').innerHTML=`<iframe src="ManageProducts.html?searchValue=${searchValue}" width="100%" height="100%" frameBorder="0"></iframe>`;

}

function showSalesPredictor()
{
    document.getElementById('mainContent').innerHTML='<iframe src="SalesPredictor.html" width="100%" height="100%" frameBorder="0"></iframe>';

}
function showMostSoldProduct()
{
    document.getElementById('mainContent').innerHTML='<iframe src="MostSoldProducts.html" width="100%" height="100%" frameBorder="0"></iframe>';

} 
function showCarriers()
{
    document.getElementById('mainContent').innerHTML='<iframe src="Carriers.html" width="100%" height="100%" frameBorder="0"></iframe>';

}
function showUsers()
{
    document.getElementById('mainContent').innerHTML='<iframe src="Users.html" width="100%" height="100%" frameBorder="0"></iframe>';

}
function showCategories()
{
    document.getElementById('mainContent').innerHTML='<iframe src="Categories.html" width="100%" height="100%" frameBorder="0"></iframe>';

}
function showDashboard()
{
    document.getElementById('mainContent').innerHTML='<iframe src="Dashboard.html" width="100%" height="100%" frameBorder="0"></iframe>';

}