# Codificación interna de productos

Sistema de códigos para control interno del catálogo de Anabolic Group. **No se muestra en la
web y no se envía a WooCommerce**: vive únicamente en la base de datos del catálogo nuevo
(`abgroup_catalogo`, tabla `products`, columna `code`).

## 1. Formato

```
MARCA-FUNC-SECUENCIA
  EMI-DEF-017
  └┬─┘ └┬┘ └─┬─┘
   │    │    └── número correlativo de la marca (3 dígitos, 4 si pasa 999)
   │    └─────── función del compuesto (3 letras)
   └──────────── prefijo fijo de la marca
```

Ejemplos: `EMI-ANT-001`, `LAN-VOL-012`, `XTL-DEF-017`, `VMS-GH-003`.

| Marca | Prefijo |
|---|---|
| EMINENCE | `EMI` |
| LANDERLAN | `LAN` |
| XTLABS | `XTL` |
| VMS | `VMS` |

## 2. Funciones

La utilidad es la **función** del compuesto, no la vía de administración.

| Código | Función | Productos |
|---|---|---|
| `ANT` | Anti-estrógeno / control de E2 | 2 |
| `QUI` | Quema / pérdida de grasa | 8 |
| `FER` | Fertilidad | 0 |
| `ART` | Articulaciones | 0 |
| `DEF` | Definición / dureza | 18 |
| `VOL` | Volumen / masa magra | 43 |
| `REC` | Recuperación / PCT | 6 |
| `FUE` | Fuerza | 0 |
| `MET` | Metabólico | 7 |
| `REP` | Reparación / tejidos | 2 |
| `GH` | Hormona de crecimiento | 8 |
| `DER` | Piel / regeneración | 2 |
| `GEN` | General (sin clasificar, solo respaldo) | 0 |

`FER`, `ART` y `FUE` quedan definidas y reservadas para productos futuros.

## 3. Reglas

1. **La secuencia es por marca, no por función.** Cada marca lleva su propio contador
   (`001`, `002`, …) que avanza con cada producto nuevo, sea cual sea su función. Por eso
   `EMI-VOL-002` y `EMI-DEF-007` conviven: el número indica orden de alta dentro de EMINENCE.
2. **Sin huecos ni reinicios.** El contador nunca se reinicia ni se reutiliza.
3. **Código retirado no se reasigna.** Si un producto se descontinúa, su código se retira;
   el producto se oculta (`is_published = 0`), no se borra.
4. **Único.** La columna `code` tiene restricción `UNIQUE` en MySQL.
5. **Inmutable.** El código no cambia si el producto cambia de nombre, presentación o precio.
   Si se corrige la función, se conserva el número y se actualiza el segmento de función,
   dejando registro en `HISTORIAL.md`.
6. **Alta siempre por el utilitario**, nunca a mano, para respetar la secuencia:

   ```bash
   cd /home/abgroup/catalogo
   .venv/bin/python scripts/next_code.py XTLABS DEF     # -> XTL-DEF-040
   ```

7. **Concurrencia.** Al dar de alta varios productos a la vez hay que bloquear la marca
   (`SELECT … FOR UPDATE` sobre los productos de esa marca) para que dos altas simultáneas
   no calculen el mismo número.
8. **Alcance.** Solo catálogo interno. No se usa en la web ni se sincroniza con WooCommerce.

## 4. Asignación retroactiva

Los 96 productos existentes se codificaron en una sola pasada, ordenados por **ID de creación**
en la base (orden de alta original), marca por marca. El resultado son secuencias continuas
`001..N` por marca (EMINENCE 1-20, LANDERLAN 1-23, XTLABS 1-39, VMS 1-14), sin huecos ni
duplicados.

## 5. Cómo se clasificó la función

Se aplicó un mapeo manual por compuesto (anastrozol, clomifeno, HCG, clenbuterol, oxandrolona,
drostanolona, metenolona, testosterona, boldenona, nandrolona, trembolona, péptidos, etc.) y,
como respaldo, reglas por palabra clave en nombre y ficha. Las excepciones puntuales están
declaradas en `site/scripts/assign_codes.py` (diccionario `EXACT`). Los productos nuevos usan
las mismas reglas; si el compuesto no aparece, el script devuelve `GEN` y hay que clasificarlo
a mano.

## Anexo — Catálogo codificado (96 productos)

### EMINENCE

