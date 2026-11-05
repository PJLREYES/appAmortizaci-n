; ═══════════════════════════════════════════════════════════════════════
;  Instalador de Amortizaciones PJLR
;  No copia el programa HTML: crea accesos directos que abren la aplicación
;  publicada (enlace web) en una ventana propia de Edge o Chrome, con su icono.
;  Crea las carpetas de trabajo: datos, Copias de seguridad, Versiones anteriores.
;  Compilar con NSIS 3:  makensis Instalador.nsi
; ═══════════════════════════════════════════════════════════════════════
Unicode true

!define APP_NOMBRE   "Amortizaciones PJLR"
!define APP_VERSION  "2026.28"
!define APP_URL      "https://amortizaciones-pjlr.netlify.app"
!define APP_EDITOR   "PJLR"
!define CLAVE_DESINST "Software\Microsoft\Windows\CurrentVersion\Uninstall\AmortizacionesPJLR"

Name "${APP_NOMBRE}"
OutFile "Instalar_Amortizaciones_PJLR.exe"
InstallDir "C:\appAmortizaciones"
RequestExecutionLevel user
SetCompressor /SOLID lzma
BrandingText "${APP_NOMBRE} · Ver ${APP_VERSION}"

VIProductVersion "2026.28.0.0"
VIAddVersionKey /LANG=1034 "ProductName" "${APP_NOMBRE}"
VIAddVersionKey /LANG=1034 "FileDescription" "Instalador de ${APP_NOMBRE}"
VIAddVersionKey /LANG=1034 "FileVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=1034 "ProductVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=1034 "CompanyName" "${APP_EDITOR}"
VIAddVersionKey /LANG=1034 "LegalCopyright" "${APP_EDITOR}"

!include "MUI2.nsh"
!include "LogicLib.nsh"

!define MUI_ICON   "Amortizaciones.ico"
!define MUI_UNICON "Amortizaciones.ico"
!define MUI_ABORTWARNING

!define MUI_WELCOMEPAGE_TITLE "Instalación de ${APP_NOMBRE}"
!define MUI_WELCOMEPAGE_TEXT "Este asistente instalará ${APP_NOMBRE} (Ver ${APP_VERSION}).$\r$\n$\r$\nNo se copia el programa: los accesos directos abren siempre la versión publicada en internet, así que estará siempre actualizada.$\r$\n$\r$\nSe crearán la carpeta del programa con sus subcarpetas (datos, Copias de seguridad y Versiones anteriores), el icono y los accesos directos en el Escritorio y en el menú Inicio.$\r$\n$\r$\nSi ya tienes la aplicación en esa carpeta, no se modifica ni se borra nada de lo que hay."
!insertmacro MUI_PAGE_WELCOME

!define MUI_DIRECTORYPAGE_TEXT_TOP "Carpeta del programa. Dentro se guardarán tus datos (subcarpeta «datos»). Si ya usabas la aplicación, deja C:\appAmortizaciones."
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_TITLE "${APP_NOMBRE} está instalado"
!define MUI_FINISHPAGE_TEXT "La primera vez que lo abras, ve a Configuración > Almacenamiento → «Elegir carpeta del programa» y selecciona:$\r$\n$\r$\n      $INSTDIR$\r$\n$\r$\nLos datos se guardarán automáticamente en $INSTDIR\datos. Para recuperar datos anteriores usa Configuración > Restaurar datos."
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Abrir ${APP_NOMBRE} ahora"
!define MUI_FINISHPAGE_RUN_FUNCTION AbrirApp
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "Spanish"

Var Navegador

; Busca Microsoft Edge o Google Chrome para abrir la app en ventana propia (--app)
Function BuscarNavegador
  StrCpy $Navegador ""
  ${If} ${FileExists} "$PROGRAMFILES32\Microsoft\Edge\Application\msedge.exe"
    StrCpy $Navegador "$PROGRAMFILES32\Microsoft\Edge\Application\msedge.exe"
  ${ElseIf} ${FileExists} "$PROGRAMFILES64\Microsoft\Edge\Application\msedge.exe"
    StrCpy $Navegador "$PROGRAMFILES64\Microsoft\Edge\Application\msedge.exe"
  ${ElseIf} ${FileExists} "$LOCALAPPDATA\Microsoft\Edge\Application\msedge.exe"
    StrCpy $Navegador "$LOCALAPPDATA\Microsoft\Edge\Application\msedge.exe"
  ${ElseIf} ${FileExists} "$PROGRAMFILES64\Google\Chrome\Application\chrome.exe"
    StrCpy $Navegador "$PROGRAMFILES64\Google\Chrome\Application\chrome.exe"
  ${ElseIf} ${FileExists} "$PROGRAMFILES32\Google\Chrome\Application\chrome.exe"
    StrCpy $Navegador "$PROGRAMFILES32\Google\Chrome\Application\chrome.exe"
  ${ElseIf} ${FileExists} "$LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
    StrCpy $Navegador "$LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
  ${EndIf}
FunctionEnd

