INSERT INTO brands (name, slug, sort_order) VALUES ('GENLI PHARMA','genli-pharma',10)
  ON DUPLICATE KEY UPDATE name=VALUES(name);
INSERT INTO brands (name, slug, sort_order) VALUES ('HUBIO PHARM','hubio-pharm',11)
  ON DUPLICATE KEY UPDATE name=VALUES(name);
UPDATE products SET brand_id=(SELECT id FROM brands WHERE name='GENLI PHARMA'),
  code='GNL-GH-001' WHERE name='Gentropin 210 UI';
UPDATE products SET brand_id=(SELECT id FROM brands WHERE name='HUBIO PHARM'),
  code='HUB-GH-001' WHERE name='Hutrope 100 IU';
SELECT p.code, p.name, b.name AS marca FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.name IN ('Gentropin 210 UI','Hutrope 100 IU');
SELECT b.name, COUNT(*) AS n FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name ORDER BY b.sort_order, b.name;