| Código | Producto | Función | Categoría | Web |
|---|---|---|---|---|
| `EMI-ANT-001` | Anstroprime 1 mg | ANT · Anti-estrógeno | Orales | Público |
| `EMI-DEF-007` | OXANPRIME 10 MG | DEF · Definición / dureza | Orales | Público |
| `EMI-DEF-015` | Masterolona 25mg (Proviron) 50 comp | DEF · Definición / dureza | Orales | Oculto |
| `EMI-DEF-019` | Drostoprime 100 mg | DEF · Definición / dureza | Inyectables | Público |
| `EMI-DEF-020` | Trenoprime 100 mg | DEF · Definición / dureza | Inyectables | Público |
| `EMI-MET-014` | LIOPRIME 25 MCG | MET · Metabólico | Orales | Oculto |
| `EMI-QUI-006` | KLENPRIME 0.40 MG | QUI · Quema / pérdida de grasa | Orales | Público |
| `EMI-QUI-013` | Klembuterol 0.60mcg 50comp | QUI · Quema / pérdida de grasa | Orales | Oculto |
| `EMI-REC-003` | Cloprime 50 mg | REC · Recuperación / PCT | Orales | Público |
| `EMI-REC-010` | Tamoprime 20 mg | REC · Recuperación / PCT | Orales | Público |
| `EMI-REC-012` | CHORIONIC GONADOTROPHIN | REC · Recuperación / PCT | Inyectables | Oculto |
| `EMI-VOL-002` | Boldeprime 200 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `EMI-VOL-004` | Cypoprime 250 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `EMI-VOL-005` | Enaprime 250 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `EMI-VOL-008` | OXYMEPRIME 50 MG | VOL · Volumen / masa magra | Orales | Público |
| `EMI-VOL-009` | Proprime 100 mg Propionato | VOL · Volumen / masa magra | Inyectables | Público |
| `EMI-VOL-011` | Testomix 250 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `EMI-VOL-016` | Methandrostenolona 10mg (Dianabol) 50 comp | VOL · Volumen / masa magra | Orales | Oculto |
| `EMI-VOL-017` | Decaprime 200 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `EMI-VOL-018` | Decaprime NPP 100 mg | VOL · Volumen / masa magra | Inyectables | Público |

### LANDERLAN

