UPDATE products
SET excerpt = 'Recuperación hormonal + Fertilidad',
    description = '<p><strong>HCG 5000 UI</strong> de Landerlan Gold: gonadotropina coriónica humana USP 5000 UI en vial liofilizado estéril, con ampolla de 1 ml de cloruro de sodio al 0.9% para reconstituir. Vía IM/SC.</p><p>Presentación: 1 vial de 5000 UI + 1 ampolla diluyente de 1 ml.</p>'
WHERE code = 'LAN-REC-018';
SELECT code, name, price, is_published, image, LEFT(description,80) AS descripcion FROM products WHERE code='LAN-REC-018';