!macro CrearAcceso RUTA
  ${If} $Navegador != ""
    CreateShortCut "${RUTA}" "$Navegador" "--app=${APP_URL}" "$INSTDIR\Amortizaciones.ico" 0 SW_SHOWMAXIMIZED "" "${APP_NOMBRE}"
  ${Else}
    CreateShortCut "${RUTA}" "$INSTDIR\Amortizaciones PJLR.url" "" "$INSTDIR\Amortizaciones.ico" 0 SW_SHOWNORMAL "" "${APP_NOMBRE}"
  ${EndIf}
!macroend

Section "Instalar"
  SetShellVarContext current
  SetOutPath "$INSTDIR"

  ; Carpetas de trabajo (no se borra nada si ya existen)
  CreateDirectory "$INSTDIR"
  CreateDirectory "$INSTDIR\datos"
  CreateDirectory "$INSTDIR\Copias de seguridad"
  CreateDirectory "$INSTDIR\Versiones anteriores"

  ; Icono
  File "Amortizaciones.ico"

  ; Enlace web de reserva (también útil si no hay Edge ni Chrome)
  WriteINIStr "$INSTDIR\Amortizaciones PJLR.url" "InternetShortcut" "URL" "${APP_URL}"
  WriteINIStr "$INSTDIR\Amortizaciones PJLR.url" "InternetShortcut" "IconFile" "$INSTDIR\Amortizaciones.ico"
  WriteINIStr "$INSTDIR\Amortizaciones PJLR.url" "InternetShortcut" "IconIndex" "0"

  ; Accesos directos
  Call BuscarNavegador
  ${If} $Navegador == ""
    DetailPrint "No se ha encontrado Edge ni Chrome: se usará el navegador predeterminado."
  ${Else}
    DetailPrint "Navegador: $Navegador"
  ${EndIf}
  !insertmacro CrearAcceso "$INSTDIR\${APP_NOMBRE}.lnk"
  !insertmacro CrearAcceso "$DESKTOP\${APP_NOMBRE}.lnk"
  CreateDirectory "$SMPROGRAMS\${APP_NOMBRE}"
  !insertmacro CrearAcceso "$SMPROGRAMS\${APP_NOMBRE}\${APP_NOMBRE}.lnk"
  CreateShortCut "$SMPROGRAMS\${APP_NOMBRE}\Carpeta de datos.lnk" "$INSTDIR\datos"
  CreateShortCut "$SMPROGRAMS\${APP_NOMBRE}\Desinstalar ${APP_NOMBRE}.lnk" "$INSTDIR\Desinstalar Amortizaciones.exe" "" "$INSTDIR\Amortizaciones.ico" 0

  ; Desinstalador y registro en «Aplicaciones instaladas»
  WriteUninstaller "$INSTDIR\Desinstalar Amortizaciones.exe"
  WriteRegStr HKCU "${CLAVE_DESINST}" "DisplayName" "${APP_NOMBRE}"
  WriteRegStr HKCU "${CLAVE_DESINST}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKCU "${CLAVE_DESINST}" "Publisher" "${APP_EDITOR}"
  WriteRegStr HKCU "${CLAVE_DESINST}" "DisplayIcon" "$INSTDIR\Amortizaciones.ico"
  WriteRegStr HKCU "${CLAVE_DESINST}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${CLAVE_DESINST}" "URLInfoAbout" "${APP_URL}"
  WriteRegStr HKCU "${CLAVE_DESINST}" "UninstallString" '"$INSTDIR\Desinstalar Amortizaciones.exe"'
  WriteRegDWORD HKCU "${CLAVE_DESINST}" "NoModify" 1
  WriteRegDWORD HKCU "${CLAVE_DESINST}" "NoRepair" 1
SectionEnd

Function AbrirApp
  ${If} $Navegador != ""
    Exec '"$Navegador" --app=${APP_URL}'
  ${Else}
    ExecShell "open" "${APP_URL}"
  ${EndIf}
FunctionEnd

; El desinstalador quita accesos directos e icono, pero NUNCA borra datos ni copias
Section "Uninstall"
  SetShellVarContext current
  Delete "$DESKTOP\${APP_NOMBRE}.lnk"
  Delete "$SMPROGRAMS\${APP_NOMBRE}\${APP_NOMBRE}.lnk"
  Delete "$SMPROGRAMS\${APP_NOMBRE}\Carpeta de datos.lnk"
  Delete "$SMPROGRAMS\${APP_NOMBRE}\Desinstalar ${APP_NOMBRE}.lnk"
  RMDir  "$SMPROGRAMS\${APP_NOMBRE}"
  Delete "$INSTDIR\${APP_NOMBRE}.lnk"
  Delete "$INSTDIR\Amortizaciones PJLR.url"
  Delete "$INSTDIR\Desinstalar Amortizaciones.exe"
  DeleteRegKey HKCU "${CLAVE_DESINST}"
  ; Solo se eliminan las carpetas si están vacías
  RMDir "$INSTDIR\datos"
  RMDir "$INSTDIR\Copias de seguridad"
  RMDir "$INSTDIR\Versiones anteriores"
  RMDir "$INSTDIR"
  MessageBox MB_ICONINFORMATION "Se han quitado los accesos directos de ${APP_NOMBRE}.$\r$\nTus datos y copias de seguridad de $INSTDIR no se han borrado."
SectionEnd
