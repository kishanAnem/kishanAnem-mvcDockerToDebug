FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base

WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["mvcPrac.csproj", "./"]
RUN dotnet restore "./mvcPrac.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "mvcPrac.csproj" -c Debug -o /app/build

FROM build AS publish
RUN dotnet publish "mvcPrac.csproj" -c Debug -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "mvcPrac.dll"]
