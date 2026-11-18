UPDATE products SET image='/static/img/clembutrex-0-40-mg.webp' WHERE slug='clembutrex-0-40-mg';
UPDATE products SET image='/static/img/trembolona-acetato-100mg.webp' WHERE slug='trembolona-acetato-100mg';
SELECT id, slug, name, image FROM products WHERE image IS NULL OR image='';
