UPDATE products SET image='/static/img/stanoplex-10-mg-60tab.webp' WHERE code='XTL-DEF-021';
UPDATE products SET image='/static/img/hcg-5000-ui-landerlan-gold.webp' WHERE code='LAN-REC-018';
SELECT code, name, image FROM products WHERE code IN ('XTL-DEF-021','LAN-REC-018');
