# restaurar-workspace.ps1

# Volver a la carpeta contenedora principal (un nivel arriba de /infra)
cd ..

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host " Reconstruyendo el Workspace de BarrioDigital (Windows)..." -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

# Reemplaza con tu organización o usuario de GitHub
$GITHUB_USER="BarrioDigital"

# Lista de repositorios
$REPOS = @(
  "frontend-barriodigital",
  "ms-barriodigital-bff",
  "ms-barriodigital-requests",
  "ms-barriodigital-catalog",
  "ms-barriodigital-notify",
  "ms-barriodigital-report",
  "ms-barriodigital-audit",
  "docs"
)

# Bucle para clonar de forma automática
foreach ($REPO in $REPOS) {
    if (Test-Path $REPO) {
        Write-Host "--> El repositorio '$REPO' ya existe. Omitiendo..." -ForegroundColor Yellow
    } else {
        Write-Host "--> Clonando '$REPO' desde GitHub..." -ForegroundColor Green
        git clone "https://github.com/$GITHUB_USER/$REPO.git"
    }
}

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host " ¡Workspace completamente restaurado y listo!                    " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan