SELECT t.term_id, t.name, tt.taxonomy FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id=t.term_id
WHERE tt.taxonomy IN ('product_cat','product_brand')
  AND (t.name IN ('Péptidos','Peptidos','Inyectables','VMS','VMS MOLECULAR SCIENCE') OR t.slug IN ('peptidos','inyectables','vms'))
ORDER BY tt.taxonomy, t.name;