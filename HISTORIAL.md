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
- ~~Agregar scope `read:org` al token para habilitar `gh auth login` persistente~~ → **Completado** (gh CLI autenticado en keyring).

---

### 2026-08-10 — Security headers en el nuevo hosting (HestiaCP + Cloudflare)

**Contexto:** El sitio fue migrado a panamahosting507.com (panel HestiaCP, Apache + Nginx, con Cloudflare delante). El `.htaccess` del servidor no tenía los security headers.

**Tareas completadas:**
1. Verificado acceso SSH y estado del `.htaccess` en servidor (solo bloque WordPress, sin headers).
2. Backup del `.htaccess` del servidor: `.htaccess.bak-20260810`.
3. Subido el `.htaccess` con security headers vía scp:
   - `X-Frame-Options: SAMEORIGIN`
   - `X-Content-Type-Options: nosniff`
   - `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`
   - `Content-Security-Policy: default-src 'self' https: data: 'unsafe-inline' 'unsafe-eval'; frame-ancestors 'self'; base-uri 'self'; form-action 'self';`
4. Verificado directo al origen (IP 159.195.16.126): **todos los headers se sirven correctamente** desde Apache.
5. Detectado que **Cloudflare delante no pasaba los headers** por dominio público.
6. Solicitado al hosting (vía soporte) agregar headers a nivel Cloudflare (Transform Rules → Modify Response Header).
7. **Confirmado:** headers activos vía dominio público (se ven duplicados: origen + CF, normal).
8. Verificado redirect HTTP→HTTPS: **301 OK** vía Cloudflare.
9. **Diagnóstico de malware:** sin señales de compromiso — los archivos modificados son de actualizaciones normales de Elementor/Jetpack; sin scripts inyectados en uploads/themes; PHP en uploads son `index.php` vacíos de seguridad de WordPress.

**Pendiente:**
- Solicitar revisión en Google Search Console (aviso de phishing).
- Verificar estado exacto en Google Safe Browsing (requiere key API o Search Console).

---

### 2026-08-10 — Actualización del número de WhatsApp/WhatsApp en todo el sitio

**Contexto:** El número de teléfono cambió de `6405-9959` a `6099-0195`. El usuario ya lo había actualizado en la página de Inicio; se requería replicarlo en el resto de páginas (Shop, etc.). El header/footer está integrado en cada página vía templates Elementor HFE.

**Diagnóstico:**
- Los templates `elementor-hf` activos que se renderizan en las páginas: **Header 4 (3784)**, **Footer 1 (414)**, **Footer bar (1381)**.
- El número viejo `6405-9959` estaba en: Header 4 (data+content), Footer 1 (data+content), Inicio 13263 (data+content, restos) y la opción del plugin Click to Chat (`ht_ctc_chat_options`).
- Los IDs de postmeta con `6405` que no existen en `posts` son datos huérfanos (no afectan).

**Tareas completadas:**
1. Backup de DB: `backups/db-before-phone-20260810.sql` (33MB).
2. Instalado WP-CLI en el servidor (`/home/abgroup/web/anabolicgroup.com/wp-cli.phar`).
3. Reemplazo del número en Elementor data + post_content de: Header 4 (3784), Footer 1 (414), Inicio (13263):
   - `6405-9959` → `6099-0195`
   - `64059959` → `60990195`
   - `50764059959` → `50760990195`
4. Actualizada la opción del plugin **Click to Chat for WhatsApp** (`ht_ctc_chat_options`): `+50764059959` → `+50760990195`.
5. Flush de cachés: WP cache, Elementor CSS, rewrite rules, caché Nginx (hestia-cache purge).
6. **Verificado en vivo** en 7 páginas (Inicio, Shop, Mi Cuenta, Carrito, Checkout, Lista de Deseos, Tienda): todas muestran el número nuevo, sin restos del viejo. La caché de Nginx/Cloudflare servía HTML viejo en Shop; se resolvió purgando.

