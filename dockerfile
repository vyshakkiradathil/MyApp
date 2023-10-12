# Use the official .NET SDK image as a build stage.
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory in the container.
WORKDIR /app

# Copy the .csproj and restore dependencies.
COPY *.csproj ./
RUN dotnet restore

# Copy the application code.
COPY . ./

# Publish the application.
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image for the final image.
FROM mcr.microsoft.com/dotnet/runtime:5.0 AS runtime

# Set the working directory.
WORKDIR /app

# Copy the published application from the build image.
COPY --from=build /app/out ./

# Define the entry point.
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
