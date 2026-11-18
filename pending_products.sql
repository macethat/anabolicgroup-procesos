SELECT p.code, p.name, b.name AS marca, p.category_id, c.name AS cat, p.price, p.is_published
FROM products p JOIN brands b ON b.id=p.brand_id LEFT JOIN categories c ON c.id=p.category_id
WHERE p.name IN ('Testosterona Propionato 100 mg','Testosterona Propinato 100 mg','Metenolona Acetato 25 mg',
 'Testomix 250 mg','Androlic 25 mg - Oximetolona','HCG 5000 UI','Chorionic Gonadotrophin','Decaprime NPP 100 mg',
 'Stanoplex 10 mg Estanozolol','Stanoplex 10 ml')
ORDER BY p.name;
