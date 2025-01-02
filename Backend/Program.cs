


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Add CORS services
builder.Services.AddCors();

var app = builder.Build();



// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();


}
app.UseCors(builder =>
{
    builder.WithOrigins("http://127.0.0.1:5500") // Allow specific origin(s)
           .AllowAnyMethod() // Allow any method
           .AllowAnyHeader(); // Allow any header
});

app.UseHttpsRedirection();

app.UseAuthorization();

 app.MapControllers();

app.Run();

