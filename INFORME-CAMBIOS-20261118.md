# Informe de cambios del catálogo

**Fecha:** 18 de noviembre de 2026
**Base:** `cat-prod-actualizado.xlsx` (lista de precios) + WooCommerce (fotos, descripciones, stock)
**Objeto:** verificar la correspondencia de datos —nombre, compuesto, dosis, presentación y precio— entre la lista, el catálogo y la web de cada marca.
**Catálogo resultante:** 87 productos · 60 publicados · 27 no publicados
**Sitio:** https://test.anabolicgroup.com

---

## 1. Cambios realizados

### 1.1 Migración inicial

- Se migraron **96 productos**: 86 simples, 8 extras tomados de las notas “SIN STOCK” y 2 productos con presentaciones (Retatrutide y Tirzepatide, 7 presentaciones con precio propio).
- **Disponibilidad** = cantidad de stock en WooCommerce > 0.
- **Publicado** = la lista marca “Sí” **y** hay stock. Los “No” y los de stock 0 se migraron, pero quedan ocultos.
- Categorías tomadas de WooCommerce: **Inyectables, Orales, Péptidos**.

### 1.2 Normalización de nombres

- **40 productos** pasaron a formato título con unidades en minúscula y siglas intactas (`mg`, `mcg`, `ml`, `tab`; `HCG`, `NPP`, `UI`, `IGF-1`, `TB500`, `GHK-Cu`, `NAD+`, `MOTS-C`…).
- **7 etiquetas de presentación** corregidas (`10mg` → `10 mg`).
- Ejemplos: `KLENPRIME 0.40 MG` → `Klenprime 0.40 mg`; `TREMBOPLEX ACETATO` → `Tremboplex Acetato`; `Clomixt 50MG - 30TAB` → `Clomixt 50 mg - 30 tab`.

### 1.3 Corrección de dosis (verificadas en la web de cada marca)

| Antes | Ahora | Fuente |
|---|---|---|
| Klenprime 0.40 mg | **Klenprime 40 mcg** | eminencelabs.com |
| Klembuterol 0.60 mcg 50 comp | **Klenprime 60 mcg** | eminencelabs.com |
| Clenbutrex HCL 0.40 mg | **Clembutrex 40 mcg** | xt-labs.in |
| Clenbutrex Ultra 0.60 mg | **Clembutrex Ultra 60 mcg** | xt-labs.in |

### 1.4 Corrección de nombres comerciales

| Antes | Ahora | Fuente |
|---|---|---|
| Anstroprime 1 mg | **Anastroprime 1 mg** | eminencelabs.com |
| Masterolona 25 mg (Proviron) 50 comp | **Proviprime 25 mg** | eminencelabs.com |
| Methandrostenolona 10 mg (Dianabol) 50 comp | **Metaprime 10 mg** | eminencelabs.com |
| Arimidex 1 mg Anastrozol | **Arimidext 1 mg** | xt-labs.in |
| Oxiplex 50 mg | **Oxyplex 50 mg** | xt-labs.in |
| Tremboplex Acetato | **Trenboplex Acetato 100 mg** | xt-labs.in |
| Tremboplex Enantato | **Trenboplex Enantato 200 mg** | xt-labs.in |
| IGF-1 LR3 1 ml | **IGF-1 LR3 1 mg** | xt-labs.in |

Los cambios se aplicaron **en la lista y en el catálogo**. Los códigos internos no cambiaron.

### 1.5 Duplicados eliminados

Se comparó la fotografía de cada par para confirmar que era el mismo producto. Todos los eliminados tenían el mismo empaque.

| Marca | Eliminado | Se conserva |
|---|---|---|
| XTLABS | Clembutrex 0.40 mg | Clembutrex 40 mcg |
| XTLABS | Clembuterol Ultra 0.60 mcg | Clembutrex Ultra 60 mcg |
| LANDERLAN | Boldenona Undecilenato | Boldenona 250 mg |
| LANDERLAN | Primoboland Enantato Gold 10 ml | Metenolona Enantato 100 mg |
| LANDERLAN | Testoland Depot 200 mg | Testoland Depot - 200 mg - Cipionato |
| LANDERLAN | Trembolona Enantado Gold | Trembolona Enantato 200 mg |
| LANDERLAN | Trembolona Enantato 100 mg (marcada “repetido” en la lista) | — |
| XTLABS | Boldaplex 200 mg | Boldeplex 200 mg |
| XTLABS | Masteplex - P | Mastaplex 100 mg |
| XTLABS | Trembolona Acetato 100 mg (venía del bloque de notas) | Trenboplex Acetato 100 mg |

**Resultado:** de 96 a **87 productos**. Las filas correspondientes se borraron de la lista y la nota que reintroducía el último duplicado también. Los códigos retirados no se reutilizan.

> Nota: `Trembolona Enantato 100 mg` existía solo en la lista (marcada “repetido”); nunca se había publicado en el catálogo. Por eso son 9 productos menos y 10 filas eliminadas.

### 1.6 Imágenes

- Se recuperaron **2 fotos que existían en WooCommerce pero no estaban asignadas**: Clembutrex 40 mcg y Trembolona Acetato 100 mg.
- Queda **1 producto sin foto**: `HCG 5000 UI` (no existe imagen en WooCommerce).

### 1.7 Codificación interna

- Formato **`MARCA-FUNCIÓN-SECUENCIA`** (ej. `EMI-DEF-017`), secuencia por marca, sin huecos ni reutilización.
- Prefijos: EMINENCE `EMI`, LANDERLAN `LAN`, XTLABS `XTL`, VMS `VMS`.
- Funciones: `ANT`, `QUI`, `FER`, `ART`, `DEF`, `VOL`, `REC`, `FUE`, `MET`, `REP`, `GH`, `DER`, `GEN`.
- Documento con el anexo de los 87 códigos: `CODIFICACION.md`.
- El código **no se muestra en la web** y no se envía a WooCommerce.

