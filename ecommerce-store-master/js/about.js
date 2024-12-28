const btnSend = document.getElementById('sendMessage');
const message = document.getElementById('message');
const headerqty = document.getElementById('header-qty');
const headerPrice = document.getElementById('header-price');
window.onload = displayCartQtyAndPrice();
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