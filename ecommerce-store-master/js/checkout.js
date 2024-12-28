const form = document.querySelector("form");
const inputs = document.querySelectorAll("input");
const submitButton = document.querySelector("button[type='submit']");
const iconInputsContainer = document.querySelectorAll(
	"div.icon-group-container"
);
const cardNumberInput = document.querySelector("#card-number");
const expirationDateInput = document.querySelector("#expiration");
const CVVInput = document.querySelector("#cvv");
const cardImgElement = document.querySelector("#card-icon");
const currentCustomer = JSON.parse(localStorage.getItem('currentCustomer'));

const visaIcon = "./icons/visa.svg";
const mastercardIcon = "./icons/mastercard.svg";
const defaultCardIcon = "./icons/credit-card.png";

const cleaveCC = new Cleave(cardNumberInput, {
	creditCard: true,
	delimiter: " ",
	onCreditCardTypeChanged: function (type) {
		switch (type) {
			case "visa":
				cardImgElement.src = visaIcon;
				break;
			case "mastercard":
				cardImgElement.src = mastercardIcon;
				break;
			default:
				cardImgElement.src = defaultCardIcon;
				break;
		}
	},
});

const cleaveExpiration = new Cleave(expirationDateInput, {
	date: true,
	datePattern: ["m", "y"],
});

const cleaveCVV = new Cleave(CVVInput, {
	numeralPositiveOnly: true,
	blocks: [3],
});

inputs.forEach((input) => {
	input.addEventListener("focus", () => {
		input.classList.remove("empty");
		if (input.parentElement.classList.contains("icon-group")) {
			input.parentElement.classList.remove("empty");
			input.parentElement.classList.add("filling");
			input.style.boxShadow = "none";
		}
		input.classList.add("filling");
		checkInputsFilled();
	});
	input.addEventListener("input", () => {
		input.classList.remove("empty");
		if (input.parentElement.classList.contains("icon-group")) {
			input.parentElement.classList.remove("empty");
			input.parentElement.classList.add("filling");
			input.style.boxShadow = "none";
		}
		input.classList.add("filling");

		checkInputsFilled();
	});

	input.addEventListener("focusout", () => {
		if (!input.value) {
			input.classList.remove("filling");
			if (input.parentElement.classList.contains("icon-group")) {
				input.parentElement.classList.remove("filling");
				input.parentElement.classList.add("empty");
			}
			input.classList.add("empty");
		}
		checkInputsFilled();
	});

	input.addEventListener("input", () => {
		if (!input.value) {
			input.classList.remove("filling");
			if (input.parentElement.classList.contains("icon-group")) {
				input.parentElement.classList.remove("filling");
				input.parentElement.classList.add("empty");
			}
			input.classList.add("empty");
		}
	});
});

function checkInputsFilled() {
	let inputsArray = Array.from(inputs);
	let result = inputsArray.map((input) => {
		if (input.value === "") {
			return false;
		} else {
			return true;
		}
	});
	let inputsFilled = result.every((input) => input === true);
	if (inputsFilled) {
		submitButton.classList.remove("disabled");
		submitButton.removeAttribute("disabled");
	} else {
		submitButton.classList.add("disabled");
		submitButton.setAttribute("disabled", "");
	}
}


submitButton.addEventListener("click", async(e) => {
	e.preventDefault();
    await makeOrder();
});
function getQueryParameter(name)
 { 
    const urlParams = (new URL(document.location)).searchParams; 
    return urlParams.get(name);
 } 
async function makeOrder() {
    const totalAmountParam = getQueryParameter('totalAmount'); console.log('totalAmountParam:', totalAmountParam);
    const totalAmount =parseInt(getQueryParameter('totalAmount'), 10);

    if (isNaN(totalAmount))
         { console.error('Invalid price');
          return;
         } 
    const today = new Date();
    try {
        const response = await fetch("https://localhost:7171/api/Order/NewOrder", {
            method: "POST",
            mode: 'cors',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                customerID: currentCustomer.customerID,
                orderDate: today.toISOString(),
                totalAmount: totalAmount,
                status: 1
            })
        });

        if (!response.ok) {
            Swal.fire({
                position: "center",
                icon: "error",
                title: "Unable to place Order",
                showConfirmButton: false,
                timer: 1500
            });
            throw new Error("Network response was not ok " + response.statusText);
        }

        const data = await response.json();
        console.log("Success:", data);
        console.log(data.orderID);
        await saveOrderItems(data.orderID);

        Swal.fire({
            position: "center",
            icon: "success",
            title: "Order Placed Succssfully 😊",
            showConfirmButton: false,
            timer: 1500
        });
        setTimeout(function() {
            window.location.href = 'index.html';
        }, 2000);
    } catch (error) {
        console.error("Error:", error);
    }
       
    
}
async function getCartItems() 
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
async function saveOrderItems(orderID) {
    const cartItems = await getCartItems();
    for (const item of cartItems) 
    {
        console.log(item);
        try {
            const response = await fetch("https://localhost:7171/api/OrderItem/AddOrderItem", {
                method: "POST",
                mode: 'cors',
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    orderID: orderID,
                    productID: item.productId,
                    quantity: item.quantity,
                    size: item.size,
                    color: item.color,
                    price:item.price,
                    totalItemsPrice:item.totalItemsPrice
                })
            });

            if (!response.ok) {
            
                throw new Error("Network response was not ok " + response.statusText);
            }

            const data = await response.json();
            console.log("Success:", data);

        } catch (error) {
            console.error("Error:", error);
        }
    }   
    // Clear CartItems from localStorage
    Object.keys(localStorage).forEach(key => {
        if (key.startsWith('cartItem_')) {
          localStorage.removeItem(key);
        }
      });
}
window.onload = fillCustomerInfo();
function fillCustomerInfo()
{
    if(currentCustomer==null)
    {
        localStorage.setItem('redirectAfterLogin', window.location.href);
        window.location.href='login.html';
    }
    else
    {
        document.getElementById('full-name').value = currentCustomer.name;
        document.getElementById('address').value = currentCustomer.address;
    }
}
