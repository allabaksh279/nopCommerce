FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore src/Presentation/Nop.Web/Nop.Web.csproj
RUN dotnet publish src/Presentation/Nop.Web/Nop.Web.csproj -c Release -o /app/published
RUN ls -la /app/published