### 1.8 Exportaciones

- `exports/catalogo-fichas.csv`: nombre, categoría, enlace de la ficha y enlace de WooCommerce (solo para no disponibles).
- `exports/catalogo-inventario.csv`: código, nombre, categoría, stock y precio.
- `exports/catalogo-fichas.xlsx`: igual que el CSV de fichas pero **con las fotos incrustadas** (86 miniaturas), más una hoja de inventario.
- Todos agrupados en bloques por marca, con encabezado y separación.

### 1.9 Péptidos VMS verificados

Los 14 péptidos de la marca propia se contrastaron con la web actual (anabolicgroup.com). **Nombre, presentación, precio y stock coinciden en los 14.**

| Producto | Presentación | Precio web | Precio catálogo | Estado |
|---|---|---|---|---|
| AOD9604 | 10 mg | 150.00 | 150.00 | Coincide |
| BPC-157 | 5 mg | 120.00 | 120.00 | Coincide |
| CJC1295 (Without DAC) | 10 mg | 150.00 | 150.00 | Coincide |
| GHK-Cu | 100 mg | 130.00 | 130.00 | Coincide |
| GLOW | 70 mg | 160.00 | 160.00 | Coincide |
| IGF-1 LR3 | 1 mg | 120.00 | 120.00 | Coincide |
| Ipamorelin | 10 mg | 130.00 | 130.00 | Coincide |
| MOTS-C | 40 mg | 160.00 | 160.00 | Coincide |
| NAD+ | 500 mg | 140.00 | 140.00 | Coincide |
| Retatrutide | 10 / 30 / 60 mg | 160 / 200 / 250 | 160 / 200 / 250 | Coincide |
| Semaglutide | 5 mg | 120.00 | 120.00 | Coincide |
| TB500 | 10 mg | 160.00 | 160.00 | Coincide |
| Tesamorelin | 10 mg | 160.00 | 160.00 | Coincide |
| Tirzepatide | 10 / 15 / 30 / 60 mg | 120 / 130 / 160 / 220 | 120 / 130 / 160 / 220 | Coincide |

### 1.10 Corrección de marca

| Producto | Antes | Ahora | Código |
|---|---|---|---|
| Gentropin 210 UI | XTLABS | **GENLI PHARMA** | `GNL-GH-001` |
| Hutrope 100 IU | XTLABS | **HUBIO PHARM** | `HUB-GH-001` |

Ambos siguen publicados y con su precio ($350.00 y $215.00). No pertenecen a XT Labs: son de Genli Pharma y Hubio Pharm respectivamente. Se crearon las dos marcas con su propio prefijo de código.

### 1.11 Ajustes técnicos del sitio

- Presentaciones con precio y stock por variante.
- Filtro por categoría y por marca, y buscador por nombre.
- Descripción completa en la ficha del producto.
- Corrección de URLs absolutas tras el proxy: `canonical`, `og:url` y datos estructurados (antes salían con `127.0.0.1:8000`).

---

## 2. Productos en duda

Casos donde la evidencia no alcanza para corregir sin confirmación. **No se tocaron.**

| Producto | Duda | Estado |
|---|---|---|
| Testosterona Propionato 100 mg / “TESTOSTERONA PROPINATO 100mg” | Mismo compuesto, dosis y precio ($64.99), pero el empaque difiere: caja negra “Gold Premium Series” vs caja blanca clásica. ¿Cambio de empaque o dos presentaciones? | Ambos siguen en el catálogo |
| Metenolona Acetato 25 mg | La ficha oficial de Landerlan no declara los 25 mg (su bula está copiada del inyectable); el dato solo aparece en un distribuidor | Sin cambios |
| Stanoplex 10 mg (oral) | Circulan dos referencias: 10 mg / 60 tab y 5 mg / 60 tab | Sin cambios |
| Testomix 250 mg | Nombre oficial: “Testo – Mix” | Se mantiene `Testomix` |

---

## 3. Productos no tocados: pendientes de consulta

| Producto | Motivo |
|---|---|
| **Androlic 25 mg** | La ficha de Landerlan lo describe como **mesterolona** 25 mg (20 comp), no oximetolona. Confirmar con la caja física antes de cambiar el compuesto. |
| **HCG 5000 UI** (Eminence) | No figura en el catálogo oficial de Eminence. Confirmar origen. |
| **Chorionic Gonadotrophin** (Eminence) | No figura en el catálogo oficial de Eminence. Confirmar origen. |
| **Decaprime NPP 100 mg** | Eminence solo publica Decaprime 200 (decanoato); no hay NPP en su catálogo. |
| **Stanozolol 50 mg** (oral e inyectable) | Excluido desde el inicio de la migración, a la espera de tu decisión. |

---

## Anexo: estado del catálogo

| Marca | Productos |
|---|---|
| EMINENCE | 20 |
| LANDERLAN | 19 |
| XTLABS | 32 |
| VMS | 14 |
| GENLI PHARMA | 1 |
| HUBIO PHARM | 1 |
| **Total** | **87** |

| Categoría | Productos |
|---|---|
| Inyectables | 43 |
| Orales | 30 |
| Péptidos | 14 |

Respaldos de la lista: `upgrade-data/backups/`.
Registro cronológico completo: `HISTORIAL.md`. Auditoría con fuentes: `AUDITORIA-MARCAS.md`.
