const userName = document.getElementById('InputUserName');
const inputPassword = document.getElementById('InputPassword');
const btnLogin = document.getElementById('btnlogin');
const roleDropdown = document.getElementById('roleDropdown');
const loginImage = document.getElementById('loginImage');


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


btnLogin.onclick = async function(event)
{
    console.log('hi');
    event.preventDefault();
    await login();
};
async function login()
{

if(roleDropdown.value==0||roleDropdown.value==null)
{
    Swal.fire({
        position: "center",
        icon: "error",
        title: "Select Role!",
        showConfirmButton: false,
        timer: 1500
      });
    return;
}
    const hash = await computeHash(inputPassword.value);
    console.log(hash);
    if(roleDropdown.value== 1)
    {
    fetch(`https://localhost:7171/api/User/UserName ${userName.value}/ Password ${hash}`, {
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
                title: "Wrong username or password",
                showConfirmButton: false,
                timer: 1500
              });
          throw new Error("Network response was not ok " + response.statusText);
        }
        return response.json();
      })
      .then(data => {
        console.log("Success:", data);
        localStorage.setItem('currentUser',JSON.stringify(data));
        Swal.fire({
            position: "center",
            icon: "success",
            title: `Wellcome, ${data.name}`,
            showConfirmButton: false,
            timer: 1500
          });
          setTimeout(function() {

            window.location.href = `main.html?userId=${data.userID}`;
            
        }, 2000);
     
      })
      .catch(error => {
        console.error("Error:", error);
      });
    }
    else
    {
        fetch(`https://localhost:7171/api/Shippers/Carrier ${userName.value}/ ${hash}`, {
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
                    title: "Wrong username or password",
                    showConfirmButton: false,
                    timer: 1500
                  });
              throw new Error("Network response was not ok " + response.statusText);
            }
            return response.json();
          })
          .then(data => {
            console.log("Success:", data);
            localStorage.setItem('currentShipper',JSON.stringify(data));
            Swal.fire({
                position: "center",
                icon: "success",
                title: `Wellcome, ${data.carrierName}`,
                showConfirmButton: false,
                timer: 1500
              });
              setTimeout(function() {
    
                window.location.href = `Shipper.html?carrierID=${data.carrierID}`;
                
            }, 2000);
         
          })
          .catch(error => {
            console.error("Error:", error);
          });
    }
}
