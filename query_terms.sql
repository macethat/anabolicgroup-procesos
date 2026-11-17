SELECT t.term_id, t.name, t.slug, tt.taxonomy
FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id=t.term_id
WHERE tt.taxonomy='pa_presentacion';
