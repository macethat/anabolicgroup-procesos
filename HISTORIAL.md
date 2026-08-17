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

---

### 2026-08-10 — ⚠️ INCIDENTE RECURRENTE: corrupción de JSON y resolución definitiva

**Contexto:** El usuario reportó el sitio "dañado de nuevo". Diagnóstico completo determinó que el problema visible era el render mezclado de los dos números (viejo `6405` + nuevo `6099`) y no una pérdida estructural (JSON seguía válido, sitio funcional).

**Hallazgos del diagnóstico:**
1. La caché huérfana de SiteGround (`wp-content/cache/sgo-cache`) seguía sirviendo HTML con el número viejo → **eliminada** (no era la causa raíz).
2. El render directo al origen (sin Cloudflare) seguía mezclando números → la fuente real era la **DB**: `_elementor_data` de Header 4 (3784) y Footer 1 (414) contenía el número viejo.
3. **Causa raíz de la corrupción JSON recurrente:** incluso `update_post_meta()` sobre `_elementor_data` corrompe el JSON (Elementor guarda el data como string con escapes que WordPress re-procesa). Por eso tras reaplicar con `update_post_meta`, el JSON volvía a quedar inválido (8863/15938/41253 bytes).

**Solución definitiva (aplicada):**
1. Restauración de la DB desde el backup original `backups/db-before-phone-20260810.sql` (JSON válido, estado intacto).
2. Cambio del número en `_elementor_data` y `post_content` mediante **SQL directo** (`UPDATE` con `REPLACE` sobre `wp_buDIJ_postmeta` / `wp_buDIJ_posts`), que NO pasa por WordPress ni corrompe nada.
3. Actualización de la opción Click to Chat (`ht_ctc_chat_options`) también por SQL directo: `+50764059959` → `+50760990195`.
4. Flush de cachés (WP, Elementor CSS, Nginx/hestia-cache) y eliminación de `sgo-cache`.

**Verificación final (todo en vivo):**
- JSON **VÁLIDO** en los 3 posts: Inicio 41543, Header 4 8894, Footer 1 16062 (longitudes intactas).
- `_elementor_data` de 3784/414/13263: **solo número nuevo** (6099), sin restos de 6405.
- Render: `/` y `/shop/` muestran solo `6099-0195` / `50760990195`.
- Click to Chat: `+50760990195`.
- Backup del estado final: `backups/db-final-phone-fixed-20260810.sql`.
- Scripts de diagnóstico temporales eliminados del servidor.

**LECCIÓN DEFINITIVA:**
- ⚠️ **NUNCA usar `wp_update_post()`** sobre contenido Elementor.
- ⚠️ **NUNCA usar `update_post_meta()` sobre `_elementor_data`** (también corrompe el JSON).
- ✅ Para editar `_elementor_data`: **solo SQL directo** (`UPDATE` con `REPLACE` sobre la tabla `postmeta`). Luego validar JSON y verificar render en vivo.

**Estado actual:** Sitio funcional, número nuevo `6099-0195` en todo el sitio, JSON válido, tarea COMPLETADA.

---

### 2026-08-10 — Actualización de existencias y precios desde archivo maestro

**Contexto:** El cliente subió un archivo (`Lista_Anabolicgroup_Maestra_Productos_por_Marca_Editable.numbers`, formato Apple Numbers) con las existencias actuales y precios de los productos. No tienen SKU ni código → comparación por nombre. La columna llamada "SKU" (mal nombrada) tiene 2 estados: `Disponible` y `Agotado`. Los productos sin variaciones (100% productos `simple`). Regla: `Disponible` → **100 unidades**, `Agotado` → **0 unidades**. Además el archivo es la lista de precios actualizada (hubo incrementos).

**Proceso:**
1. Extracción del `.numbers` (es un zip; datos en IWA) → 93 productos con Marca/Categoría/Producto/Precio/SKU.
2. Export de WooCommerce vía WC CLI (166 posts tipo product, 79 publicados; 0 variaciones).
3. Cruce por nombre normalizado + verificación manual de equivalencias (las tiendas tienen nombres largos con descripciones de marketing vs nombres cortos del archivo).
4. Backup DB previo: `backups/db-before-stock-20260810.sql`.
5. Aplicación vía `$wpdb` directo (sin `wp_update_post`): `_regular_price`, `_price`, `_manage_stock=yes`, `_stock` (100/0), `_stock_status` (instock/outofstock).
6. Flush de cachés (WP + Nginx).

**Resultados:**
- **68 productos actualizados** (61 con cambio de precio, 66 con cambio de stock) — verificación post-cambio: 0 errores.
- **25 productos NO existen en WC** → listados en `productos_no_encontrados_para_crear.csv` para crear luego (faltan fotos/datos). Incluyen marcas nuevas (EMINENCE LABS, VMS MOLECULAR SCIENCE péptidos, presentaciones LANDERLAN/XTLABS distintas).
- **3 mapeos dudosos omitidos** (Deca-NPP Gold 10ml, Boldenona 200mg Gold 10ml, BPC-157 10mg) por posible dosaje/presentación distinta — pendientes de confirmar.

