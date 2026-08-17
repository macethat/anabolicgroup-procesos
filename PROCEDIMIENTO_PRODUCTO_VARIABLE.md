# PROCEDIMIENTO: Convertir producto simple → VARIABLE (presentaciones)

> Procedimiento probado en Retatrutide (2026-08-10). Reutilizar para el siguiente producto con presentaciones (ej. Tirzepatide, BPC-157, etc.).

## Prerrequisitos
- Acceso SSH: `abgroup@bolic.panamahosting507.com` puerto `1230` (clave `C:\Users\Usuario\.ssh\anabolicgroup_ed25519`)
- WP-CLI: `php /home/abgroup/web/anabolicgroup.com/wp-cli.phar` y `--path=public_html` (o correr desde `public_html/`)
- Python con Pillow (conversión PNG→JPG) — disponible local
- Backup DB ANTES de tocar: `mysqldump` vía HestiaCP o `wp db export`

## RESULTADO ESPERADO (verificar SIEMPRE en el front)
- Selector/swatches de presentación visibles y clicables
- Cada variación con precio + stock correcto
- Badge del padre en "In Stock" (NO "Out of Stock")
- H1/título/descripción/excerpt SIN el nombre de la presentación (ej: solo "Retatrutide")

---

## PASO 0 — Backup (obligatorio)
```
mysqldump -u abgroup_... -p... abgroup_ABGROUP_AB > backups/db-before-<producto>-var-YYYYMMDD.sql
```
(O exportar desde HestiaCP / `wp db export backups/...`)

## PASO 1 — Convertir imágenes PNG → JPG (local)
Origen: `C:\suplementos\anabolicos\fotos\*.png`. Convertir a JPG 1000px (~80KB).
Ejemplo usado (Pillow):
```python
from PIL import Image
im = Image.open('Retratrutide 10mg.png').convert('RGB')
im = im.resize((1000,1000), Image.LANCZOS)
im.save('retatrutide-10mg.jpg', 'JPEG', quality=88)
```
- Atención a typos en nombres de archivo del cliente (ej: `Retratrutide`). Renombrar a slug limpio: `producto-10mg.jpg`, `producto-60mg.jpg`.
- La imagen de la presentación que YA existe en el sitio no necesita ser subida (usar su attachment_id actual).

## PASO 2 — Subir imágenes nuevas (PHP → servidor)
- Subir los JPG a `/home/abgroup/web/anabolicgroup.com/<producto>-10mg.jpg` (fuera de `public_html`).
- Script `upload_imgs.php` (plantilla en `plantillas/upload_imgs.php`): usar `media_handle_sideload` con SEO alt/caption/descripción. Anotar los **attachment_id** devueltos.

## PASO 3 — Crear atributo + términos (si no existe la taxonomía)
- Script `create_attribute.php` (plantilla `plantillas/create_attribute.php`) inserta en `woocommerce_attribute_taxonomies` + `wp_insert_term`.
- **CRÍTICO:** registrar taxonomía con `register_taxonomy($tax, array('product'))` antes de `wp_insert_term`.
- Anotar los `term_id` / `term_taxonomy_id` generados (por pedido ≈ slug).

> ⚠️ `attribute_name` en `woocommerce_attribute_taxonomies` NO lleva prefijo `pa_` (queda `presentacion`); la taxonomía real es `pa_presentacion`.

## PASO 4 — Convertir a variable + crear variaciones
- Script `make_variable.php` (plantilla `plantillas/make_variable.php`):
  1. `wp_set_object_terms($pid, 'variable', 'product_type')`
  2. `_product_attributes` con `pa_presentacion` (is_visible=1, is_variation=1, is_taxonomy=1)
  3. `_default_attributes`
  4. Borrar `_regular_price/_price/_sale_price/_stock/_stock_status` del padre; `_manage_stock='no'`
  5. Crear posts `product_variation` con `attribute_pa_presentacion`, `_regular_price/_price`, `_manage_stock=yes`, `_stock`, `_stock_status`, `_thumbnail_id`
  6. `wc_delete_product_transients($pid)`

## PASO 5 — FIXES POST-CREACIÓN (obligatorios, aprendidos por errores)
Aplicar vía `wp db query < fix.sql --path=public_html`:

