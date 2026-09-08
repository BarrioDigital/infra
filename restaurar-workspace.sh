#!/bin/bash
# restaurar-workspace.sh

# Volver a la carpeta contenedora principal (un nivel arriba de /infra)
cd ..

echo "================================================================="
echo " Reconstruyendo el Workspace de BarrioDigital..."
echo "================================================================="

# IMPORTANTÍSIMO: Reemplacen esta variable con el nombre de su usuario 
# o de la organización de GitHub donde crearon sus repositorios
GITHUB_USER="BarrioDigital"

# Lista de repositorios oficiales requeridos por la pauta de evaluación
REPOS=(
  "frontend-barriodigital"
  "ms-barriodigital-bff"
  "ms-barriodigital-requests"
  "ms-barriodigital-catalog"
  "ms-barriodigital-notify"
  "ms-barriodigital-report"
  "ms-barriodigital-audit"
  "docs"
)

# Bucle para clonar cada uno de los repositorios de forma automática
for REPO in "${REPOS[@]}"
do
  if [ -d "$REPO" ]; then
    echo "--> El repositorio '$REPO' ya existe en este workspace. Omitiendo clonación..."
  else
    echo "--> Clonando '$REPO' desde GitHub..."
    git clone "https://github.com/$GITHUB_USER/$REPO.git"
  fi
done

echo "================================================================="
echo " ¡Workspace completamente restaurado y listo para programar!     "
echo "================================================================="