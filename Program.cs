using Perch.Components;
using Perch.Services;

//Let Dapper match snake_case columns (common_name) to PascalCase properties (CommonName)
Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;

var builder = WebApplication.CreateBuilder(args);

//Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();
builder.Services.AddSingleton<BirdService>();
builder.Services.AddSingleton<SightingService>();
builder.Services.AddSingleton<UserService>();
builder.Services.AddScoped<CurrentUser>(); //Requires Scoped vs Singleton so that not everyone has a shared account
builder.Services.AddSingleton<NemesisService>();

var app = builder.Build();

//Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    //The default HSTS value is 30 days. May need to be changed for production scenarios: https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseHttpsRedirection();

app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