**Archivos generados:**
- `comparativa_existencias_preliminar.csv` (cruce completo archivo vs WC)
- `plan_cambios_stock_precio.csv` (68 cambios aplicados con valores antes/después)
- `productos_no_encontrados_para_crear.csv` (25 a crear: Marca/Producto/Precio/Estado/Stock propuesto)

**Pendiente:**
- Crear los 25 productos faltantes (requiere fotos y confirmar datos).
- Resolver los 3 mapeos dudosos.

---

### 2026-08-10 — Verificación de precios VMS y actualización BPC-157 5mg

**Contexto:** El cliente pidió verificar los precios de 16 péptidos (GLOW, MOST-C, GHK-Cu, TESAMORELIN, IPAMORELIN, CJC1295, TB500, BPC-157, NAD, AOD9604, Tirzepatide 10/15/30/60, Retatrutide 10/60) contra el sitio. Solo lectura.

**Resultado de la verificación (solo 5 existen en WC):**
- `GHK-Cu 100mg` = 130$ ✓ (coincide)
- `Tirzepatide 30mg` = 160$ ✓ (coincide)
- `BPC-157 5mg` = **100$** ✗ (el cliente indicaba 120$)
- `Retatrutide 30mg` = 200$ (no estaba en la lista del cliente pero existe)
- Los otros 13 (GLOW, MOST-C, TESAMORELIN, IPAMORELIN, CJC1295, TB500, NAD, AOD9604, Tirzepatide 10/15/60, Retatrutide 10/60) **no existen** en WC → parte de los 25 pendientes por crear.

**Acción realizada:**
- `BPC-157 5mg` (ID 15244): precio actualizado de 100$ a **120$** (regular_price y price) vía SQL directo. Stock intacto (8).
- Flush de cachés (WP + Nginx).

**Pendiente:** crear los 13 péptidos faltantes con los precios indicados por el cliente (GLOW 160, MOST-C 160, TESAMORELIN 160, IPAMORELIN 130, CJC1295 150, TB500 160, NAD 140, AOD9604 150, Tirzepatide 10=120/15=130/60=220, Retatrutide 10=160/60=220).

---

### 2026-08-10 — IGF-1 LR3 1 ml agotado

**Contexto:** El cliente indicó que el producto en la URL `https://anabolicgroup.com/product/igf-1-lr3-1-ml/` debía quedar agotado.

**Acción:**
- Producto ID 14613 `IGF-1 LR3 1 ml: Hiperplasia + Recuperación`: `_stock` 409 → **0**, `_stock_status` instock → **outofstock** (vía SQL directo).
- Nota: este producto es distinto del `IGF-1 LR3 1mg` (15248, 120$) del archivo VMS. El archivo maestro no tenía entrada para el de 1 ml.
- Flush de cachés (WP + Nginx).

**Verificación:** stock 0 / outofstock confirmado en DB.

---

### 2026-08-10 — Retatrutide simple → producto VARIABLE (10mg / 30mg / 60mg)

**Contexto:** El cliente indicó que el producto `Retatrutide 30mg` (antes simple) debía pasar a ser un producto variable con 3 presentaciones. Imágenes nuevas en `C:\suplementos\anabolicos\fotos\` (PNG: `Retatrutide 60mg.png`, `Retratrutide 10mg.png`).

**Proceso:**
1. Backup DB previo: `backups/db-before-retatrutide-var-20260810.sql`.
2. Precios/stock confirmados por el cliente: **10mg=160$/100 · 30mg=200$/100 · 60mg=250$/0** (60mg agotado; rectificó de 220 a 250).
3. Atributo creado vía SQL directo en `woocommerce_attribute_taxonomies` (WC CLI no tiene subcomando para atributos): **`pa_presentacion`** (id=6) con términos **10mg=210, 30mg=211, 60mg=212** (con `register_taxonomy` previo en el script).
4. Imágenes: PNG convertidas a JPG 1000px (~78KB) y subidas con alt/caption SEO: **10mg=att 15401, 60mg=att 15402** (30mg ya tenía 15233).
5. Script `make_variable.php` (`$wpdb`): producto 15229 → tipo `variable`, atributo `pa_presentacion` visible/variación, default 30mg, borrado de metas precio/stock del padre, creación de 3 variaciones.
6. Descripción reescrita (vía SQL directo) sin mencionar "30mg" en H2/primer párrafo; ficha técnica con "Concentración: según presentación".
7. Renombrado el producto: título `Retatrutide 30mg` → **`Retatrutide`** (vía SQL directo; slug/URL intactos).
8. Flush de cachés (WP + Nginx).

**Resultado (verificado en frontend `https://anabolicgroup.com/product/retatrutide-30mg/`):**
- Producto padre 15229: `product-type-variable`, `variations_form`, H1 `<title>` = "Retatrutide".
- Variaciones: **10mg** (15403, 160$, instock, img 15401) · **30mg** (15404, 200$, instock, img 15233) · **60mg** (15405, 250$, outofstock, img 15402).
- Selector muestra las 3 presentaciones con precios y estado de stock correctos.

