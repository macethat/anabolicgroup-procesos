UPDATE products SET name = 'Klenprime 0.40 mg', slug = 'klenprime-0-40-mg' WHERE id = 6;
UPDATE products SET name = 'Klembuterol 0.60 mcg 50 comp', slug = 'klembuterol-0-60mcg-50comp' WHERE id = 13;
UPDATE products SET name = 'Clenbutrex HCL 0.40 mg', slug = 'clenbutrex-hcl-0-40-mg' WHERE id = 43;
UPDATE products SET name = 'Clenbutrex Ultra 0.60 mg', slug = 'clenbutrex-ultra-0-60-mg' WHERE id = 44;
SELECT id, code, name, slug, is_published FROM products WHERE id IN (6,13,43,44) ORDER BY id;
