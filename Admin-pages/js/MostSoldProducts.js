
const table = document.getElementById('productsTable');

window.onload = table.style.display = 'none';
function isValidDates() {
    //Get the text in the elements
    var from = document.getElementById('dateFrom').value;
    var to = document.getElementById('dateTo').value;

    //Generate an array where the first element is the year, second is month and third is day
    var splitFrom = from.split('/');
    var splitTo = to.split('/');

    //Create a date object from the arrays
    var fromDate = Date.parse(splitFrom[0], splitFrom[1] - 1, splitFrom[2]);
    var toDate = Date.parse(splitTo[0], splitTo[1] - 1, splitTo[2]);

    //Return the result of the comparison
    return fromDate < toDate;
}

async function fetchMostSoldProducts()
{
    table.style.display = 'none';
    const dateFrom = document.getElementById('dateFrom');
    const dateTo = document.getElementById('dateTo');
    if(dateFrom.value==''||dateTo.value=='')
    {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "please select date.",
            showConfirmButton: false,
            timer: 1500
          });
        return;
    }
    if(!isValidDates())
    {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "Invalid Date Period, Date From Should be before Date To",
            showConfirmButton: false,
            timer: 1500
          });
        return;
    }
    try{
    const response = await fetch(`https://localhost:7171/api/ProductCatalog/Most-Sold-Products From ${dateFrom.value} To ${dateTo.value}`,{
        method: 'GET',
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json'
        }
      });
    if(!response.ok)
    {
        table.style.display = 'none';
       console.log('Unable to fetch data.');
       Swal.fire({
        position: "center",
        icon: "warning",
        title: "No Products Found.",
        showConfirmButton: false,
        timer: 1500
      });

    }
    const data = await response.json();
    populateTable(data);
}
catch(error)
{
    console.log(error);
}
}

function populateTable(data)
{
    const tbody = document.getElementById('tbody');
    tbody.innerHTML='';

    data.forEach(product => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${product.productID}</td>
            <td>${product.productName}</td>
            <td>${product.frequency}</td>
        `;
        tbody.appendChild(row);
    });
    table.style.display = "table";
}