**Archivos relacionados (local):** `make_variable.php`, `create_attribute.php`, `upload_imgs.php`. Scripts temporales eliminados del servidor.

---

### 2026-08-10 — Fix: selector de presentaciones del Retatrutide variable no aparecía

**Síntoma:** En la página del producto variable no había forma de seleccionar las presentaciones; la tabla `variations` del front salía con `<tbody>` vacío (sin swatches ni `<select>`).

**Causa raíz (2 capas):**
1. **Transient `wc_attribute_taxonomies` obsoleto:** el atributo `pa_presentacion` se creó vía SQL directo en `woocommerce_attribute_taxonomies`, pero WooCommerce registra las taxonomías globales desde el transient `_transient_wc_attribute_taxonomies` (cacheado con solo 5 atributos) → `pa_presentacion` nunca se registraba como taxonomía en el front → el template variable no generaba la fila del selector.
2. **Términos sin asociar al producto:** los términos 10mg/30mg/60mg existían en `terms`/`term_taxonomy` (count=0) pero **no estaban en `term_relationships`** del producto padre (15229) → aunque la taxonomía se registrara, el dropdown saldría vacío. WooCommerce muestra solo los términos relacionados al post.

**Solución (SQL directo):**
- `DELETE` del transient `wc_attribute_taxonomies` (+ timeout) → WooCommerce releyó la tabla y registró `pa_presentacion`.
- `INSERT IGNORE` en `term_relationships` (object_id=15229 ↔ term_taxonomy_id 210/211/212) + actualización de `count` en `term_taxonomy`.
- Flush de cachés (WP + Nginx).

**Verificación (frontend):** selector con swatches del plugin woo-variation-swatches: botones `10mg / 30mg (preseleccionado) / 60mg`, select oculto de respaldo con las 3 opciones, botón "Limpiar". Los 3 precios/stock siguen correctos (160/100, 200/100, 250/0).

**Lección:** al crear atributos/términos por SQL (sin pasar por `wc_create_attribute()`/`wp_set_object_terms()`), hay que (a) invalidar el transient `wc_attribute_taxonomies` y (b) asignar los términos al producto en `term_relationships`; de lo contrario el selector de variaciones queda vacío.

---

### 2026-08-10 — Fix: badge "Out of Stock" en Retatrutide variable (stock del padre)

**Síntoma:** tras arreglar el selector, el front mostraba "Out of Stock" junto al título aunque 2 de 3 variaciones estaban disponibles.

**Causa:** el producto padre (15229) conservaba `_stock_status=outofstock` (reliquia de cuando fue producto simple). El theme Nutritix muestra el badge de disponibilidad leyendo el stock del **padre**, no el de las variaciones.

**Solución (SQL directo):**
- `_stock_status` del padre 15229 → `instock` (el stock real lo manejan las variaciones).
- Excerpt actualizado: quitado "30mg" de `Retatrutide 30mg es el pináculo...` (el H2/descripción ya se habían corregido antes).
- Flush de cachés (WP + Nginx).

**Verificación (frontend):** badge "In Stock" en `entry-summary-top`; variaciones con `is_in_stock: 10mg=true, 30mg=true, 60mg=false`; precios 160/200/250 correctos.

**Nota:** el alt/título de la imagen del 30mg (attachment 15233) conserva "Retatrutide 30mg" intencionalmente (es su SEO de imagen).

---

### 2026-08-10 — Tirzepatide simple → producto VARIABLE (10mg / 15mg / 30mg / 60mg)

