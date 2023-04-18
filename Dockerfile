# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

# FROM mcr.microsoft.com/windows/servercore/iis
# WORKDIR /inetpub/wwwroot

# SHELL ["powershell"]
# RUN Remove-WebSite -Name 'Default Web Site'
# RUN New-Website -Name 'mywebapp' -Port 80 -PhysicalPath 'c:\inetpub\wwwroot' -ApplicationPool '.NET v4.5'


# COPY . C:/inetpub/wwwroot

# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS publish
# WORKDIR /src
# COPY . C:/src
# # RUN msbuild /p:Configuration=Release -r:False
# RUN MSBuild Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\publish



# FROM mcr.microsoft.com/windows/servercore/iis
# SHELL ["powershell"]
# RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
#     Install-WindowsFeature Web-Asp-Net45
# RUN Remove-WebSite -Name 'Default Web Site'
# RUN Remove-Item -Recurse C:\inetpub\wwwroot\*
# WORKDIR /inetpub/wwwroot
# RUN New-IISSite -Name "mywebapp" -BindingInformation "*:8080:" -PhysicalPath "c:\inetpub\wwwroot"
# COPY ./index.html C:/inetpub/wwwroot



# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# WORKDIR /inetpub/wwwroot
# COPY --from=deploy /inetpub/wwwroot C:/inetpub/wwwroot

# EXPOSE 80

# copy csproj and restore as distinct layers
# COPY . .
# RUN msbuild /p:Configuration=Release -r:False

# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# WORKDIR /inetpub/wwwroot

# COPY --from=build /app/. ./







# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS publish
# WORKDIR /src
# COPY . .
# RUN MSBuild Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot

# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# COPY --from=publish /inetpub/wwwroot C:/inetpub/wwwroot

# EXPOSE 80



# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime

# FROM mcr.microsoft.com/windows/servercore/iis AS deploy

# SHELL ["powershell"]

# RUN Remove-Item -Recurse C:\inetpub\wwwroot\*

# RUN New-IISSite -Name "mywebapp" -BindingInformation "*:8282:" -PhysicalPath "c:\inetpub\wwwroot"

# WORKDIR /inetpub/wwwroot

# COPY --from=publish ./publish .






# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS publish
# WORKDIR /src
# COPY . .
# RUN MSBuild Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot

# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# COPY --from=publish /inetpub/wwwroot C:/inetpub/wwwroot

# EXPOSE 80

# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS sdk
# WORKDIR /src
# COPY . .
# RUN MSBuild c:\src\Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot
# EXPOSE 80
# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# ARG src="Program Files (x86)/MSBuild"
# ARG target="Program Files (x86)/MSBuild"
# COPY --from=sdk ${src} ${target}

# EXPOSE 80


# /Program Files (x86)/MSBuild/Microsoft/VisualStudio/v11.0/WebApplications/Microsoft.WebApplication.targets

#C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe c:\src\Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot


# C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v11.0\WebApplications\Microsoft.WebApplication.targets


# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS sdk
# SHELL ["powershell"]
# RUN Add-WindowsFeature Web-Server;
# RUN Add-WindowsFeature NET-Framework-45-ASPNET; 
# RUN Add-WindowsFeature Web-Asp-Net45;
# RUN Remove-Item -Recurse C:\inetpub\wwwroot\*; 
# RUN Invoke-WebRequest -Uri https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe -OutFile C:\ServiceMonitor.exe;
# WORKDIR /src
# COPY . .
# RUN MSBuild c:\src\Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot
# EXPOSE 80
# ENTRYPOINT ["C:\\ServiceMonitor.exe" "w3svc"]





# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
# WORKDIR /src
# COPY . .
# RUN MSBuild c:\src\Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot

# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
# WORKDIR /inetpub/wwwroot
# COPY /bin/release C:/inetpub/wwwroot
# EXPOSE 80


############################### WORKING ######################################
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS base
WORKDIR /inetpub/wwwroot
EXPOSE 80

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS publish
WORKDIR /src
COPY . .
RUN MSBuild c:\src\Webformframework.sln  /p:DeployOnBuild=True /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True /p:publishUrl=C:\inetpub\wwwroot

FROM base AS final
WORKDIR /inetpub/wwwroot
COPY --from=publish /inetpub/wwwroot .
############################### WORKING ######################################