```sql
-- a) Invalidar transient de atributos (NO se auto-invalida al crear por SQL)
DELETE FROM wp_buDIJ_options
WHERE option_name IN ('_transient_wc_attribute_taxonomies','_transient_timeout_wc_attribute_taxonomies');

-- b) Asociar términos al producto padre (sin esto el dropdown sale VACÍO)
INSERT IGNORE INTO wp_buDIJ_term_relationships (object_id, term_taxonomy_id, term_order)
VALUES (<padre>, <tt_10mg>, 0), (<padre>, <tt_30mg>, 1), (<padre>, <tt_60mg>, 2);

UPDATE wp_buDIJ_term_taxonomy SET count=CURRENT_COUNT
WHERE term_taxonomy_id IN (<tt_10mg>, <tt_30mg>, <tt_60mg>);  -- count = nº filas en term_relationships

-- c) Stock del padre en instock (si no, badge "Out of Stock" aunque haya variaciones)
UPDATE wp_buDIJ_postmeta SET meta_value='instock' WHERE post_id=<padre> AND meta_key='_stock_status';
```

## PASO 6 — Descripción, título y excerpt (SQL directo, NUNCA update_post_meta sobre contenido)
- `post_title`: quitar la presentación del nombre (ej: `Retatrutide 30mg` → `Retatrutide`). NO tocar `post_name`/slug para no romper URLs.
- `post_content`: reescribir para no referenciar una sola presentación; tabla con "Concentración: según presentación".
- `post_excerpt`: misma limpieza.
- Guardar SIEMPRE con `UPDATE wp_buDIJ_posts SET ... WHERE ID=...`, nunca con `wp_update_post()` sobre contenido con data-path-to-node.

## PASO 7 — Flush de cachés
```
wp cache flush --path=public_html
wp hestia-cache purge --path=public_html
wp elementor flush-css --path=public_html   (si se tocó contenido Elementor)
```

## PASO 8 — Verificación (2 capas)
1. **Datos ya verificados:** `SELECT` de `_stock_status`, `_stock`, `_price` por variación; `term_relationships` del padre; transient borrado.
2. **Front real** (curl desde el servidor, con `-A 'Mozilla/5.0'` y `-H 'Cache-Control: no-cache'`):
   - `<title>` y `<h1>` sin la presentación
   - badgetítulo = "In Stock"
   - `variations_form` con `<tbody>` POBLADO: `<select id="pa_presentacion">` con options y `<ul ... variable-items-wrapper ... data-attribute_values="[10mg,30mg,60mg]">` (swatches)
   - `data-product_variations` JSON: `is_in_stock` correctos por variación (compáralos top-of-mind con lo que el usuario reporta)
   - El alt de la imagen de cada presentación SÍ puede incluir su dosis (ej: "Retatrutide 30mg...")

## PASO 9 — Historial y repo
- Actualizar `HISTORIAL.md` (entrada del producto + correcciones).
- Limpiar scripts temporales del servidor (`public_html/*.php` usados y `*.sql`).

---

## ⚠️ Lecciones adicionales (Tirzepatide 2026-08-10)
- **NO usar `$product->save()` al final del script** después de poner el `_stock_status` del padre en instock: WC recalcula y lo revierte a `outofstock`. El fix c (SQL directo, PASO 5c) debe aplicarse SIEMPRE DESPUÉS de cualquier `save()` del producto, o simplemente NO llamar a `save()` si el atributo/default ya quedó bien.
- **Variaciones sin imagen:** se pueden crear con `_thumbnail_id` ausente (img=0); el front las muestra sin foto y se puede subir la imagen después con `media_handle_sideload` + asignar `_thumbnail_id` a la variación (no al padre).
- **Término extra (ej: 15mg):** el script `make_variable` ya crea términos faltantes con `wp_insert_term`; basta listarlos en `$term_names`. El transient se invalida después igualmente.
- Títulos/descripciones sin dosis: siempre limpiar `post_title`, `post_excerpt` y `post_content` (vía SQL directo) del producto padre al convertirlo en variable, como en Retatrutide.

---

## Checklist rápido por sintoma
| Síntoma | Causa probable | Fix |
|---|---|---|
| Sin selector/swatches (tbody vacío) | transient `wc_attribute_taxonomies` obsoleto y/o términos sin asociar | PASO 5a + 5b |
| Selector visible pero vacío (solo "Elige una opción") | términos sin `term_relationships` al padre | PASO 5b |
| Badge "Out of Stock" en título | `_stock_status` del padre = outofstock | PASO 5c |
| "Out of Stock" en todas las variaciones | padre marcado agotado | PASO 5c |
| Mensaje HTML corrupto con `data-path-to-node` | usar `wp_update_post()`/`update_post_meta()` sobre contenido | usar SQL directo (PASO 6) |
| Atributo no aparece en admin/API | transient obsoleto | PASO 5a + `wp cache flush` |