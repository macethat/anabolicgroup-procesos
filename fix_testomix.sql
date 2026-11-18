UPDATE products SET name='Testo-Mix 250 mg', slug='testo-mix-250-mg' WHERE slug='testomix-250-mg';
SELECT code, name, slug, price, is_published FROM products WHERE slug='testo-mix-250-mg';
SELECT b.name, COUNT(*) n FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name ORDER BY b.name;
