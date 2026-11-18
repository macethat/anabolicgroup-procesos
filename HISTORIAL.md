# HISTORIAL DE TRABAJO â€” anabolicgroup.com

> Este archivo registra toda la actividad realizada en el proyecto.
> Se actualiza al completar cada tarea.

---

## Estado del proyecto

- **Sitio:** anabolicgroup.com
- **Tipo:** Tienda online (WordPress + WooCommerce)
- **Nicho:** PÃ©ptidos y productos para hipertrofia muscular
- **Hosting anterior:** SiteGround
- **Hosting actual:** panamahosting507.com (desde 2026-08)
- **SSH:** `abgroup@bolic.panamahosting507.com:1230` (acceso por clave pÃºblica ed25519)
- **Stack:** WordPress 7.0.3 Â· WooCommerce Â· Theme Nutritix (+child) Â· Elementor Pro Â· Rank Math SEO Â· paguelofacil + yappy
- **Carpeta local del proyecto:** `C:\anabolicgroup`
- **Repositorio de procesos (GitHub):** `macethat/anabolicgroup-procesos` (https://github.com/macethat/anabolicgroup-procesos)
- **Repositorio nuevo sitio (GitHub):** `macethat/anabolicos-new-site` (https://github.com/macethat/anabolicos-new-site)
- **Regla:** todos los repositorios de GitHub se crean SIEMPRE privados.
- **Subdominio de trabajo:** `test.anabolicgroup.com` (Hestia, sin WordPress)
- **Ruta del sitio en servidor:** `/home/abgroup/web/anabolicgroup.com/public_html/`

---

## Registro de actividad

### 2026-08-10 â€” ConexiÃ³n al nuevo hosting y exploraciÃ³n inicial

**Contexto:** El sitio fue movido de SiteGround a panamahosting507.com. El aviso de "sitio peligroso (phishing)" de Google seguÃ­a activo.

**Tareas completadas:**
1. ConfiguraciÃ³n del acceso SSH mediante clave pÃºblica (ed25519).
2. ConexiÃ³n establecida: `abgroup@bolic.panamahosting507.com` puerto 1230.
3. ExploraciÃ³n inicial del servidor:
   - RaÃ­z del sitio: `/home/abgroup/web/anabolicgroup.com/public_html/`
   - Stack confirmado: WordPress 7.0.3 + WooCommerce
   - Theme activo: **Nutritix** + child theme
   - Plugins relevantes: Elementor Pro, Rank Math SEO, Jetpack, paguelofacil, yappy-bg-para-woocommerce, all-in-one-wp-migration, hestia-nginx-cache
4. Se verificÃ³ que el `.htaccess` del servidor NO contiene aÃºn los security headers (X-Frame-Options, HSTS, CSP, etc.) que se configuraron en el hosting anterior.

**Pendiente / prÃ³ximos pasos:**
- Aplicar los security headers del `.htaccess` local al servidor nuevo (el hosting actual no los tiene).
- Solicitar revisiÃ³n en Google Search Console (aviso de phishing).
- Evaluar estado de plugins/tema y actualizaciones.

---

### 2026-08-10 â€” CreaciÃ³n de historial y repositorio

**Contexto:** Establecer un sistema de registro de actividad en un repositorio Git/GitHub propio, separado de los repos existentes del usuario (psk-wc-sync, psk-sucursales, dashboard-sp, kommo).

**Tareas completadas:**
1. Creado `HISTORIAL.md` en la carpeta local del proyecto (registro continuo de actividad).
2. InicializaciÃ³n de repositorio local Git con rama `main`.
3. ResoluciÃ³n de autenticaciÃ³n de GitHub:
   - El token del Windows Credential Manager estaba **revocado** â†’ se actualizÃ³ por uno nuevo.
   - Nuevo token guardado en el Credential Manager de Windows (persistente para todas las sesiones/proyectos).
   - Configurado header de auth en git local para el push.
4. Creado repositorio remoto **`macethat/anabolicgroup-procesos`** (pÃºblico).
5. Commit inicial subido: `29e9fde` â€” "Inicio: historial de trabajo, htaccess y documentaciÃ³n".
6. Creado `.gitignore` que excluye `accesos.txt` y archivos de credenciales (evitar filtrado de contraseÃ±as).
7. `accesos.txt` (con contraseÃ±as de WordPress/correos) **excluido del repo** por seguridad.

**Nota de seguridad:** Los secretos (contraseÃ±as, tokens) no se guardan en el repo ni en el historial.

**Pendiente:**
- ~~Agregar scope `read:org` al token para habilitar `gh auth login` persistente~~ â†’ **Completado** (gh CLI autenticado en keyring).

---

### 2026-08-10 â€” Security headers en el nuevo hosting (HestiaCP + Cloudflare)

**Contexto:** El sitio fue migrado a panamahosting507.com (panel HestiaCP, Apache + Nginx, con Cloudflare delante). El `.htaccess` del servidor no tenÃ­a los security headers.

**Tareas completadas:**
1. Verificado acceso SSH y estado del `.htaccess` en servidor (solo bloque WordPress, sin headers).
2. Backup del `.htaccess` del servidor: `.htaccess.bak-20260810`.
3. Subido el `.htaccess` con security headers vÃ­a scp:
   - `X-Frame-Options: SAMEORIGIN`
   - `X-Content-Type-Options: nosniff`
   - `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`
   - `Content-Security-Policy: default-src 'self' https: data: 'unsafe-inline' 'unsafe-eval'; frame-ancestors 'self'; base-uri 'self'; form-action 'self';`
4. Verificado directo al origen (IP 159.195.16.126): **todos los headers se sirven correctamente** desde Apache.
5. Detectado que **Cloudflare delante no pasaba los headers** por dominio pÃºblico.
6. Solicitado al hosting (vÃ­a soporte) agregar headers a nivel Cloudflare (Transform Rules â†’ Modify Response Header).
7. **Confirmado:** headers activos vÃ­a dominio pÃºblico (se ven duplicados: origen + CF, normal).
8. Verificado redirect HTTPâ†’HTTPS: **301 OK** vÃ­a Cloudflare.
9. **DiagnÃ³stico de malware:** sin seÃ±ales de compromiso â€” los archivos modificados son de actualizaciones normales de Elementor/Jetpack; sin scripts inyectados en uploads/themes; PHP en uploads son `index.php` vacÃ­os de seguridad de WordPress.

**Pendiente:**
- Solicitar revisiÃ³n en Google Search Console (aviso de phishing).
- Verificar estado exacto en Google Safe Browsing (requiere key API o Search Console).

---

### 2026-08-10 â€” ActualizaciÃ³n del nÃºmero de WhatsApp/WhatsApp en todo el sitio

**Contexto:** El nÃºmero de telÃ©fono cambiÃ³ de `6405-9959` a `6099-0195`. El usuario ya lo habÃ­a actualizado en la pÃ¡gina de Inicio; se requerÃ­a replicarlo en el resto de pÃ¡ginas (Shop, etc.). El header/footer estÃ¡ integrado en cada pÃ¡gina vÃ­a templates Elementor HFE.

**DiagnÃ³stico:**
- Los templates `elementor-hf` activos que se renderizan en las pÃ¡ginas: **Header 4 (3784)**, **Footer 1 (414)**, **Footer bar (1381)**.
- El nÃºmero viejo `6405-9959` estaba en: Header 4 (data+content), Footer 1 (data+content), Inicio 13263 (data+content, restos) y la opciÃ³n del plugin Click to Chat (`ht_ctc_chat_options`).
- Los IDs de postmeta con `6405` que no existen en `posts` son datos huÃ©rfanos (no afectan).

**Tareas completadas:**
1. Backup de DB: `backups/db-before-phone-20260810.sql` (33MB).
2. Instalado WP-CLI en el servidor (`/home/abgroup/web/anabolicgroup.com/wp-cli.phar`).
3. Reemplazo del nÃºmero en Elementor data + post_content de: Header 4 (3784), Footer 1 (414), Inicio (13263):
   - `6405-9959` â†’ `6099-0195`
   - `64059959` â†’ `60990195`
   - `50764059959` â†’ `50760990195`
4. Actualizada la opciÃ³n del plugin **Click to Chat for WhatsApp** (`ht_ctc_chat_options`): `+50764059959` â†’ `+50760990195`.
5. Flush de cachÃ©s: WP cache, Elementor CSS, rewrite rules, cachÃ© Nginx (hestia-cache purge).
6. **Verificado en vivo** en 7 pÃ¡ginas (Inicio, Shop, Mi Cuenta, Carrito, Checkout, Lista de Deseos, Tienda): todas muestran el nÃºmero nuevo, sin restos del viejo. La cachÃ© de Nginx/Cloudflare servÃ­a HTML viejo en Shop; se resolviÃ³ purgando.

**Nota:** Quedan restos de `6405` solo en **revisiones** de Elementor (posts `inherit`, 15391-15399) â€” no se renderizan y no afectan el sitio.

---

### 2026-08-10 â€” âš ï¸ INCIDENTE: CorrupciÃ³n de datos Elementor y restauraciÃ³n

**Contexto:** Tras la actualizaciÃ³n del nÃºmero de telÃ©fono, el usuario reportÃ³ que el sitio quedÃ³ desordenado: Inicio daÃ±ado, y en Shop se perdieron header y footer.

**Causa raÃ­z:** El script de actualizaciÃ³n usÃ³ `wp_update_post()` (API de WordPress) para guardar `post_content` de los templates `elementor-hf` y pÃ¡ginas. Esto disparÃ³ filtros/hooks de WordPress que **corrompieron los JSON de `_elementor_data`** (JSON invÃ¡lido) en:
- Inicio (13263): 41543 â†’ 41253 bytes
- Header 4 (3784): 8894 â†’ 8863
- Footer 1 (414): 16062 â†’ 15938

**Acciones de recuperaciÃ³n:**
1. Backup del estado corrupto: `backups/db-before-restore-20260810.sql` (33.5MB).
2. **RestauraciÃ³n completa de la DB** desde `backups/db-before-phone-20260810.sql` (13:05, estado intacto previo a cambios).
3. Verificado JSON vÃ¡lido de nuevo: Inicio 41543, Header 4 8894, Footer 1 16062.
4. Flush de cachÃ©s (WP, Elementor CSS, Nginx).
5. **Verificado el render en vivo:** Inicio (`elementor-13263`), Shop con Header 4 (3784), Footer 1 (414) y Footer bar (1381) presentes, tÃ­tulos correctos. **Sitio restaurado sin daÃ±o.**

**LECCIÃ“N APRENDIDA (crÃ­tico para futuras ediciones de Elementor):**
- âš ï¸ **NUNCA usar `wp_update_post()` para editar contenido de templates Elementor** (corrompe `_elementor_data`).
- âœ… Para editar Elementor data, usar **`update_post_meta()` directo** (seguro) o **SQL directo**, y solo sobre `_elementor_data`.
- âš ï¸ La opciÃ³n global de Click to Chat (`ht_ctc_chat_options`) quedÃ³ **restaurada al nÃºmero viejo** con la DB â€” debe actualizarse de nuevo de forma segura.

**Estado actual:** Sitio funcional, con nÃºmero viejo `6405-9959` (cambio pendiente de rehacer de forma segura).

---

### 2026-08-10 â€” âœ… ReaplicaciÃ³n segura del nÃºmero de telÃ©fono

**Contexto:** Rehacer el cambio de nÃºmero `6405-9959` â†’ `6099-0195` tras el incidente, usando el mÃ©todo seguro (sin `wp_update_post`).

**MÃ©todo seguro aplicado:**
1. Backup previo: `backups/db-before-phone-safe-20260810.sql`.
2. `_elementor_data` actualizado con **`update_post_meta()`** (sin filtros/hooks de WP) â†’ JSON validado como VÃLIDO en los 3 posts tras cada cambio.
3. `post_content` actualizado con **SQL directo** (`$wpdb->update`) evitando `wp_update_post()`.
4. OpciÃ³n Click to Chat (`ht_ctc_chat_options`) actualizada con `update_option()`: `+50764059959` â†’ `+50760990195`.
5. Flush de cachÃ©s (WP, Elementor CSS, Nginx).

**VerificaciÃ³n en vivo (nÃºmero nuevo presente, sin restos del viejo):**
- `/` Inicio: `6099-0195` + `50760990195` âœ“
- `/shop/`: `50760990195` âœ“ (header 3784, footers 414 + 1381 presentes)
- `/my-account/` (URL correcta, no "mi-cuenta"): âœ“
- `/cart/` y `/checkout/`: âœ“
- **JSON de Elementor vÃ¡lido** en Inicio (13263), Header 4 (3784), Footer 1 (414).

**Notas:**
- Las URLs WooCommerce son `/my-account/` y `/cart/` (no en espaÃ±ol) â€” las URLs `/mi-cuenta/` y `/carrito/` dan 404 (comportamiento normal, no relacionado con el cambio).
- El header/footer del tema (#masthead/#colophon) en pÃ¡ginas WooCommerce sin Elementor es normal (nutritix header-1).

---

### 2026-08-10 â€” âš ï¸ INCIDENTE RECURRENTE: corrupciÃ³n de JSON y resoluciÃ³n definitiva

**Contexto:** El usuario reportÃ³ el sitio "daÃ±ado de nuevo". DiagnÃ³stico completo determinÃ³ que el problema visible era el render mezclado de los dos nÃºmeros (viejo `6405` + nuevo `6099`) y no una pÃ©rdida estructural (JSON seguÃ­a vÃ¡lido, sitio funcional).

**Hallazgos del diagnÃ³stico:**
1. La cachÃ© huÃ©rfana de SiteGround (`wp-content/cache/sgo-cache`) seguÃ­a sirviendo HTML con el nÃºmero viejo â†’ **eliminada** (no era la causa raÃ­z).
2. El render directo al origen (sin Cloudflare) seguÃ­a mezclando nÃºmeros â†’ la fuente real era la **DB**: `_elementor_data` de Header 4 (3784) y Footer 1 (414) contenÃ­a el nÃºmero viejo.
3. **Causa raÃ­z de la corrupciÃ³n JSON recurrente:** incluso `update_post_meta()` sobre `_elementor_data` corrompe el JSON (Elementor guarda el data como string con escapes que WordPress re-procesa). Por eso tras reaplicar con `update_post_meta`, el JSON volvÃ­a a quedar invÃ¡lido (8863/15938/41253 bytes).

**SoluciÃ³n definitiva (aplicada):**
1. RestauraciÃ³n de la DB desde el backup original `backups/db-before-phone-20260810.sql` (JSON vÃ¡lido, estado intacto).
2. Cambio del nÃºmero en `_elementor_data` y `post_content` mediante **SQL directo** (`UPDATE` con `REPLACE` sobre `wp_buDIJ_postmeta` / `wp_buDIJ_posts`), que NO pasa por WordPress ni corrompe nada.
3. ActualizaciÃ³n de la opciÃ³n Click to Chat (`ht_ctc_chat_options`) tambiÃ©n por SQL directo: `+50764059959` â†’ `+50760990195`.
4. Flush de cachÃ©s (WP, Elementor CSS, Nginx/hestia-cache) y eliminaciÃ³n de `sgo-cache`.

**VerificaciÃ³n final (todo en vivo):**
- JSON **VÃLIDO** en los 3 posts: Inicio 41543, Header 4 8894, Footer 1 16062 (longitudes intactas).
- `_elementor_data` de 3784/414/13263: **solo nÃºmero nuevo** (6099), sin restos de 6405.
- Render: `/` y `/shop/` muestran solo `6099-0195` / `50760990195`.
- Click to Chat: `+50760990195`.
- Backup del estado final: `backups/db-final-phone-fixed-20260810.sql`.
- Scripts de diagnÃ³stico temporales eliminados del servidor.

**LECCIÃ“N DEFINITIVA:**
- âš ï¸ **NUNCA usar `wp_update_post()`** sobre contenido Elementor.
- âš ï¸ **NUNCA usar `update_post_meta()` sobre `_elementor_data`** (tambiÃ©n corrompe el JSON).
- âœ… Para editar `_elementor_data`: **solo SQL directo** (`UPDATE` con `REPLACE` sobre la tabla `postmeta`). Luego validar JSON y verificar render en vivo.

**Estado actual:** Sitio funcional, nÃºmero nuevo `6099-0195` en todo el sitio, JSON vÃ¡lido, tarea COMPLETADA.

---

### 2026-08-10 â€” ActualizaciÃ³n de existencias y precios desde archivo maestro

**Contexto:** El cliente subiÃ³ un archivo (`Lista_Anabolicgroup_Maestra_Productos_por_Marca_Editable.numbers`, formato Apple Numbers) con las existencias actuales y precios de los productos. No tienen SKU ni cÃ³digo â†’ comparaciÃ³n por nombre. La columna llamada "SKU" (mal nombrada) tiene 2 estados: `Disponible` y `Agotado`. Los productos sin variaciones (100% productos `simple`). Regla: `Disponible` â†’ **100 unidades**, `Agotado` â†’ **0 unidades**. AdemÃ¡s el archivo es la lista de precios actualizada (hubo incrementos).

**Proceso:**
1. ExtracciÃ³n del `.numbers` (es un zip; datos en IWA) â†’ 93 productos con Marca/CategorÃ­a/Producto/Precio/SKU.
2. Export de WooCommerce vÃ­a WC CLI (166 posts tipo product, 79 publicados; 0 variaciones).
3. Cruce por nombre normalizado + verificaciÃ³n manual de equivalencias (las tiendas tienen nombres largos con descripciones de marketing vs nombres cortos del archivo).
4. Backup DB previo: `backups/db-before-stock-20260810.sql`.
5. AplicaciÃ³n vÃ­a `$wpdb` directo (sin `wp_update_post`): `_regular_price`, `_price`, `_manage_stock=yes`, `_stock` (100/0), `_stock_status` (instock/outofstock).
6. Flush de cachÃ©s (WP + Nginx).

**Resultados:**
- **68 productos actualizados** (61 con cambio de precio, 66 con cambio de stock) â€” verificaciÃ³n post-cambio: 0 errores.
- **25 productos NO existen en WC** â†’ listados en `productos_no_encontrados_para_crear.csv` para crear luego (faltan fotos/datos). Incluyen marcas nuevas (EMINENCE LABS, VMS MOLECULAR SCIENCE pÃ©ptidos, presentaciones LANDERLAN/XTLABS distintas).
- **3 mapeos dudosos omitidos** (Deca-NPP Gold 10ml, Boldenona 200mg Gold 10ml, BPC-157 10mg) por posible dosaje/presentaciÃ³n distinta â€” pendientes de confirmar.

**Archivos generados:**
- `comparativa_existencias_preliminar.csv` (cruce completo archivo vs WC)
- `plan_cambios_stock_precio.csv` (68 cambios aplicados con valores antes/despuÃ©s)
- `productos_no_encontrados_para_crear.csv` (25 a crear: Marca/Producto/Precio/Estado/Stock propuesto)

**Pendiente:**
- Crear los 25 productos faltantes (requiere fotos y confirmar datos).
- Resolver los 3 mapeos dudosos.

---

### 2026-08-10 â€” VerificaciÃ³n de precios VMS y actualizaciÃ³n BPC-157 5mg

**Contexto:** El cliente pidiÃ³ verificar los precios de 16 pÃ©ptidos (GLOW, MOST-C, GHK-Cu, TESAMORELIN, IPAMORELIN, CJC1295, TB500, BPC-157, NAD, AOD9604, Tirzepatide 10/15/30/60, Retatrutide 10/60) contra el sitio. Solo lectura.

**Resultado de la verificaciÃ³n (solo 5 existen en WC):**
- `GHK-Cu 100mg` = 130$ âœ“ (coincide)
- `Tirzepatide 30mg` = 160$ âœ“ (coincide)
- `BPC-157 5mg` = **100$** âœ— (el cliente indicaba 120$)
- `Retatrutide 30mg` = 200$ (no estaba en la lista del cliente pero existe)
- Los otros 13 (GLOW, MOST-C, TESAMORELIN, IPAMORELIN, CJC1295, TB500, NAD, AOD9604, Tirzepatide 10/15/60, Retatrutide 10/60) **no existen** en WC â†’ parte de los 25 pendientes por crear.

**AcciÃ³n realizada:**
- `BPC-157 5mg` (ID 15244): precio actualizado de 100$ a **120$** (regular_price y price) vÃ­a SQL directo. Stock intacto (8).
- Flush de cachÃ©s (WP + Nginx).

**Pendiente:** crear los 13 pÃ©ptidos faltantes con los precios indicados por el cliente (GLOW 160, MOST-C 160, TESAMORELIN 160, IPAMORELIN 130, CJC1295 150, TB500 160, NAD 140, AOD9604 150, Tirzepatide 10=120/15=130/60=220, Retatrutide 10=160/60=220).

---

### 2026-08-10 â€” IGF-1 LR3 1 ml agotado

**Contexto:** El cliente indicÃ³ que el producto en la URL `https://anabolicgroup.com/product/igf-1-lr3-1-ml/` debÃ­a quedar agotado.

**AcciÃ³n:**
- Producto ID 14613 `IGF-1 LR3 1 ml: Hiperplasia + RecuperaciÃ³n`: `_stock` 409 â†’ **0**, `_stock_status` instock â†’ **outofstock** (vÃ­a SQL directo).
- Nota: este producto es distinto del `IGF-1 LR3 1mg` (15248, 120$) del archivo VMS. El archivo maestro no tenÃ­a entrada para el de 1 ml.
- Flush de cachÃ©s (WP + Nginx).

**VerificaciÃ³n:** stock 0 / outofstock confirmado en DB.

---

### 2026-08-10 â€” Retatrutide simple â†’ producto VARIABLE (10mg / 30mg / 60mg)

**Contexto:** El cliente indicÃ³ que el producto `Retatrutide 30mg` (antes simple) debÃ­a pasar a ser un producto variable con 3 presentaciones. ImÃ¡genes nuevas en `C:\suplementos\anabolicos\fotos\` (PNG: `Retatrutide 60mg.png`, `Retratrutide 10mg.png`).

**Proceso:**
1. Backup DB previo: `backups/db-before-retatrutide-var-20260810.sql`.
2. Precios/stock confirmados por el cliente: **10mg=160$/100 Â· 30mg=200$/100 Â· 60mg=250$/0** (60mg agotado; rectificÃ³ de 220 a 250).
3. Atributo creado vÃ­a SQL directo en `woocommerce_attribute_taxonomies` (WC CLI no tiene subcomando para atributos): **`pa_presentacion`** (id=6) con tÃ©rminos **10mg=210, 30mg=211, 60mg=212** (con `register_taxonomy` previo en el script).
4. ImÃ¡genes: PNG convertidas a JPG 1000px (~78KB) y subidas con alt/caption SEO: **10mg=att 15401, 60mg=att 15402** (30mg ya tenÃ­a 15233).
5. Script `make_variable.php` (`$wpdb`): producto 15229 â†’ tipo `variable`, atributo `pa_presentacion` visible/variaciÃ³n, default 30mg, borrado de metas precio/stock del padre, creaciÃ³n de 3 variaciones.
6. DescripciÃ³n reescrita (vÃ­a SQL directo) sin mencionar "30mg" en H2/primer pÃ¡rrafo; ficha tÃ©cnica con "ConcentraciÃ³n: segÃºn presentaciÃ³n".
7. Renombrado el producto: tÃ­tulo `Retatrutide 30mg` â†’ **`Retatrutide`** (vÃ­a SQL directo; slug/URL intactos).
8. Flush de cachÃ©s (WP + Nginx).

**Resultado (verificado en frontend `https://anabolicgroup.com/product/retatrutide-30mg/`):**
- Producto padre 15229: `product-type-variable`, `variations_form`, H1 `<title>` = "Retatrutide".
- Variaciones: **10mg** (15403, 160$, instock, img 15401) Â· **30mg** (15404, 200$, instock, img 15233) Â· **60mg** (15405, 250$, outofstock, img 15402).
- Selector muestra las 3 presentaciones con precios y estado de stock correctos.

**Archivos relacionados (local):** `make_variable.php`, `create_attribute.php`, `upload_imgs.php`. Scripts temporales eliminados del servidor.

---

### 2026-08-10 â€” Fix: selector de presentaciones del Retatrutide variable no aparecÃ­a

**SÃ­ntoma:** En la pÃ¡gina del producto variable no habÃ­a forma de seleccionar las presentaciones; la tabla `variations` del front salÃ­a con `<tbody>` vacÃ­o (sin swatches ni `<select>`).

**Causa raÃ­z (2 capas):**
1. **Transient `wc_attribute_taxonomies` obsoleto:** el atributo `pa_presentacion` se creÃ³ vÃ­a SQL directo en `woocommerce_attribute_taxonomies`, pero WooCommerce registra las taxonomÃ­as globales desde el transient `_transient_wc_attribute_taxonomies` (cacheado con solo 5 atributos) â†’ `pa_presentacion` nunca se registraba como taxonomÃ­a en el front â†’ el template variable no generaba la fila del selector.
2. **TÃ©rminos sin asociar al producto:** los tÃ©rminos 10mg/30mg/60mg existÃ­an en `terms`/`term_taxonomy` (count=0) pero **no estaban en `term_relationships`** del producto padre (15229) â†’ aunque la taxonomÃ­a se registrara, el dropdown saldrÃ­a vacÃ­o. WooCommerce muestra solo los tÃ©rminos relacionados al post.

**SoluciÃ³n (SQL directo):**
- `DELETE` del transient `wc_attribute_taxonomies` (+ timeout) â†’ WooCommerce releyÃ³ la tabla y registrÃ³ `pa_presentacion`.
- `INSERT IGNORE` en `term_relationships` (object_id=15229 â†” term_taxonomy_id 210/211/212) + actualizaciÃ³n de `count` en `term_taxonomy`.
- Flush de cachÃ©s (WP + Nginx).

**VerificaciÃ³n (frontend):** selector con swatches del plugin woo-variation-swatches: botones `10mg / 30mg (preseleccionado) / 60mg`, select oculto de respaldo con las 3 opciones, botÃ³n "Limpiar". Los 3 precios/stock siguen correctos (160/100, 200/100, 250/0).

**LecciÃ³n:** al crear atributos/tÃ©rminos por SQL (sin pasar por `wc_create_attribute()`/`wp_set_object_terms()`), hay que (a) invalidar el transient `wc_attribute_taxonomies` y (b) asignar los tÃ©rminos al producto en `term_relationships`; de lo contrario el selector de variaciones queda vacÃ­o.

---

### 2026-08-10 â€” Fix: badge "Out of Stock" en Retatrutide variable (stock del padre)

**SÃ­ntoma:** tras arreglar el selector, el front mostraba "Out of Stock" junto al tÃ­tulo aunque 2 de 3 variaciones estaban disponibles.

**Causa:** el producto padre (15229) conservaba `_stock_status=outofstock` (reliquia de cuando fue producto simple). El theme Nutritix muestra el badge de disponibilidad leyendo el stock del **padre**, no el de las variaciones.

**SoluciÃ³n (SQL directo):**
- `_stock_status` del padre 15229 â†’ `instock` (el stock real lo manejan las variaciones).
- Excerpt actualizado: quitado "30mg" de `Retatrutide 30mg es el pinÃ¡culo...` (el H2/descripciÃ³n ya se habÃ­an corregido antes).
- Flush de cachÃ©s (WP + Nginx).

**VerificaciÃ³n (frontend):** badge "In Stock" en `entry-summary-top`; variaciones con `is_in_stock: 10mg=true, 30mg=true, 60mg=false`; precios 160/200/250 correctos.

**Nota:** el alt/tÃ­tulo de la imagen del 30mg (attachment 15233) conserva "Retatrutide 30mg" intencionalmente (es su SEO de imagen).

---

### 2026-08-10 â€” Tirzepatide simple â†’ producto VARIABLE (10mg / 15mg / 30mg / 60mg)

**Contexto:** Convertir el producto simple `Tirzepatide 30mg` (ID 15223, 160$) en producto variable con 4 presentaciones segÃºn el archivo maestro. ImÃ¡genes en `C:\suplementos\anabolicos\fotos\` (PNG: `Tirzepatide 15mg.png`, `Tirzepatide 60mg.png`). **No existÃ­a imagen de 10mg** â†’ variaciÃ³n creada sin foto (se subirÃ¡ despuÃ©s).

**Proceso:**
1. Backup DB previo: `backups/db-before-tirzepatide-var-20260810.sql`.
2. Precios/stock del archivo maestro: **10mg=120$/0 (agotado), 15mg=130$/0 (agotado), 30mg=160$/100, 60mg=220$/100**.
3. ImÃ¡genes PNGâ†’JPG (Pillow) y subidas con SEO: **15mg=att 15406, 60mg=att 15407**. Imagen del 30mg = thumbnail existente 15235.
4. ReutilizaciÃ³n del atributo global `pa_presentacion` (id=6) de Retatrutide; creado el tÃ©rmino nuevo **15mg** (term_id 213) vÃ­a script.
5. Script `make_variable.php` adaptado: padre 15223 â†’ `variable`, atributo + default 30mg, creaciÃ³n de variaciones:
   - **10mg=15408** (120$, outofstock, sin imagen), **15mg=15409** (130$, outofstock, img 15406), **30mg=15410** (160$, instock, img 15235), **60mg=15411** (220$, instock, img 15407).
   - TÃ©rminos asociados al padre en `term_relationships` + counts actualizados (idempotente: count 10mg/30mg/60mg pasÃ³ a 2 por pertenecer tambiÃ©n a Retatrutide).
6. Fix transient `wc_attribute_taxonomies` (igual que Retatrutide).
7. TÃ­tulo/excerpt/contenido limpiados vÃ­a SQL directo (sin "30mg"): `Tirzepatide 30mg` â†’ **`Tirzepatide`** (slug/URL intactos), ficha con "ConcentraciÃ³n: segÃºn presentaciÃ³n".
8. **Fix del stock del padre:** el `$product->save()` del script revirtiÃ³ `_stock_status` a `outofstock` â†’ SQL directo final para `instock`.
9. Flush de cachÃ©s (WP + Nginx).

**VerificaciÃ³n (frontend `https://anabolicgroup.com/product/tirzepatide-30mg/`):** tÃ­tulo `<title>`/`<h1>` = "Tirzepatide"; badge "In Stock"; selector con swatches **10/15/30/60mg** (30mg default); `is_in_stock`: 10mg=false, 15mg=false, 30mg=true, 60mg=true; precios 120/130/160/220.

**Pendiente:** subir imagen de la presentaciÃ³n 10mg y asignar su `_thumbnail_id` a la variaciÃ³n 15408.

**LecciÃ³n nueva:** NO llamar `$product->save()` despuÃ©s de fijar el stock del padre en instock (WC lo revierte); el fix c debe ir despuÃ©s o evitarse `save()`. Documentado en `PROCEDIMIENTO_PRODUCTO_VARIABLE.md`.

---

### 2026-08-10 â€” CreaciÃ³n de productos VMS (AOD9604, GLOW, CJC1295, IPAMORELIN, TB500, TESAMORELIN)

**Contexto:** El cliente fue creando de la lista de pÃ©ptidos VMS pendientes. Verificar primero si existÃ­a en WC; si no â†’ crear como **producto simple** con descripciÃ³n SEO completa e imagen (PNGâ†’JPG).

**Proceso (repetido por producto):**
1. Backup DB previo `backups/db-before-<producto>-20260810.sql`.
2. VerificaciÃ³n previa en WC (`wc product list --search=<nombre>`): ninguno existÃ­a como variaciÃ³n ni como otro producto igual.
3. Imagen PNGâ†’JPG (Pillow 1000px), subida con `media_handle_sideload` + SEO alt/caption/descripciÃ³n.
4. `wp_insert_post` (post_type product, publish, slug propio) + `wp_set_object_terms` (cats **205 PÃ©ptidos + 206 Inyectables**, brand **208 VMS**, type simple).
5. Metas: `_regular_price`, `_price`, `_manage_stock=yes`, `_stock=100`, `_stock_status=instock`, `_thumbnail_id`, `_visibility=visible`.
6. DescripciÃ³n SEO: `<h2>` con keyword + tÃ­tulo de beneficio, pÃ¡rrafo intro, `<ul>` de beneficios, tabla Ficha TÃ©cnica (ConcentraciÃ³n/Formato/Clase/Marca/Pureza/Almacenamiento), secciÃ³n usos en investigaciÃ³n, disclaimer estÃ¡ndar.
7. Flush de cachÃ©s (WP + Nginx); verificaciÃ³n HTTP 200 del front.

**Productos creados (todos VMS, categorÃ­a PÃ©ptidos/Inyectables, stock 100, instock):**
- **AOD9604 10mg** â€” 150$ â€” ID 15413 â€” img 15412 â€” https://anabolicgroup.com/product/aod9604-10mg/ (creado antes, sin correr en lote)
- **GLOW 70mg** â€” 160$ â€” ID 15415 â€” img 15414 â€” https://anabolicgroup.com/product/glow-70mg/
- **CJC1295 (Without DAC) 10mg** â€” 150$ â€” ID 15417 â€” img 15416 â€” https://anabolicgroup.com/product/cjc1295-without-dac-10mg/
- **IPAMORELIN 10mg** â€” 130$ â€” ID 15419 â€” img 15418 â€” https://anabolicgroup.com/product/ipamorelin-10mg/
- **TB500 10mg** â€” 160$ â€” ID 15421 â€” img 15420 â€” https://anabolicgroup.com/product/tb500-10mg/
- **TESAMORELIN 10mg** â€” 160$ â€” ID 15423 â€” img 15422 â€” https://anabolicgroup.com/product/tesamorelin-10mg/

**VerificaciÃ³n:** `wc product get` por ID mostrÃ³ nombre/slug/precio/stock/categorÃ­as/brand correctos; HTTP 200 en los 4 nuevos.

**Lista de los 9 concentrados:** ahora cubiertos GLOW, MOST-C (pendiente), GHK-Cu (ya existÃ­a), TESAMORELIN, IPAMORELIN, CJC1295, TB500, BPC-157 5mg (ya existÃ­a), NAD (pendiente).

---

### 2026-08-10 â€” CreaciÃ³n de producto NAD+ 500mg (VMS simple)

**Contexto:** ContinuaciÃ³n de la lista de pÃ©ptidos VMS. El cliente subiÃ³ la imagen `nad+ 500mg.png`.

**Proceso:**
1. VerificaciÃ³n previa: no existÃ­a NAD 500mg en WC (bÃºsqueda por tÃ­tulo `%NAD%` solo matcheÃ³ "CHORIONIC GONADOTROPHIN" por fragmento; `wc product list --search=NAD` devolvÃ­a coincidencias parciales irrelevantes).
2. Backup DB: `backups/db-before-nad-20260810.sql`.
3. Imagen PNGâ†’JPG (Pillow) y subida con SEO: **NAD+ 500mg = att 15424**.
4. `wp_insert_post` (simple, publish, slug `nad-500mg`) + cats PÃ©ptidos/Inyectables (205/206) + brand VMS (208).
5. Precio **140$** (archivo maestro), stock 100, instock; descripciÃ³n SEO completa (energÃ­a celular, reparaciÃ³n ADN, sirtuinas, ficha tÃ©cnica, disclaimer).
6. Flush de cachÃ©s (WP + Nginx).

**Resultado:** **NAD+ 500mg** â€” ID 15425 â€” img 15424 â€” https://anabolicgroup.com/product/nad-500mg/ â€” HTTP 200.

**De la lista de 9 concentrados queda pendiente:** **MOST-C 40mg** (160$, disponible).


### 2026-08-19 — Tirzepatide: imagen faltante presentación 10mg (variación 15408)

**Contexto:** El cliente subio la imagen `tirzepatide 10mg.jpg` que faltaba para completar la ficha del producto variable Tirzepatide (pendiente registrado el 2026-08-10).

**Proceso:**
1. Imagen origen C:\suplementos\anabolicos\fotos\tirzepatide 10mg.jpg (1254x1254 RGB) optimizada a 1000px JPG (78KB, quality=88) como 	irzepatide-10mg.jpg.
2. Subida via media_handle_sideload con SEO: titulo "Tirzepatide 10mg", alt "Tirzepatide 10mg triple agonista GIP/GLP-1 metabolico", caption "Tirzepatide 10 mg - triple agonista GIP/GLP-1" -> **attachment 15428**.
3. Asignado _thumbnail_id = 15428 a la variacion **15408 (10mg)** via SQL directo (sin save() del padre).
4. Limpieza temporales del servidor + flush cache (WP + Hestia).

**Verificacion (front https://anabolicgroup.com/product/tirzepatide-30mg/):**
- data-product_variations de la variacion 10mg (15408): image_id:15428, alt/caption SEO correctos, precios , is_in_stock:false (sigue agotada segun maestro).
- Swatches selector intactos: [10mg, 15mg, 30mg, 60mg].
- 15mg (15409) y 60mg (15411) mantienen sus imagenes 15406/15407; 30mg (15410) conserva 15235.



### 2026-08-19 — Creacion de producto MOTS-C 40mg (VMS simple)

**Contexto:** Cierre de la lista de peptidos VMS pendientes. El cliente subio la imagen `mots-c.jpg` en `C:\suplementos\anabolicos\fotos\`.

**Proceso (protocolo VMS):**
1. Backup DB previo: `backups/db-before-mostc-20260819.sql`.
2. Verificacion previa: no existia MOTS-C/MOST-C en WC (wc product list + query SQL por patron MOT/MITS).
3. Imagen JPG (1254x1254) optimizada a 1000px/68KB y subida con SEO: **MOTS-C 40mg = att 15429** (alt "MOTS-C 40mg peptido mitocondrial VMS Molecular Science", caption "MOTS-C 40 mg - peptido mitocondrial regulador metabolico").
4. `wp_insert_post` (simple, publish, slug `mots-c-40mg`) + cats **205 Peptidos + 206 Inyectables** + brand **208 VMS**.
5. Precio **160$** (archivo maestro), stock 100, instock; descripcion SEO completa (AMPK, oxidacion de grasas, salud mitocondrial, ficha tecnica, usos en investigacion, disclaimer).
6. Flush caches (WP + Hestia).

**Resultado:** **MOTS-C 40mg** — ID 15430 — img 15429 — https://anabolicgroup.com/product/mots-c-40mg/ — HTTP 200, title/H1/alt/stock correctos.

**Lista de 9 concentrados VMS: COMPLETADA** (a falta de revisar BPC-157 10mg/150$ que hoy es 5mg/120$).

### 2026-08-19 — Fix: palabras cortadas en tablas de descripcion larga (ficha tecnica)

**Sintoma:** En la descripcion larga de los productos (tab Ficha Tecnica / Descripcion), las palabras largas se cortaban en vez de bajar a la siguiente linea.

**Causa raiz:** El custom CSS previo para tablas vivia en `functions.php` del theme **nutritix-child**, pero el theme activo en el sitio es **nutritix** (sin child): `stylesheet=nutritix, template=nutritix`. Por eso el fix nunca se cargaba en el front.

**Solucion (CSS en customizer del theme activo):**
- Guardado el CSS en el post de custom CSS del customizer `wp_buDIJ_posts ID=14170` (post_type `custom_css`, referenciado por `theme_mods_nutritix.custom_css_post_id=14170`) vía **SQL directo** (UPDATE, no wp_update_post):
``css
.content-area td, #primary td, .content-area th, #primary th,
.woocommerce-Tabs-panel table td, .woocommerce-Tabs-panel table th {
    overflow-wrap: break-word !important;
    word-break: break-word !important;
    white-space: normal !important;
}
``
- Backup previo del child `functions.php` (se intento el hook alli primero y se descarto al detectar que el child no esta activo); si se usara el child en el futuro, ese hook ya esta documentado.
- Flush de caches (WP + Hestia).

**Verificacion (front):** en `https://anabolicgroup.com/product/mots-c-40mg/` y `/product/nad-500mg/` el custom CSS se inyecta (`word-break: break-word` presente en el HTML).

**Leccion:** Antes de aplicar un fix via child theme, confirmar el theme activo con get_option('stylesheet'). Si el sitio corre el theme base (nutritix), el custom CSS del customizer (post custom_css) es la via que si se renderiza.
### 2026-08-19 - Fix v2: titulos largos en tablas de fichas tecnicas (word-break normal + min-width)

**Sintoma:** Tras el fix v1 (word-break: break-word), los titulos largos de la primera columna (ej. "Caracteristica", "Concentracion") se rompian a mitad de palabra pese a bajar de linea.

**Solucion (v2, mismo custom CSS 14170):**
- word-break: break-word -> **word-break: normal**: las palabras largas ahora bajan COMPLETAS a la siguiente linea (solo se parten si rebasan el ancho total de la celda).
- Columna de etiquetas: width: 32% + min-width: 170px en 	d/th:first-child para dar ancho estable a las cabeceras.
- Extendido a tablas en entry-content (no solo woocommerce-Tabs-panel) para cubrir tablas en otros contenidos.
- ertical-align: top y padding uniforme 8px 12px en todas las celdas.
- 	able-layout: auto + width: 100% en la tabla.

**Aplicado:** UPDATE directo a wp_buDIJ_posts.post_content WHERE ID=14170 (custom CSS del customizer), flush WP + Hestia.

**CSS final (post 14170):**
`css
.woocommerce-Tabs-panel table, .entry-content table { width: 100%; table-layout: auto; }
.woocommerce-Tabs-panel table td, .woocommerce-Tabs-panel table th,
.entry-content table td, .entry-content table th {
    overflow-wrap: break-word !important;
    word-break: normal !important;
    white-space: normal !important;
    vertical-align: top;
    padding: 8px 12px;
}
.woocommerce-Tabs-panel table td:first-child, .woocommerce-Tabs-panel table th:first-child,
.entry-content table td:first-child, .entry-content table th:first-child {
    width: 32%; min-width: 170px;
}
`

**Verificacion:** en https://anabolicgroup.com/product/mots-c-40mg/ el bloque CSS nuevo (word-break: normal + min-width: 170px) se inyecta correctamente.
### 2026-08-19 - Ficha completa Decaprime NPP 100 mg (14491): imagen, marca, titulo y descripciones

**Contexto:** El cliente confirmo que la foto `decaprime.jpg` corresponde al producto publicado `https://anabolicgroup.com/product/dacaprime-npp-100-mg/` (14491). Falta de imagen, sin marca, nombre inconsistente (Dacaprime vs DECAPRIME del draft) y descripciones mejorables.

**Proceso:**
1. Backup DB previo: `backups/db-before-decaprime-ficha-20260819.sql`.
2. Imagen `decaprime.jpg` (1080x1080) optimizada a 1000px/117KB y subida con SEO: **att 15431** (alt "Decaprime NPP 100 mg nandrolona fenilpropionato Eminence Labs", caption "Decaprime NPP 100 mg - nandrolona fenilpropionato (NPP)"). Asignada como `_thumbnail_id` de 14491.
3. Marca **EMINENCE** (term 201) asignada via `wp_set_object_terms`.
4. Titulo corregido `Dacaprime` -> `Decaprime NPP 100 mg: Volumen Rapido + Articulaciones` + excerpt + contenido SEO completo (beneficios, ficha tecnica en tabla, uso referencial, disclaimer) via `->prepare`/SQL directo (sin wp_update_post para no corromper contenido).
5. Draft duplicado **14992** `DECAPRIME NPP 100 MG` (sin precio, con imagen 14993) enviado a papelera (`post_status=trash`; WC no soporta trash via CLI, se hace por SQL).
6. Flush caches (WP + Hestia).

**Verificacion (front `/product/dacaprime-npp-100-mg/`):** HTTP 200; title/H1 "Decaprime NPP 100 mg: Volumen Rapido + Articulaciones"; imagen `decaprime-npp-100-mg.jpg` como wp-post-image con alt SEO; marca EMINENCE visible; tabla ficha tecnica presente. Slug intacto `dacaprime-npp-100-mg` (sin redirecciones rotas).

**Nota:** el slug conserva `dacaprime` por compatibilidad de URLs; el titulo nuevo es `Decaprime` (nombre real del producto Eminence).

### 2026-08-20 - Export CSV de todos los productos por marca

**Contexto:** El maestro pidio un CSV de todos los productos (activos e inactivos) segmentados por marca, con nombre, existencia y precio.

**Proceso:**
1. Query `query_csv_expo.sql` (post_type='product', post_status IN publish/draft/trash/pending/private/future, tipo, marca hija de product_brand via `parent<>0`, precio regular, stock) ejecutada con `wp db query` -> `export_raw.tsv` (175 filas).
2. Query `query_var_stock.sql` para sumar stock de variaciones y rango de precio de los 2 productos variable (Retatrutide 15229: 200u 120-220; Tirzepatide 15223: 200u 160-250).
3. Script `plantillas/make_csv_productos.py` genera `productos_todos_por_marca.csv` (UTF-8 BOM, bloques `=== MARCA ===` con ACTIVO primero, columnas MARCA/STATUS/NOMBRE/EXISTENCIA/PRECIO).

**Resultado:** 174 productos. EMINENCE 18 activos + 26 inactivos, LANDERLAN 22+30, VMS 14 activos, XTLABS 33+12, SIN MARCA 19 inactivos (drafts ARENIS y combos sin marca asignada, sin stock).

**Pendiente / observaciones:**
- Los 19 drafts `SIN MARCA` (serie ARENIS y combos tipo "TestoMix 250mg + OxymePrime") son productos viejos sin marca ni stock; conviene decidir: asignar marca ARENIS (no existe como brand) o descartarlos/papelera.
- Archivo local de entrega: `C:\anabolicgroup\productos_todos_por_marca.csv`.

### 2026-08-29 - Actualizacion de precios segun maestro Numbers (Lista_Anabolicgroup_Maestra)

**Contexto:** El cliente dejo en `C:\suplementos\anabolicos\existencias\` el archivo `Lista_Anabolicgroup_Maestra_Productos_por_Marca_Editable.numbers` (Apple Numbers, Windows no lo abre) con la actualizacion de precios para WooCommerce. Pidio analizarlo, aplicar los cambios confirmados y emitir archivo con la info.

**Analisis:**
1. El archivo Numbers se leyo con la libreria Python `numbers-parser` (93 productos, columnas Marca/Categoria/Producto/Precio/Disponible/SKU vacio).
2. Se cruzo contra la tienda (174 productos) por nombre + marca real de cada producto (`product_brand` hijo) para evitar falsos matches.
3. Se exporto `maestro_precios_woocommerce.csv` (lista completa) y `actualizacion_precios_vs_tienda.csv` (cruce).
4. Falsos positivos descartados por marca (ej. Stanozolol 50mg maestro=EMINENCE vs Stanozoland publicado=LANDERLAN; Klembuterol EMINENCE vs Clenbuterol LANDERLAN, etc.).
5. Caso especial BPC-157 (15244): maestro pide 10mg/150 pero existe 5mg/120 - pendiente de decision del maestro (no es simple cambio de precio).

**Cambios aplicados (14 productos simples, backups previos):**
- Lote 1 (confirmados por nombre+marca): Mastaplex 14614 47.99->64.99; Trembolona Acetato 14364 65.99->74.99; Clenbutrex Ultra 14603 51.99->64.99; Arimidex 14293 48.99->59.99; Clenbutrex HCL 14602 48.99->59.99; Boldenona 14556 58.99->64.99; Testo Propionato 14580 30.23->64.99; Trembolona Enantato 14599 64.99->74.99; Stanozoland 50-15ml 14850 38.99->64.99; Decaprime NPP 14491 51.99->59.99.
- Lote 2 (confirmados por MARCA): Cloprime 14487 46.99->49.99; Metenolona Enantato 14773 83.12->99.99; Metandrostenolona 14044 47.99->64.99; OXANDROLAND 14050 57.93->74.99.
- Revertido: Semaglutide 15256 110.00->120.00 (vuelto a precio original por indicacion del maestro).

**Sin cambios:** Tirzepatide (15223) y Retatrutide (15229) ya tenian los precios exactos del maestro en sus variaciones (120/130/160/220 y 160/200/250). Stanozolol LANDERLAN sin cambios (maestro coincide con tienda: 30ml=89, 15ml=64.99).

**Backups:** `backups/db-before-precios-maestro-20260829.sql`, `backups/db-before-precios-maestro-batch2-20260829.sql`.

**Archivos locales:** `C:\anabolicgroup\cambios_precios_aplicados_20260829.csv` (14 cambios, UTF-8 BOM), `C:\anabolicgroup\dudas_precios_por_revisar.csv`, `C:\anabolicgroup\maestro_precios_woocommerce.csv`.

### 2026-10-20 - Fichas de la seccion "EMINENCE AGREGAR" (linea Prime)

**Contexto:** La empresa confirmo que los productos de la seccion "EMINENCE AGREGAR" del archivo `cat-prod-actualizado.xlsx` deben agregarse. Se trabajo con los subagentes contenidos-ecommerce, seo-ecommerce y geo-ecommerce; marketing-descriptions declino redactar copy de conversion por tratarse de medicamentos de prescripcion/sustancias controladas (riesgo legal/sanitario). Se opto por fichas informativas (sin ganchos de venta), con aviso de consultar al medico y el disclaimer de la empresa.

**Hallazgo clave:** al leer las etiquetas de las 5 fotos se confirmo que los 5 borradores del listado eran la linea "Prime" y 4 ya existian con otro ID:
- 14315 "Stanozolol 50mg x 50 comp" = StanoPrime 50 mg/ml 10 amp IM -> duplicado del publicado 14546.
- 14318 "Methandrostenolona 10mg" = MetaPrime (Methandienone) 10 mg 50 tab -> duplicado del borrador 14511.
- 14326 "Klembuterol 0.60mcg" = KlenPrime 60 (Clenbuterol 60 mcg) 50 tab -> duplicado del borrador 14502 (y la unidad correcta es 60 mcg, no 0.60).
- 14995 "CHORIONIC GONADOTROPHIN" = Hormoprime HCG 5000 IU 1 vial -> duplicado del borrador vacio 15206.
- 14508 "LIOPRIME 25 MCG" = LioPrime (Liothyronine 25 mcg) 50 tab -> unico.

**Proceso (script `armar_fichas_prime.php` con $wpdb->update, nunca wp_update_post):**
1. Se armaron fichas en los productos Prime: 14511 MetaPrime 10 mg, 14502 KlenPrime 60 mcg, 14508 LioPrime 25 mcg, 14995 renombrado "Hormoprime HCG 5000 UI" (slug `hormoprime-hcg-5000-ui`).
2. Contenido: descripcion factual + Ficha Tecnica en tabla + "Uso Referencial" con aviso "Consulta a tu medico antes de consumir este tipo de productos" + Disclaimer de la empresa (texto identico a los productos recientes). Sin ganchos de venta.
3. Precios del maestro aplicados: MetaPrime 59.99, KlenPrime 64.99, LioPrime 64.99, HCG 64.99.
4. SEO (Rank Math): title, meta description y focus keyword por ficha. Alt text de las imagenes.
5. Duplicados genericos a papelera: 14315, 14318, 14326, 15206.
6. Stanozolol queda en 14546 Stanoprime 50 mg (publicado, 43.99, ya con ficha).

**Publicacion y existencia (2026-10-20):** las 4 fichas se PUBLICARON con la regla historica de existencia (`_manage_stock=yes`, `_stock=100`, `_stock_status=instock`, `_backorders=no`, `_visibility=visible`) — igual que MOTS-C y los VMS.
- MetaPrime 10 mg -> https://anabolicgroup.com/product/metaprime-10-mg/ (HTTP 200, "disponible")
- KlenPrime 60 mcg -> https://anabolicgroup.com/product/klenprime-60-mcg/ (HTTP 200, "disponible")
- LioPrime 25 mcg -> https://anabolicgroup.com/product/lioprime-25-mcg/ (HTTP 200, "disponible")
- Hormoprime HCG 5000 UI -> https://anabolicgroup.com/product/hormoprime-hcg-5000-ui/ (HTTP 200, "disponible")

**Backup:** `backups/db-before-fichas-prime-20261020.sql`.

**Pendiente:** decidir si se sube Stanoprime 14546 a 59.99 (el maestro traia 59.99 en la fila mal etiquetada "Stanozolol 50mg x 50 comp").

### 2026-10-20 - Revision de ultimos cambios (Decaprime 200 mg)

- **Decaprime 200 mg (14493):** precio corregido 51.99 -> **59.99** (maestro Numbers: EMINENCE "Nandrolona (Deca) 200mg" = 59.99) y marcado **agotado** (`_stock=0`, `_stock_status=outofstock`; el cat-prod-actualizado lo lista en "EMINENCE SIN STOCK"). Verificado en front: /product/decaprime-200-mg/ muestra 59.99 y `stock out-of-stock`.
- **Stanoprime 50 mg (14546):** precio corregido 43.99 -> **59.99** (maestro Numbers: EMINENCE "Stanozolol 50mg" inyectable = 59.99) y marcado **agotado** (`_stock=0`, `_stock_status=outofstock`; cat-prod-actualizado lo lista en "EMINENCE SIN STOCK"). Verificado en front: /product/stanoprime-50-mg/ muestra 59.99 y `stock out-of-stock`.

### 2026-11-17 - Creacion del subdominio de trabajo test.anabolicgroup.com (sin WordPress)

**Contexto:** El cliente pidio activar el subdominio `test.anabolicgroup.com` para trabajar/staging, sin vincularlo a WordPress.

**Diagnostico inicial:** el DNS existia en Cloudflare, pero el servidor NO tenia vhost ni docroot (solo `anabolicgroup.com`), y la URL publica caia en el servidor por defecto de nginx ("Success! Your new web server is ready to use.") con un bucle de redireccion https->http->https.

**Acciones:**
1. Se creo el dominio en Hestia (panel en `bolic.panamahosting507.com:8083`, usuario abgroup) via el formulario `/add/web/` -> subdominio creado con docroot `/home/abgroup/web/test.anabolicgroup.com/public_html` y vhost `/etc/nginx/conf.d/domains/test.anabolicgroup.com.conf`.
2. Se coloco un `index.html` de prueba ("Subdominio activo", sin WordPress) + `robots.txt` (Hestia por defecto).
3. SSL en el origen: NO se pudo aplicar desde el panel (el SSL del plan de hosting parece deshabilitado) y Let's Encrypt fallo porque Cloudflare intercepta el desafio HTTP-01.
4. **Solucion al bucle:** se aplico en Cloudflare una regla por hostname con SSL en modo "Flexible" solo para `test.anabolicgroup.com` (no se toco el modo global de la zona, que sigue Full/strict con Origin Certificate).

**Verificacion (2026-11-17):**
- `test.anabolicgroup.com`: HTTPS **200**, `verify=0`, certificado Let's Encrypt valido (17-nov-2026 -> 15-feb-2027), HTTP -> 301 a HTTPS. Sirve el index de prueba. Sin WordPress.
- `anabolicgroup.com` (principal): HTTPS 200, `verify=0`; certificado edge Cloudflare/GTS (10-nov-2026 -> 8-feb-2027) y Origin Certificate en el origen (hasta 2041); HTTP -> 301 a HTTPS. SSL valido confirmado.
- `www.anabolicgroup.com`: resuelve a Cloudflare, certificado valido, 301 -> `https://anabolicgroup.com/`.

**Nota de seguridad:** los scripts locales de Hestia se sanitizaron (sin contrasena ni token) antes de commitear. `accesos.txt` sigue en `.gitignore`.

### 2026-11-17 - Analisis de viabilidad: sitio catalogo Python + MySQL en test.anabolicgroup.com

**Objetivo:** tienda-catalogo (sin pasarela de pago) con boton de contacto por WhatsApp, construida en Python + MySQL, replicando un sitio modelo con colores y variaciones de diseno minimas.

**Hallazgos del entorno:**
- Python 3.12.3 + `venv` OK; **sin pip** (se bootstrapea con `get-pip.py`; salida a internet OK, pypi 200).
- MySQL/MariaDB local (`bind-address = 127.0.0.1`, sin acceso remoto). Creacion de BD desde el panel Hestia (mysql, localhost, utf8mb4, ilimitadas) -> **lo hacemos nosotros**.
- Apache con `AllowOverride All`; modulos `proxy`, `proxy_fcgi`, `rewrite`, `fcgid`; **`proxy_http` NO habilitado**.
- nginx del subdominio **no editable** por el usuario (root).
- `systemd --user` con **`linger=yes`** (los servicios de usuario persisten).
- Backups: los hacemos nosotros (`mysqldump` + `tar` + cron).

**Plan acordado:** construir todo lo demas (BD, app Python, plantillas, carga de datos) y dejar el **reverse proxy como ultimo paso** a cargo del admin del hosting (1 linea: `proxy_pass` a `127.0.0.1:8000` o habilitar `proxy_http`). Mientras tanto, pruebas por tunel SSH (`localhost:8000`). Alternativas sin hosting: `proxy_fcgi` + FastCGI, o Python generando sitio estatico.

**Pendiente de insumos:** lista de productos, URL del sitio modelo, colores/logo y numero de WhatsApp.

### 2026-11-17 - Fase 1 completada: entorno Python + MySQL + esqueleto (test.anabolicgroup.com)

- **Base de datos:** creada desde el panel Hestia -> **`abgroup_catalogo`** (usuario `abgroup_catalogo@localhost`, utf8mb4). Esquema cargado: `brands`, `categories`, `products`, `presentations`, `settings`.
- **Python:** `venv` en `/home/abgroup/catalogo/.venv` (bootstrap de pip 26.3 con `get-pip.py`), instalados Flask 3.1.3, Gunicorn, PyMySQL y python-dotenv.
- **Codigo:** en `/home/abgroup/catalogo` (fuera del docroot; el directorio del subdominio es de solo lectura). Versionado en `site/` del repo.
- **.env:** credenciales reales con `chmod 600` (no versionado; `.env.example` sí).
- **Servicio:** `systemd --user` **`catalogo.service`** habilitado y activo (`linger=yes` ya activo). Gunicorn escuchando en `127.0.0.1:8000`.
- **Verificado:** `/health` -> `{"db":1,"status":"ok"}`; `/` renderiza "Catalogo — Anabolic Group"; 0 productos (pendiente de lista).
- **Preview sin proxy:** tunel SSH `ssh -L 8000:127.0.0.1:8000 -p 1230 abgroup@bolic.panamahosting507.com -N` y abrir `http://localhost:8000`.
- **Pendiente:** reverse proxy del hosting para publicar; lista de productos, URL del modelo y branding (colores/logo/WhatsApp).

### 2026-11-17 - Publicacion de test.anabolicgroup.com SIN admin del hosting (proxy PHP)

- El admin del hosting indico que se podia resolver por SSH. Se confirmo que `proxy_http` de Apache NO esta habilitado (el `.htaccess` con `[P]` da 500) y el vhost nginx no es editable por el usuario.
- **Solucion implementada (sin root):** reverse proxy en **PHP**:
  - `public_html/.htaccess`: `mod_rewrite` -> todo lo que no sea archivo existente va a `index.php`.
  - `public_html/index.php`: proxy con cURL a `http://127.0.0.1:8000` (reenvia metodo, headers, body, y responde `Location`, `Set-Cookie`, `Content-Type`).
  - `public_html/static/style.css`: copia servida directo por nginx.
- **Verificado (publico):** `https://test.anabolicgroup.com` -> **HTTP 200**, SSL Cloudflare valido (`verify=0`), titulo "Catalogo — Anabolic Group"; `/health` -> `{"db":1,"status":"ok"}`; `/static/style.css` -> 200 `text/css`.
- **Versionado:** `site/public_html/index.php` y `site/public_html/.htaccess`.
- **Nota:** si el hosting habilita `proxy_http` o un proxy nginx, se puede reemplazar el proxy PHP por el nativo (mejor rendimiento). El proxy PHP es funcional para el catalogo.

### 2026-11-17 - Prototipo visual del nuevo sitio (test.anabolicgroup.com)

**Branding (extraido del sitio actual):** logo blanco (`logotipo-en-valor-blanco`), WhatsApp **50760990195**, acento **rojo #E20613**, base oscura. Tipografias elegidas: **Bodoni Moda** (display), **Manrope** (texto), **JetBrains Mono** (etiquetas).

**Datos:** se cargaron **40 productos reales** (publicados con imagen) del catalogo actual en MySQL: EMINENCE 12, XTLABS 13, LANDERLAN 8, VMS 7. Imagenes copiadas al docroot (`public_html/static/img`).

**App (Python/Flask, server-side para SEO):**
- Rutas: `/`, `/marca/<slug>/`, `/producto/<slug>/`, `/api/producto/<slug>`, `/contacto` (redirige a WhatsApp), `/health`.
- Fichas con `JSON-LD Product`, meta title/description y Open Graph.
- UI: hero, filtros por marca, grid de tarjetas, **drawer lateral** (quick view via API), banda de contacto y boton **WhatsApp** en nav, ficha y drawer.
- Filtros por marca (decision del cliente). Categoria derivada (Orales/Inyectables/Peptidos) para futuro.

**Verificado (publico):** home 200 con 40 tarjetas y 5 chips; ficha 200 con JSON-LD; API JSON; CSS/logo/imagenes 200. Captura visual revisada: diseno oscuro + rojo, imagenes cargando correctamente.

**Versionado:** `site/` (app, templates, static, scripts, logo) + `site/public_html/` (proxy PHP). Commit pendiente de push.

**Pendiente:** lista definitiva de productos/categorias, ajustes de paleta y detalles, paginas legales (privacidad/terminos/descargo), sitemap/robots y panel o scripts de administracion.

### 2026-11-17 - Rediseno CTA WhatsApp + numero real + versionado de assets

- **CTA WhatsApp redisenado:** logo oficial grande en **badge verde (64px)** + texto **"Solicita informacion"** al lado, todo enlazable (macro `_wa.html`). Aplicado en hero, banda de contacto, ficha de producto y drawer.
- **Segunda linea** (`WhatsApp + numero`) enlazada; hover verde y numero subrayado.
- **Movil (<=720px):** se oculta el badge y el texto "Solicita informacion" se muestra como **boton verde full-width** (solo texto).
- **Numero real corregido:** `.env` tenia `50700000000`; se cambio a **50760990195** (el de la web actual).
- **Cache de Cloudflare:** servia el CSS viejo; se agrego **versionado automatico por mtime** (`?v=<mtime>`) a CSS/JS via `asset_ver` en el context processor.
- **Verificado:** badges 64x64 con fondo `#25D366`, links `wa.me/50760990195`, CSS publico con las reglas nuevas, captura desktop revisada.

### 2026-11-17 - Ajuste CTA WhatsApp (outline verde) y titulo de contacto

- **Titulo banda de contacto:** "Si buscas algún producto en concreto, escribe aquí."
- **CTA WhatsApp sin circulo verde:** se elimino el fondo circular; el globo y el telefono del logo se muestran en **verde (#25D366) como trazo/outline** (icono Remix `whatsapp-line`), 46px dentro de un badge transparente de 64px. Mismo tamano del CTA. Aplicado en hero, banda de contacto, ficha y drawer.
- **Verificado por DOM:** `h2` correcto, `background-color: rgba(0,0,0,0)` en el badge, `fill: rgb(37,211,102)`, `svg` 46px.
- **Movil:** se mantiene el boton verde de solo texto "Solicita informacion" (badge oculto).

### 2026-11-17 - Logo del nav mas grande (alta resolucion)

- Se reemplazo el logo por la version en **alta resolucion** (2481x1481, 23 KB) y se **versiono la URL** (`?v=<asset_ver>`) porque Cloudflare servia el logo viejo en cache.
- **Altura del logo:** nav **80px**, footer **64px**, movil 50px. Objetivo: que se lea "ANABOLIC GROUP".
- **Verificado por DOM:** nav render **134x80**, footer **107x64**.


### 2026-11-17 - Tipografia display final: Barlow Condensed 600

- **Investigacion de fuentes en webs de peptidos:** Inter (Direct Peptides; cuerpo de Paradigm), Montserrat/Oswald (Core Peptides), Poppins (Amino Asylum), Geist+Montserrat (Blue Sky), Red Hat Display/Paranoid (PureRawz), Cardo+Inter (Paradigm). Peptide Sciences bloqueado por Cloudflare.
- Se creo `fuentes.html` (https://test.anabolicgroup.com/fuentes.html) comparando 6 opciones estrechas: Oswald, Archivo 80%, **Barlow Condensed**, Roboto Condensed, Jost e Inter.
- El cliente eligio **Barlow Condensed 600**: sans condensada y plana. Hero 94px, letter-spacing 0; "grado" en rojo sin cursiva.
- **Verificado por DOM:** `font-family: "Barlow Condensed"`, weight 600, fuente cargada; captura revisada (look fuerte y compacto).

### 2026-11-17 - "grado" en script (Kaushan Script)

- El acento **"grado"** del hero se puso en **Kaushan Script** (brush, rojo), manteniendo **Barlow Condensed 600** para el resto del titular. Tamano 1.12em, sin cursiva sintetica.
- **Verificado:** `font-family: "Kaushan Script"`, fuente cargada (82.88px); captura revisada: contraste bold-condensada + script roja.

### 2026-11-17 - Vuelta a la tipografia del modelo: Instrument Serif

- A pedido del cliente se restauro **Instrument Serif** (la del sitio modelo) para los titulos, con "grado" en rojo **italica**. Se retiraron Barlow Condensed y Kaushan Script.
- **Verificado:** `font-family: "Instrument Serif"`, weight 400, hero 94px; captura revisada (look elegante, como el modelo).

### 2026-11-18 - Migracion del catalogo a la nueva base + filtros y buscador

**Fuente:** `cat-prod-actualizado.xlsx` (97 filas) + notas "SIN STOCK" + WooCommerce (categorias, stock, imagenes, descripciones).

**Decisiones aplicadas:**
- Excluidos: Metandrostenolona 10 mg, Oxitoland 50 mg, Trembolona Enantato 100 mg (repetido), Stanozolol 50 mg (oral e inyectable, pendiente de consulta).
- Extras incluidos (8) de las notas "SIN STOCK XTLABS / EMINENCE".
- Retatrutide (10/30/60) y Tirzepatide (10/15/30/60): 1 producto con presentaciones y precio por presentacion.
- Disponibilidad = cantidad de stock WC > 0; publicado = archivo "Si" + disponible (los "No" y stock 0 se migran pero no se publican).
- Categorias desde WooCommerce (Orales/Inyectables/Peptidos) + 14 inferidas; PROVIX corregido a Orales.

**Resultado:** 96 productos (86 simples + 8 extras + 2 variables con 7 presentaciones), 60 publicados, 36 no publicados, 3 sin imagen (borradores HCG 5000, Trembolona Acetato 100, Clembutrex 0.40). Marcas: EMINENCE 20, LANDERLAN 23, XTLABS 39, VMS 14. Categorias: Inyectables 50, Orales 32, Peptidos 14.

**Correcciones WooCommerce (18-nov):** Tremboplex 100 mg -> LANDERLAN y 84.99; se quito el termino padre MARCAS de los productos (marca primaria Rank Math -> marca hija); Testoplex-E 300 -> 74.99. Backup `db-before-fix-marcas-20261118.sql`.

**UI:** ficha con descripcion (HTML de WC); presentaciones con precio; filtro por categoria + marca; buscador `/buscar` (q + cat + marca; si q vacio lista todos de la categoria/marca).

**Verificado:** home 60 productos; /buscar?cat=peptidos=14; /buscar?marca=vms=14; /buscar?q=deca=2; /categoria/orales=21; Retatrutide muestra 10/30/60 con precios; HCG 5000 (no publicado) 404.
