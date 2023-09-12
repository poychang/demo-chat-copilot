# Chat Copilot

Chat Copilot 原始專案位置 [microsoft/chat-copilot](https://github.com/microsoft/chat-copilot)

搭配以下檔案與建置指令，可以將前後端專案合併成一個，並建置成 Container，絕大部分的設定值可以透過 Dockerfile 的環境變數來調整

## 建置指令

在專案根目錄下執行以下指令，即可建置出一個名為 `chat-copilot` 的 Docker Image

```ps1
# Modify Files (Execute only once)
./Deploy/modify-files.ps1

# Build Frontend
cd webapp
yarn install
yarn build
cd ..

# Build Backend
Copy-Item -Path ./webapp/build/* -Destination ./webapi/wwwroot -Recurse -Force
dotnet publish ./webapi/CopilotChatWebApi.csproj --configuration Release --framework net6.0 --output ./app

# Build Docker Image
docker build -t chat-copilot -f ./Deploy/Dockerfile .
```
