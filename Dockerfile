FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ADD . /nop
WORKDIR /nop
RUN dotnet publish -c Release src/Presentation/Nop.Web -o published/
RUN mkdir published/bin published/logs

FROM mcr.microsoft.com/dotnet/aspnet:10.0
# Create user WITHOUT password using numeric UID
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g 1001 -m -s /bin/sh app
COPY --from=build --chown=1001:1001 /nop/published/ /app/
WORKDIR /app
USER app                    # Runs as non-root user (no password)
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls=http://0.0.0.0:5000"]

