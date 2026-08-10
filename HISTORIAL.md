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
- **SSH:** `abgroup@bolic.panamahosting507.com:1230`
- **Stack:** WordPress 7.0.3 · WooCommerce · Theme Nutritix (+child) · Elementor Pro · Rank Math SEO · paguelofacil + yappy
- **Carpeta local del proyecto:** `C:\anabolicgroup`

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
- Decidir tarea prioritaria: headers de seguridad, diagnóstico de phishing, revisión de malware, o actualizaciones.

---

### 2026-08-10 — Creación de historial y repositorio

**Tareas completadas:**
1. Creado `HISTORIAL.md` en la carpeta local del proyecto.
2. Inicialización de repositorio local Git (pendiente confirmar estado).
3. Repositorio remoto en GitHub (separado de los existentes) — pendiente completar autenticación.
