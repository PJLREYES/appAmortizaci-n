# Amortizaciones PJLR

Registro de bienes y cuadros de amortización. Es una aplicación HTML de un solo archivo, multiempresa.

Versión actual: **Ver PJLR 2026.32**

## Archivos

| Archivo | Descripción |
|---|---|
| `Amortizaciones.html` | Aplicación (abrir en Google Chrome o Microsoft Edge) |
| `index.html` | Copia idéntica de la aplicación, para publicarla en Netlify |
| `Amortizaciones.ico` | Icono de la aplicación (16–256 px) |
| `instalador/` | Instalador para Windows (`Instalar_Amortizaciones_PJLR.exe`), su código NSIS y LEEME |

## Datos

Los datos **no** están en este repositorio. Al elegir la carpeta del programa en
⚙️ Configuración → 📁 Almacenamiento, se guardan en la subcarpeta `datos` del
equipo: `config.json` y un archivo `empresa_….json` por empresa. Si no se elige
carpeta, se quedan en el navegador.

Las copias de seguridad (.zip) y los archivos `empresa_….json` de cualquier versión
anterior se restauran desde ⚙️ Configuración → ♻️ Restaurar datos, que los adapta
al formato actual.

## Instalador

`instalador/Instalar_Amortizaciones_PJLR.exe` no copia el HTML: crea accesos directos que abren
https://amortizaciones-pjlr.netlify.app en una ventana propia de Edge o Chrome, con su icono. También
crea `C:\appAmortizaciones` con sus carpetas `datos`, `Copias de seguridad` y `Versiones anteriores`.
El desinstalador nunca borra datos. Más información en `instalador/LEEME.txt`.

## Historial reciente

- **2026.32**: «Copias de seguridad» conserva solo las 10 copias más recientes (bienes_amortizaciones_….zip); al cerrar se borran las más antiguas.
- **2026.31**: se elimina la copia automática del programa (`amortizaciones_programa.html`) y el botón «Actualizar programa en la carpeta»; las copias que quedaran se borran solas al conectar la carpeta.
- **2026.30**: conexión automática con la carpeta al iniciar (o petición de confirmación con un clic; si la carpeta no está guardada o no se encuentra, se pide elegirla). Indicador verde «Conectada» / rojo «Desconectada» en la parte superior; un clic en rojo reconecta. Vigilancia de la conexión cada 20 s.
- **2026.29**: el botón «✕ Cerrar» guarda una copia de seguridad ZIP en la subcarpeta «Copias de seguridad» de la carpeta del programa (incluye los archivos de «datos» de todas las empresas) y cierra la aplicación.
- **2026.28**: se quita el botón de Configuración de la pestaña Informe anual.
- **2026.27**: el menú de opciones del bien también se abre con el clic izquierdo.
- **2026.26**: nueva pestaña «♻️ Restaurar datos» en Configuración.
- **2026.25**: nueva pestaña principal «⚙️ Configuración».
- **2026.24**: menú contextual (Cuadro, Editar, PDF, Imprimir, Ver factura, Eliminar); los datos pasan a la carpeta `datos`; adaptador de copias de versiones anteriores; corregida la exportación del informe a PDF.
