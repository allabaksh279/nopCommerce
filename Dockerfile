FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish src/Presentation/Nop.Web/Nop.Web.csproj -c Release -o /app/published

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/published .
EXPOSE 80
ENTRYPOINT ["dotnet", "Nop.Web.dll"]
