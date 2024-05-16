# Usa la imagen base adecuada
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /app

# Copia el archivo de proyecto y restaura las dependencias
COPY MVCPrototipo.csproj .
RUN dotnet restore

# Copia el resto del código fuente
COPY . .

# Especifica el proyecto a construir y construye la aplicación
RUN dotnet build MVCPrototipo.csproj -c Release -o /app/build

# Publica la aplicación
RUN dotnet publish MVCPrototipo.csproj -c Release -o /app/publish

# Usa una imagen de ASP.NET Core runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MVCPrototipo.dll"]

# Exponer el puerto 80 para que sea accesible desde fuera del contenedor
EXPOSE 80