**Nota:** Quedan restos de `6405` solo en **revisiones** de Elementor (posts `inherit`, 15391-15399) — no se renderizan y no afectan el sitio.

---

### 2026-08-10 — ⚠️ INCIDENTE: Corrupción de datos Elementor y restauración

**Contexto:** Tras la actualización del número de teléfono, el usuario reportó que el sitio quedó desordenado: Inicio dañado, y en Shop se perdieron header y footer.

**Causa raíz:** El script de actualización usó `wp_update_post()` (API de WordPress) para guardar `post_content` de los templates `elementor-hf` y páginas. Esto disparó filtros/hooks de WordPress que **corrompieron los JSON de `_elementor_data`** (JSON inválido) en:
- Inicio (13263): 41543 → 41253 bytes
- Header 4 (3784): 8894 → 8863
- Footer 1 (414): 16062 → 15938

**Acciones de recuperación:**
1. Backup del estado corrupto: `backups/db-before-restore-20260810.sql` (33.5MB).
2. **Restauración completa de la DB** desde `backups/db-before-phone-20260810.sql` (13:05, estado intacto previo a cambios).
3. Verificado JSON válido de nuevo: Inicio 41543, Header 4 8894, Footer 1 16062.
4. Flush de cachés (WP, Elementor CSS, Nginx).
5. **Verificado el render en vivo:** Inicio (`elementor-13263`), Shop con Header 4 (3784), Footer 1 (414) y Footer bar (1381) presentes, títulos correctos. **Sitio restaurado sin daño.**

**LECCIÓN APRENDIDA (crítico para futuras ediciones de Elementor):**
- ⚠️ **NUNCA usar `wp_update_post()` para editar contenido de templates Elementor** (corrompe `_elementor_data`).
- ✅ Para editar Elementor data, usar **`update_post_meta()` directo** (seguro) o **SQL directo**, y solo sobre `_elementor_data`.
- ⚠️ La opción global de Click to Chat (`ht_ctc_chat_options`) quedó **restaurada al número viejo** con la DB — debe actualizarse de nuevo de forma segura.

**Estado actual:** Sitio funcional, con número viejo `6405-9959` (cambio pendiente de rehacer de forma segura).

---

### 2026-08-10 — ✅ Reaplicación segura del número de teléfono

**Contexto:** Rehacer el cambio de número `6405-9959` → `6099-0195` tras el incidente, usando el método seguro (sin `wp_update_post`).

**Método seguro aplicado:**
1. Backup previo: `backups/db-before-phone-safe-20260810.sql`.
2. `_elementor_data` actualizado con **`update_post_meta()`** (sin filtros/hooks de WP) → JSON validado como VÁLIDO en los 3 posts tras cada cambio.
3. `post_content` actualizado con **SQL directo** (`$wpdb->update`) evitando `wp_update_post()`.
4. Opción Click to Chat (`ht_ctc_chat_options`) actualizada con `update_option()`: `+50764059959` → `+50760990195`.
5. Flush de cachés (WP, Elementor CSS, Nginx).

**Verificación en vivo (número nuevo presente, sin restos del viejo):**
- `/` Inicio: `6099-0195` + `50760990195` ✓
- `/shop/`: `50760990195` ✓ (header 3784, footers 414 + 1381 presentes)
- `/my-account/` (URL correcta, no "mi-cuenta"): ✓
- `/cart/` y `/checkout/`: ✓
- **JSON de Elementor válido** en Inicio (13263), Header 4 (3784), Footer 1 (414).

**Notas:**
- Las URLs WooCommerce son `/my-account/` y `/cart/` (no en español) — las URLs `/mi-cuenta/` y `/carrito/` dan 404 (comportamiento normal, no relacionado con el cambio).
- El header/footer del tema (#masthead/#colophon) en páginas WooCommerce sin Elementor es normal (nutritix header-1).
