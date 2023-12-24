FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["SausageApplication/SausageApplication.csproj", "SausageApplication/"]
RUN dotnet restore "SausageApplication/SausageApplication.csproj"
COPY . .
WORKDIR "/src/SausageApplication"
RUN dotnet build "SausageApplication.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SausageApplication.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SausageApplication.dll"]