| Código | Producto | Función | Categoría | Web |
|---|---|---|---|---|
| `LAN-DEF-005` | Drostanolona Propionato 10ml | DEF · Definición / dureza | Inyectables | Público |
| `LAN-DEF-010` | OXANDROLAND 10mg | DEF · Definición / dureza | Orales | Público |
| `LAN-DEF-011` | Oxandroland 5 mg - Oxandrolona | DEF · Definición / dureza | Orales | Público |
| `LAN-DEF-017` | DROSTENOLAND METIL DROSTANOLONA 10mg | DEF · Definición / dureza | Orales | Oculto |
| `LAN-DEF-022` | Trembolona Acetato 100mg | DEF · Definición / dureza | Inyectables | Oculto |
| `LAN-QUI-003` | Clenbuterol 0.04 mg | QUI · Quema / pérdida de grasa | Orales | Público |
| `LAN-REC-018` | HCG 5000 ui | REC · Recuperación / PCT | Inyectables | Oculto |
| `LAN-VOL-001` | Androlic 25 mg - Oximetolona | VOL · Volumen / masa magra | Orales | Público |
| `LAN-VOL-002` | Boldenona 250 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-004` | Decaland 200 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-006` | Durateston Plus Gold 10ml | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-007` | Metenolona Acetato 25 mg | VOL · Volumen / masa magra | Orales | Público |
| `LAN-VOL-008` | Metenolona Enantato 100 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-009` | Nandrolona Fenil NPP 100 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-012` | Testenat Depot - 250 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-013` | Testoland Depot - 200 mg - Cipionato | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-014` | Testosterona Propionato 100 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `LAN-VOL-015` | Trembolona Enantato 200 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-016` | BOLDENONA UNDECILENATO | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-019` | PRIMOBOLAND ENANTATO GOLD 10ml | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-020` | TESTOLAND DEPOT 200 MG | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-021` | TESTOSTERONA PROPINATO 100mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `LAN-VOL-023` | TREMBOLONA ENANTADO GOLD | VOL · Volumen / masa magra | Inyectables | Oculto |

### VMS

| Código | Producto | Función | Categoría | Web |
|---|---|---|---|---|
| `VMS-DER-004` | GHK-Cu 100mg | DER · Piel / regeneración | Péptidos | Público |
| `VMS-DER-005` | GLOW 70mg | DER · Piel / regeneración | Péptidos | Público |
| `VMS-GH-003` | CJC1295 (Without DAC) 10mg | GH · Hormona de crecimiento | Péptidos | Público |
| `VMS-GH-006` | IGF-1 LR3 1mg | GH · Hormona de crecimiento | Péptidos | Público |
| `VMS-GH-007` | IPAMORELIN 10mg | GH · Hormona de crecimiento | Péptidos | Público |
| `VMS-GH-012` | TESAMORELIN 10mg | GH · Hormona de crecimiento | Péptidos | Público |
| `VMS-MET-001` | AOD9604 10mg | MET · Metabólico | Péptidos | Público |
| `VMS-MET-008` | MOTS-C 40mg | MET · Metabólico | Péptidos | Público |
| `VMS-MET-009` | NAD+ 500mg | MET · Metabólico | Péptidos | Público |
| `VMS-MET-010` | Semaglutide 5mg | MET · Metabólico | Péptidos | Público |
| `VMS-MET-013` | Retatrutide | MET · Metabólico | Péptidos | Público |
| `VMS-MET-014` | Tirzepatide | MET · Metabólico | Péptidos | Público |
| `VMS-REP-002` | BPC-157 5mg | REP · Reparación | Péptidos | Público |
| `VMS-REP-011` | TB500 10mg | REP · Reparación | Péptidos | Público |

### XTLABS

| Código | Producto | Función | Categoría | Web |
|---|---|---|---|---|
| `XTL-ANT-001` | Arimidex 1 mg Anastrozol | ANT · Anti-estrógeno | Orales | Público |
| `XTL-DEF-013` | Mastaplex 100 mg | DEF · Definición / dureza | Inyectables | Público |
| `XTL-DEF-017` | Oxandroplex 10 mg Oxandrolona | DEF · Definición / dureza | Orales | Público |
| `XTL-DEF-020` | Razor 200 mg | DEF · Definición / dureza | Inyectables | Público |
| `XTL-DEF-021` | Stanoplex 10 mg Estanozolol | DEF · Definición / dureza | Orales | Público |
| `XTL-DEF-022` | Stanoplex 10 ml | DEF · Definición / dureza | Inyectables | Público |
| `XTL-DEF-031` | MASTEPLEX - P | DEF · Definición / dureza | Inyectables | Oculto |
| `XTL-DEF-032` | PROVIX 25MG - 50TAB | DEF · Definición / dureza | Orales | Oculto |
| `XTL-DEF-033` | TREMBOPLEX ACETATO | DEF · Definición / dureza | Inyectables | Oculto |
| `XTL-DEF-039` | Trembolona Acetato 100 mg | DEF · Definición / dureza | Inyectables | Oculto |
| `XTL-GH-007` | Gentropin 210 UI | GH · Hormona de crecimiento | Inyectables | Público |
| `XTL-GH-009` | Hutrope 100 IU | GH · Hormona de crecimiento | Inyectables | Público |
| `XTL-GH-010` | Ibutamoren 15 mg | GH · Hormona de crecimiento | Orales | Público |
| `XTL-GH-011` | IGF-1 LR3 1 ml | GH · Hormona de crecimiento | Inyectables | Oculto |
| `XTL-QUI-003` | Cardarine 10 mg | QUI · Quema / pérdida de grasa | Orales | Oculto |
| `XTL-QUI-004` | Clenbutrex HCL 0.40 mg | QUI · Quema / pérdida de grasa | Orales | Público |
| `XTL-QUI-005` | Clenbutrex Ultra 0.60 mg | QUI · Quema / pérdida de grasa | Orales | Público |
| `XTL-QUI-028` | CLEMBUTEROL ULTRA 0.60MCG | QUI · Quema / pérdida de grasa | Orales | Oculto |
| `XTL-QUI-029` | CLEMBUTREX 0.40 MG | QUI · Quema / pérdida de grasa | Orales | Oculto |
| `XTL-REC-008` | HCG 10.000 UI | REC · Recuperación / PCT | Inyectables | Público |
| `XTL-REC-030` | CLOMIXT 50MG - 30TAB | REC · Recuperación / PCT | Orales | Oculto |
| `XTL-VOL-002` | Boldeplex 200 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-006` | Decaplex 300 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-012` | Ligandrol 5 mg | VOL · Volumen / masa magra | Orales | Público |
| `XTL-VOL-014` | Methandroplex 20 mg | VOL · Volumen / masa magra | Orales | Público |
| `XTL-VOL-015` | Nandroplex 100 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-016` | Ostarine 10 mg | VOL · Volumen / masa magra | Orales | Público |
| `XTL-VOL-018` | Oxiplex 50 mg | VOL · Volumen / masa magra | Orales | Público |
| `XTL-VOL-019` | Primoplex 100 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-023` | Sustaplex 275 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `XTL-VOL-024` | Triple XXX 200 mg Tritrenbolona | VOL · Volumen / masa magra | Inyectables | Público |
| `XTL-VOL-025` | TVR 350 mg Testo Enantato/Propionato | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-026` | TXT 400 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-027` | BOLDAPLEX 200 MG | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-034` | TREMBOPLEX ENANTATO | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-035` | TURINAPLEX 10 MG | VOL · Volumen / masa magra | Orales | Oculto |
| `XTL-VOL-036` | Testoplex-C 300 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
| `XTL-VOL-037` | Testoplex-E 300 mg | VOL · Volumen / masa magra | Inyectables | Público |
| `XTL-VOL-038` | Titan 400 mg | VOL · Volumen / masa magra | Inyectables | Oculto |
