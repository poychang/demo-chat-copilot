# ---------------------------------------------
# 調整前端專案
# ---------------------------------------------
# 設定前端專案建置時所需要的環境變數
$EnvFilePath = ".\webapp\.env"

## REACT_APP_BACKEND_URI 為前端呼叫後端的 API 位址，請依照實際情況調整
$newEnv = "REACT_APP_BACKEND_URI=http://localhost:40442/"

$newEnv | Set-Content -Path $EnvFilePath

# ---------------------------------------------
# 調整後端專案
# ---------------------------------------------
# 讓後端專案能夠開啟靜態檔案，藉此啟動前端專案的應用程式
# 需要調整 WebAPI 的 Program.cs 檔案
$ProgramCSFilePath = ".\webapi\Program.cs"
$ProgramCSContent = Get-Content -Path $ProgramCSFilePath

$newProgramCS = @()

foreach ($line in $ProgramCSContent) {
    $newProgramCS += $line
    if ($line -match "app\.UseCors\(\);") {
        $newProgramCS += "        app.UseDefaultFiles();"
        $newProgramCS += "        app.UseStaticFiles();"
    }
}

$newProgramCS | Set-Content -Path $ProgramCSFilePath
