const totalOrders = document.getElementById('totalOrders');
const totalRevenue = document.getElementById('totalRevenue');
const totalVisitor = document.getElementById('totalVisitor');
const totalMessages = document.getElementById('totalMassages');

window.onload = fetchTotalMessages();
window.onload = fetchTotalVisitor();
window.onload = fetchTotalRevenue();
window.onload = fetchTotalOrders();
async function fetchTotalOrders()
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Order/All`,{
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
        const data = await response.json();
        totalOrders.innerHTML = ` <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Total Orders</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${data.length}</div>`
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchTotalRevenue()
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Order/Total-Revenue`,{
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
        const data = await response.json();
        totalRevenue.innerHTML = ` <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                   Total Revenue</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${'$'+data}</div>`
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchTotalVisitor()
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Customer/Customers-Count`,{
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
        const data = await response.json();
        totalVisitor.innerHTML = ` <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                   Total Visitors</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${data}</div>`
    }
    catch(error)
    {
        console.log(error);
    }
}

async function fetchTotalMessages()
{
    try
    {
        const response = await fetch(`https://localhost:7171/api/Messages/All`,{
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
        const data = await response.json();
        totalMessages.innerHTML = `    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                    Messages</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${data.length}</div>`
    }
    catch(error)
    {
        console.log(error);
    }
}
async function getTotalRevenueCurrentYear() {
    try {
        const response = await fetch(`https://localhost:7171/api/Report/Current-Year-Total-Revenue`, {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            console.log('an error occurred');
            return;
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.log(error);
    }
}
async function getTotalSalesCurrentYear() {
    try {
        const response = await fetch(`https://localhost:7171/api/Report/Current-Year-Total-Sales`, {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            console.log('an error occurred');
            return;
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.log(error);
    }
}

async function getNextYearPredictedTotalSalesAndRevenue() {
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const nextYear = currentYear + 1;
    try {
        const response = await fetch(`https://localhost:7171/api/SalesForecasting/PredictTotalSalesAndRevenue?Year=${nextYear}&Month=1`, {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            console.log('an error occurred');
            return;
        }
        const text = await response.text();
        console.log(text);
        return text;
    } catch (error) {
        console.log(error);
    }
}
async function genarateReport() {
    
    try {
        const [totalRevenue, totalSales, predictedTotalSalesRevenue] = await Promise.all([ getTotalRevenueCurrentYear(), getTotalSalesCurrentYear(), getNextYearPredictedTotalSalesAndRevenue() ]);

        const response = await fetch(`https://localhost:7171/api/Report/Sales-Data`, {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            console.log('an error occurred');
            return;
        }
        const data = await response.json();

        // Create a div element to hold the table
        const reportDiv = document.createElement('div');
        reportDiv.id = 'reportDiv';
        
        // Create a table element
        const table = document.createElement('table');
        table.border = '1';
        
        // Create the table header
        const thead = document.createElement('thead');
        const headerRow = document.createElement('tr');
        
        // Assuming the data has keys like 'Column1', 'Column2', etc.
        const headers = Object.keys(data[0]);
        headers.forEach(header => {
            const th = document.createElement('th');
            th.textContent = header;
            headerRow.appendChild(th);
        });
        
        thead.appendChild(headerRow);
        table.appendChild(thead);
        
        // Create the table body
        const tbody = document.createElement('tbody');
        data.forEach(item => {
            const row = document.createElement('tr');
            headers.forEach(header => {
                const td = document.createElement('td');
                td.textContent = item[header];
                row.appendChild(td);
            });
            tbody.appendChild(row);
        });
     
        table.appendChild(tbody);
        reportDiv.appendChild(table);
        document.body.appendChild(reportDiv);
        const today = new Date().toISOString().slice(0, 10);
        // Generate the PDF
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        doc.setFontSize(18);
        doc.text("SALES ACTIVITY REPORT", 105, 20, null, null, 'center');
        doc.setFontSize(12);
        doc.text(`Date: ${today}`, 105, 30, null, null, 'center');
        // Add the table to the PDF
        doc.autoTable({ html: '#reportDiv table',startY: 40,theme: 'striped' });

        const finalY = doc.autoTable.previous.finalY;
         // Get the Y position after the table
        doc.text(`Total Sales: ${totalSales}`, 14, finalY + 10); 
        doc.text(`Total Revenue: $${totalRevenue}`, 14, finalY + 20);
        doc.text(`Predicted Total Sales and Total Revenue for the next year: ${predictedTotalSalesRevenue}`, 14, finalY + 30);
        // Save the PDF
        doc.save('report.pdf');
        document.body.removeChild(reportDiv);
    } catch (error) {
        console.log(error);
    }
}




async function getSalesData() {
    try {
        const response = await fetch(`https://localhost:7171/api/Report/Sales-Data`, {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            console.log('An error occurred');
            return;
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.log(error);
    }
}

async function renderChart() {
    const salesData = await getSalesData();
    
    if (!salesData) {
        console.log('No sales data available');
        return;
    }

    // Extract the months and totalRevenue for the chart
    const labels = salesData.map(entry => entry.month);
    const totalRevenue = salesData.map(entry => entry.totalRevenue);

    // Area Chart Example
    var ctx = document.getElementById("myAreaChart");
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: "Revenue",
                lineTension: 0.3,
                backgroundColor: "rgba(78, 115, 223, 0.05)",
                borderColor: "rgba(78, 115, 223, 1)",
                pointRadius: 3,
                pointBackgroundColor: "rgba(78, 115, 223, 1)",
                pointBorderColor: "rgba(78, 115, 223, 1)",
                pointHoverRadius: 3,
                pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                pointHitRadius: 10,
                pointBorderWidth: 2,
                data: totalRevenue,
            }],
        },
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: {
                    left: 10,
                    right: 25,
                    top: 25,
                    bottom: 0
                }
            },
            scales: {
                xAxes: [{
                    time: {
                        unit: 'date'
                    },
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    ticks: {
                        maxTicksLimit: 7
                    }
                }],
                yAxes: [{
                    ticks: {
                        maxTicksLimit: 5,
                        padding: 10,
                        // Include a dollar sign in the ticks
                        callback: function(value, index, values) {
                            return '$' + value.toLocaleString();
                        }
                    },
                    gridLines: {
                        color: "rgb(234, 236, 244)",
                        zeroLineColor: "rgb(234, 236, 244)",
                        drawBorder: true,
                        borderDash: [2],
                        zeroLineBorderDash: [2]
                    }
                }],
            },
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: "rgb(255,255,255)",
                bodyFontColor: "#858796",
                titleMarginBottom: 10,
                titleFontColor: '#6e707e',
                titleFontSize: 14,
                borderColor: '#dddfeb',
                borderWidth: 1,
                xPadding: 15,
                yPadding: 15,
                displayColors: false,
                intersect: false,
                mode: 'index',
                caretPadding: 10,
                callbacks: {
                    label: function(tooltipItem, chart) {
                        var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                        return datasetLabel + ': $' + tooltipItem.yLabel.toLocaleString();
                    }
                }
            }
        }
    });
}

