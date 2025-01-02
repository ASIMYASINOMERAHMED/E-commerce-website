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
async function computeHash(message) {
    // Encode the message as UTF-8
    const msgBuffer = new TextEncoder().encode(message);

    // Compute the hash
    const hashBuffer = await crypto.subtle.digest('SHA-256', msgBuffer);

    // Convert the hash to a hexadecimal string
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');

    return hashHex;
}



const email = document.getElementById('email');
const password = document.getElementById('password');
const singIn = document.getElementById('signIn');
singIn.onclick =async function()
{
    await login();
};
async function login()
{

    const hash = await computeHash(password.value);
    console.log(hash);
    fetch(`https://localhost:7171/api/Customer/Email ${email.value}/ Password ${hash}`, {
        method: "GET",
        mode: 'cors',
        headers: {
          "Content-Type": "application/json"
        },
      })
      .then(response => {
        if (!response.ok) {
            Swal.fire({
                position: "center",
                icon: "error",
                title: "Wrong Email or Password",
                showConfirmButton: false,
                timer: 1500
              });
          throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data);
        localStorage.setItem('currentCustomer',JSON.stringify(data));
        Swal.fire({
            position: "center",
            icon: "success",
            title: `Wellcome, ${data.name}`,
            showConfirmButton: false,
            timer: 1500
          });
          setTimeout(function() {

            const redirectTo = localStorage.getItem('redirectAfterLogin');

            if (redirectTo) 
            {
                localStorage.removeItem('redirectAfterLogin'); // Clean up
                window.location.href = redirectTo;
            } 
            else 
            {
                window.location.href = 'index.html';
            };
        }, 2000);
     
      })
      .catch(error => {
        console.error("Error:", error);
      });
}
