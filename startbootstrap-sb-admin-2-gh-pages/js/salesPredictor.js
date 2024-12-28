const predictions = document.getElementById('prediction');
window.onload = predictions.style.display = 'none';

async function Predict()
{
    const year = document.getElementById('year');
    const month = document.getElementById('month');

    try{
        const response = await fetch(`https://localhost:7171/api/SalesForecasting/PredictTotalSalesAndRevenue?Year=${year.value}&Month=${month.value}`,{
            method: 'GET',
            mode: 'cors',
            headers: {
              'Content-Type': 'application/json'
            }
          });
        if(!response.ok)
        {
            predictions.style.display = 'none';
           console.log('Unable to fetch data.');
    
        }
        const data = await response.text();
        console.log(data);
        predictions.textContent = data;
        predictions.style.display = 'block';
    }
    catch(error)
    {
        console.log(error);
    }
}