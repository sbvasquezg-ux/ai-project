# Notas de alcance

HasDerivAt expresa las derivadas locales. IsLocalMax permite usar Fermat. La pendiente exige igualdad eventual con la oferta lineal; no se deriva una función usando solo una igualdad en un punto.

MiddleCertificate es la conclusión de un teorema a partir de primitivas, no una hipótesis de optimalidad. Expone holguras y recursos del candidato. Su tipo no expresa la unicidad de todos los equilibrios y no recibe ese crédito.

La prueba de unicidad del paper es matemática e independiente de este certificado Lean; queda pendiente traducir su argumento de dualidad y complementariedad.

Revisión pública posterior con GPT-5.6 Sol/xhigh sobre 450b4d1: no encontró errores matemáticos, señaló la condición qH incondicional (corregida a H≤a → qH<H) y contadores de inventario (actualizados). Las proposiciones y pruebas coinciden exactamente con el pin 3fb4aab; se guardan hashes en audit/proposition_source_comparison.json. No es cierre semántico ni revisión humana.
