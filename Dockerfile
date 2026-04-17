FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ADD . /nop
WORKDIR /nop
RUN dotnet publish src/Presentation/Nop.Web/Nop.Web.csproj -c Release -o /app/published
