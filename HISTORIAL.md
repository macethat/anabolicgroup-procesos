# HISTORIAL DE TRABAJO — anabolicgroup.com

> Este archivo registra toda la actividad realizada en el proyecto.
> Se actualiza al completar cada tarea.

---

## Estado del proyecto

- **Sitio:** anabolicgroup.com
- **Tipo:** Tienda online (WordPress + WooCommerce)
- **Nicho:** Péptidos y productos para hipertrofia muscular
- **Hosting anterior:** SiteGround
- **Hosting actual:** panamahosting507.com (desde 2026-08)
- **SSH:** `abgroup@bolic.panamahosting507.com:1230` (acceso por clave pública ed25519)
- **Stack:** WordPress 7.0.3 · WooCommerce · Theme Nutritix (+child) · Elementor Pro · Rank Math SEO · paguelofacil + yappy
- **Carpeta local del proyecto:** `C:\anabolicgroup`
- **Repositorio de procesos (GitHub):** `macethat/anabolicgroup-procesos` (https://github.com/macethat/anabolicgroup-procesos)
- **Ruta del sitio en servidor:** `/home/abgroup/web/anabolicgroup.com/public_html/`

---

## Registro de actividad

### 2026-08-10 — Conexión al nuevo hosting y exploración inicial

**Contexto:** El sitio fue movido de SiteGround a panamahosting507.com. El aviso de "sitio peligroso (phishing)" de Google seguía activo.

**Tareas completadas:**
1. Configuración del acceso SSH mediante clave pública (ed25519).
2. Conexión establecida: `abgroup@bolic.panamahosting507.com` puerto 1230.
3. Exploración inicial del servidor:
   - Raíz del sitio: `/home/abgroup/web/anabolicgroup.com/public_html/`
   - Stack confirmado: WordPress 7.0.3 + WooCommerce
   - Theme activo: **Nutritix** + child theme
   - Plugins relevantes: Elementor Pro, Rank Math SEO, Jetpack, paguelofacil, yappy-bg-para-woocommerce, all-in-one-wp-migration, hestia-nginx-cache
4. Se verificó que el `.htaccess` del servidor NO contiene aún los security headers (X-Frame-Options, HSTS, CSP, etc.) que se configuraron en el hosting anterior.

**Pendiente / próximos pasos:**
- Aplicar los security headers del `.htaccess` local al servidor nuevo (el hosting actual no los tiene).
- Solicitar revisión en Google Search Console (aviso de phishing).
- Evaluar estado de plugins/tema y actualizaciones.

---

### 2026-08-10 — Creación de historial y repositorio

**Contexto:** Establecer un sistema de registro de actividad en un repositorio Git/GitHub propio, separado de los repos existentes del usuario (psk-wc-sync, psk-sucursales, dashboard-sp, kommo).

**Tareas completadas:**
1. Creado `HISTORIAL.md` en la carpeta local del proyecto (registro continuo de actividad).
2. Inicialización de repositorio local Git con rama `main`.
3. Resolución de autenticación de GitHub:
   - El token del Windows Credential Manager estaba **revocado** → se actualizó por uno nuevo.
   - Nuevo token guardado en el Credential Manager de Windows (persistente para todas las sesiones/proyectos).
   - Configurado header de auth en git local para el push.
4. Creado repositorio remoto **`macethat/anabolicgroup-procesos`** (público).
5. Commit inicial subido: `29e9fde` — "Inicio: historial de trabajo, htaccess y documentación".
6. Creado `.gitignore` que excluye `accesos.txt` y archivos de credenciales (evitar filtrado de contraseñas).
7. `accesos.txt` (con contraseñas de WordPress/correos) **excluido del repo** por seguridad.

**Nota de seguridad:** Los secretos (contraseñas, tokens) no se guardan en el repo ni en el historial.

**Pendiente:**
- Agregar scope `read:org` al token para habilitar `gh auth login` persistente.