// Call renderChart function to fetch data and render the chart
renderChart();


async function renderPieChart() {
    const salesData = await getSalesData();
    
    if (!salesData) {
        console.log('No sales data available');
        return;
    }

    // Filter the data for the last year
    const currentYear = new Date().getFullYear();
    const filteredData = salesData.filter(entry => entry.year === currentYear);

    // Extract the total sales for different revenue sources (e.g., Direct, Referral, Social)
    const labels = filteredData.map(entry => entry.month);
    const totalSales = filteredData.map(entry => entry.totalSales);

    // Aggregate total sales by month
    const salesByMonth = labels.reduce((acc, month, index) => {
        acc[month] = (acc[month] || 0) + totalSales[index];
        return acc;
    }, {});

    // Convert the aggregated data into arrays for Chart.js
    const finalLabels = Object.keys(salesByMonth);
    const finalData = Object.values(salesByMonth);

    // Pie Chart Example
    var ctx = document.getElementById("myPieChart");
    var myPieChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: finalLabels,
            datasets: [{
                data: finalData,
                backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796', '#5a5c69', '#1cc88a', '#36b9cc', '#4e73df', '#1cc88a', '#f6c23e'],
                hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', '#f6b12e', '#e63a3b', '#717478', '#5a5c69', '#17a673', '#2c9faf', '#2e59d9', '#17a673', '#f6b12e'],
                hoverBorderColor: "rgba(234, 236, 244, 1)",
            }],
        },
        options: {
            maintainAspectRatio: false,
            tooltips: {
                backgroundColor: "rgb(255,255,255)",
                bodyFontColor: "#858796",
                borderColor: '#dddfeb',
                borderWidth: 1,
                xPadding: 15,
                yPadding: 15,
                displayColors: false,
                caretPadding: 10,
            },
            legend: {
                display: true
            },
            cutoutPercentage: 80,
        },
    });
/*     // Create the custom legend 
    const legendContainer = document.getElementById('chart-legend'); 
    legendContainer.innerHTML = finalLabels.map((label, index) => 
        ` <span class="mr-2"> <i class="fas fa-circle" style="color: ${myPieChart.data.datasets[0].backgroundColor[index]};"></i> ${label} </span> `).join(''); */
}

// Call renderPieChart function to fetch data and render the pie chart
renderPieChart();


