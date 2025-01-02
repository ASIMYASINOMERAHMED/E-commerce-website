document.addEventListener('DOMContentLoaded', function () {
    // Select all links on the page
    const link = document.querySelector('a');
    // Add click event listeners to each link
        link.addEventListener('click', function (event) {
            // Prevent the default behavior of the link
            event.preventDefault();

            // Apply the fade-out class to the body
            document.body.classList.add('fade-out');

            // Wait for the animation to complete before navigating to the new page
            setTimeout(() => {
                window.location.href = this.href;
            }, 500); // The duration should match the duration of the fade-out animation
        });
});

const name = document.getElementById('name');
const email = document.getElementById('email');
const phone = document.getElementById('phone');
const address = document.getElementById('address');
const password = document.getElementById('password');
const btnCreateAccount = document.getElementById('btnCreateAccount');

function isValidEmail(email) {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}

function isValidPassword(password) {
    // Define criteria for password validation
    const minLength = 8;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasLowerCase = /[a-z]/.test(password);
    const hasNumber = /\d/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

    return (
        password.length >= minLength &&
        hasUpperCase &&
        hasLowerCase &&
        hasNumber &&
        hasSpecialChar
    );
}
function isValidPhoneNumber(phoneNumber) {
    // Define a regex pattern for a basic phone number format
    const phonePattern = /^\d{10,15}$/;

    return phonePattern.test(phoneNumber);
}

btnCreateAccount.onclick = async function(event) {   
    event.preventDefault();
    
    const isEmailValid = isValidEmail(email.value);
    const isPhoneValid = isValidPhoneNumber(phone.value);
    const isPasswordValid = isValidPassword(password.value);

    if (name.value === '' || email.value === '' || phone.value === '' || address.value === '' || password.value === '') {  
        Swal.fire({
            position: "center",
            icon: "error",
            title: "make sure to fill all feilds",
            showConfirmButton: false,
            timer: 1500
        });
        return;
    } 
    else if(!isEmailValid)
    {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "Invalid Email",
            showConfirmButton: false,
            timer: 1500
        });
        return;
    }
    else if(!isPhoneValid)
    {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "Invalid Phone Number",
            showConfirmButton: false,
            timer: 1500
        });
        return;
    }
    else if(!isPasswordValid)
        {
            Swal.fire({
                position: "center",
                icon: "error",
                title: "Password should contain at least one uppercase letter, at least one digit,at least one special character (e.g., !@#$%^&*()), and at least 8 characters long.",
                showConfirmButton: true,
          
            });
            return;
        }
    else {
        await addCustomerInfo();

        
    }
};

async function addCustomerInfo()
{
    fetch("https://localhost:7171/api/Customer/AddCustomer", {
        method: "POST",
        mode: 'cors',
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
            name: name.value,
            email: email.value,
            phone: phone.value,
            address: address.value,
            password: password.value
        })
      })
      .then(response => {
        if (!response.ok) {
            Swal.fire({
                position: "top-end",
                icon: "error",
                title: "Unable to save Information",
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
            title: "saved successfully",
            showConfirmButton: false,
            timer: 1500
          });
          setTimeout(function() {
            window.location.href = 'login.html';
        }, 2000);
      })
      .catch(error => {
        console.error("Error:", error);
      });
}