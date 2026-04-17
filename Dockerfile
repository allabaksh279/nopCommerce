FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ADD . /nop
WORKDIR /nop
RUN dotnet publish -c Release src/Presentation/Nop.Web -o published/
RUN mkdir published/bin published/logs

FROM mcr.microsoft.com/dotnet/aspnet:10.0
RUN adduser -D -h /usr/share/boss -s /bin/sh
COPY --from=nop/published /usr/share/boss
WORKDIR /usr/share/boss
USER boss
EXPOSE 5000/tcp
CMD ["dotnet" , "Nop.Web.dll", "--urls=http:0.0.0.0:5000"]
