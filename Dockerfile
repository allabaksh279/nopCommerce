FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ADD . /nop
WORKDIR /nop
RUN dotnet publish -c Release src/Presentation/Nop.Web -o published/
RUN mkdir published/bin published/logs

FROM mcr.microsoft.com/dotnet/aspnet:10.0
RUN groupadd -g 1000 boss && useradd -u 1000 -g boss -m -d /usr/share/boss -s /bin/sh boss
COPY --from=build /nop/published/ /usr/share/boss/
WORKDIR /usr/share/boss
RUN chown -R boss:boss /usr/share/boss
USER boss
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls=http://0.0.0.0:5000"]

