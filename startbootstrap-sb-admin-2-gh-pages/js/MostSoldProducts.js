
const table = document.getElementById('productsTable');

window.onload = table.style.display = 'none';
async function fetchMostSoldProducts()
{
    const dateFrom = document.getElementById('dateFrom');
    const dateTo = document.getElementById('dateTo');
    console.log(dateTo.value);
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