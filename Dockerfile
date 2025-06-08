# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia csproj y restaura
COPY *.sln .
COPY EvaluadorInteligente/*.csproj ./EvaluadorInteligente/
RUN dotnet restore

# Copia todo y publica
COPY . .
WORKDIR /src/EvaluadorInteligente
RUN dotnet publish -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "EvaluadorInteligente.dll"]