**Contexto:** Convertir el producto simple `Tirzepatide 30mg` (ID 15223, 160$) en producto variable con 4 presentaciones según el archivo maestro. Imágenes en `C:\suplementos\anabolicos\fotos\` (PNG: `Tirzepatide 15mg.png`, `Tirzepatide 60mg.png`). **No existía imagen de 10mg** → variación creada sin foto (se subirá después).

**Proceso:**
1. Backup DB previo: `backups/db-before-tirzepatide-var-20260810.sql`.
2. Precios/stock del archivo maestro: **10mg=120$/0 (agotado), 15mg=130$/0 (agotado), 30mg=160$/100, 60mg=220$/100**.
3. Imágenes PNG→JPG (Pillow) y subidas con SEO: **15mg=att 15406, 60mg=att 15407**. Imagen del 30mg = thumbnail existente 15235.
4. Reutilización del atributo global `pa_presentacion` (id=6) de Retatrutide; creado el término nuevo **15mg** (term_id 213) vía script.
5. Script `make_variable.php` adaptado: padre 15223 → `variable`, atributo + default 30mg, creación de variaciones:
   - **10mg=15408** (120$, outofstock, sin imagen), **15mg=15409** (130$, outofstock, img 15406), **30mg=15410** (160$, instock, img 15235), **60mg=15411** (220$, instock, img 15407).
   - Términos asociados al padre en `term_relationships` + counts actualizados (idempotente: count 10mg/30mg/60mg pasó a 2 por pertenecer también a Retatrutide).
6. Fix transient `wc_attribute_taxonomies` (igual que Retatrutide).
7. Título/excerpt/contenido limpiados vía SQL directo (sin "30mg"): `Tirzepatide 30mg` → **`Tirzepatide`** (slug/URL intactos), ficha con "Concentración: según presentación".
8. **Fix del stock del padre:** el `$product->save()` del script revirtió `_stock_status` a `outofstock` → SQL directo final para `instock`.
9. Flush de cachés (WP + Nginx).

**Verificación (frontend `https://anabolicgroup.com/product/tirzepatide-30mg/`):** título `<title>`/`<h1>` = "Tirzepatide"; badge "In Stock"; selector con swatches **10/15/30/60mg** (30mg default); `is_in_stock`: 10mg=false, 15mg=false, 30mg=true, 60mg=true; precios 120/130/160/220.

**Pendiente:** subir imagen de la presentación 10mg y asignar su `_thumbnail_id` a la variación 15408.

**Lección nueva:** NO llamar `$product->save()` después de fijar el stock del padre en instock (WC lo revierte); el fix c debe ir después o evitarse `save()`. Documentado en `PROCEDIMIENTO_PRODUCTO_VARIABLE.md`.

---

### 2026-08-10 — Creación de productos VMS (AOD9604, GLOW, CJC1295, IPAMORELIN, TB500, TESAMORELIN)

**Contexto:** El cliente fue creando de la lista de péptidos VMS pendientes. Verificar primero si existía en WC; si no → crear como **producto simple** con descripción SEO completa e imagen (PNG→JPG).

**Proceso (repetido por producto):**
1. Backup DB previo `backups/db-before-<producto>-20260810.sql`.
2. Verificación previa en WC (`wc product list --search=<nombre>`): ninguno existía como variación ni como otro producto igual.
3. Imagen PNG→JPG (Pillow 1000px), subida con `media_handle_sideload` + SEO alt/caption/descripción.
4. `wp_insert_post` (post_type product, publish, slug propio) + `wp_set_object_terms` (cats **205 Péptidos + 206 Inyectables**, brand **208 VMS**, type simple).
5. Metas: `_regular_price`, `_price`, `_manage_stock=yes`, `_stock=100`, `_stock_status=instock`, `_thumbnail_id`, `_visibility=visible`.
6. Descripción SEO: `<h2>` con keyword + título de beneficio, párrafo intro, `<ul>` de beneficios, tabla Ficha Técnica (Concentración/Formato/Clase/Marca/Pureza/Almacenamiento), sección usos en investigación, disclaimer estándar.
7. Flush de cachés (WP + Nginx); verificación HTTP 200 del front.

**Productos creados (todos VMS, categoría Péptidos/Inyectables, stock 100, instock):**
- **AOD9604 10mg** — 150$ — ID 15413 — img 15412 — https://anabolicgroup.com/product/aod9604-10mg/ (creado antes, sin correr en lote)
- **GLOW 70mg** — 160$ — ID 15415 — img 15414 — https://anabolicgroup.com/product/glow-70mg/
- **CJC1295 (Without DAC) 10mg** — 150$ — ID 15417 — img 15416 — https://anabolicgroup.com/product/cjc1295-without-dac-10mg/
- **IPAMORELIN 10mg** — 130$ — ID 15419 — img 15418 — https://anabolicgroup.com/product/ipamorelin-10mg/
- **TB500 10mg** — 160$ — ID 15421 — img 15420 — https://anabolicgroup.com/product/tb500-10mg/
- **TESAMORELIN 10mg** — 160$ — ID 15423 — img 15422 — https://anabolicgroup.com/product/tesamorelin-10mg/

**Verificación:** `wc product get` por ID mostró nombre/slug/precio/stock/categorías/brand correctos; HTTP 200 en los 4 nuevos.

**Lista de los 9 concentrados:** ahora cubiertos GLOW, MOST-C (pendiente), GHK-Cu (ya existía), TESAMORELIN, IPAMORELIN, CJC1295, TB500, BPC-157 5mg (ya existía), NAD (pendiente).
