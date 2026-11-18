UPDATE products SET name='Anastroprime 1 mg', slug='anastroprime-1-mg' WHERE slug='anstroprime-1-mg';
UPDATE products SET name='Klenprime 40 mcg', slug='klenprime-40-mcg' WHERE slug='klenprime-0-40-mg';
UPDATE products SET name='Klenprime 60 mcg', slug='klenprime-60-mcg' WHERE slug='klembuterol-0-60mcg-50comp';
UPDATE products SET name='Proviprime 25 mg', slug='proviprime-25-mg' WHERE slug='masterolona-25mg-proviron-50-comp';
UPDATE products SET name='Metaprime 10 mg', slug='metaprime-10-mg' WHERE slug='methandrostenolona-10mg-dianabol-50-comp';
UPDATE products SET name='Arimidext 1 mg', slug='arimidext-1-mg' WHERE slug='arimidex-1-mg-anastrozol';
UPDATE products SET name='Oxyplex 50 mg', slug='oxyplex-50-mg' WHERE slug='oxiplex-50-mg';
UPDATE products SET name='Trenboplex Acetato 100 mg', slug='trenboplex-acetato-100-mg' WHERE slug='tremboplex-acetato';
UPDATE products SET name='Trenboplex Enantato 200 mg', slug='trenboplex-enantato-200-mg' WHERE slug='tremboplex-enantato';
UPDATE products SET name='IGF-1 LR3 1 mg', slug='igf-1-lr3-1-mg-xtlabs' WHERE slug='igf-1-lr3-1-ml';
UPDATE products SET name='Clembutrex 40 mcg', slug='clembutrex-40-mcg' WHERE slug='clenbutrex-hcl-0-40-mg';
UPDATE products SET name='Clembutrex Ultra 60 mcg', slug='clembutrex-ultra-60-mcg' WHERE slug='clenbutrex-ultra-0-60-mg';
SELECT code, name, slug, is_published FROM products
WHERE slug IN ('anastroprime-1-mg','klenprime-40-mcg','klenprime-60-mcg','proviprime-25-mg',
 'metaprime-10-mg','arimidext-1-mg','oxyplex-50-mg','trenboplex-acetato-100-mg',
 'trenboplex-enantato-200-mg','igf-1-lr3-1-mg-xtlabs','clembutrex-40-mcg','clembutrex-ultra-60-mcg')
ORDER BY code;
