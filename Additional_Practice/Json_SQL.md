## The Core Operators

To interact with JSONB data, you have to learn a new set of operators. Here are the three most important ones:

### Extraction Operators

*   `->` (Get JSON element by key or index)
    *   **What it does:** Extracts a JSON object field by key name (or an array element by index number), returning the result as `jsonb`. Useful if you want to keep querying deeper into the structure.
    *   **Example:** `attributes -> 'brand'`
    *   **Result:** `{"brand": "TechCorp"}` -> `"TechCorp"` (still formatted as JSONB text with quotes).

*   `->>` (Get JSON element as text)
    *   **What it does:** Extracts a JSON object field by key (or array element by index) and casts it directly to SQL text. This is the operator you will use most often when displaying results or using values in a WHERE clause.
    *   **Example:** `attributes ->> 'brand'`
    *   **Result:** `{"brand": "TechCorp"}` -> `TechCorp` (plain text string, no quotes).

*   `#>` (Get nested JSON by path) — Note: written as `#>` without the underscore
    *   **What it does:** Extracts a deeply nested JSON sub-object using an array of path keys.
    *   **Example:** `attributes #> '{specs, processor}'`
    *   **Result:** Navigates `attributes` -> `specs` -> `processor` and returns it as `jsonb`.

*   `#>>` (Get nested JSON as text)
    *   **What it does:** Same as `#>`, but extracts the final nested path value as SQL text.
    *   **Example:** `attributes #>> '{specs, processor}'`

---

### Containment & Existence Operators

*   `@>` (Contains)
    *   **What it does:** Checks if the JSONB on the left contains the JSONB structure/value on the right. This is extremely powerful for checking if a key-value pair exists, or if an array contains a specific item.
    *   **Example:** `attributes @> '{"brand": "TechCorp"}'`
    *   **Result:** `true` if the product's brand is TechCorp.

*   `<@` (Contained by)
    *   **What it does:** The exact reverse of `@>`. Checks if the JSONB on the left is contained within the JSONB on the right.
    *   **Example:** `'{"brand": "TechCorp"}'::jsonb <@ attributes`

*   `?` (Key exists)
    *   **What it does:** Checks if a specific string key exists as a top-level key in the JSONB object.
    *   **Example:** `attributes ? 'weight_capacity'`
    *   **Result:** `true` if the `weight_capacity` key is present in the JSON.

*   `?|` (Any keys exist)
    *   **What it does:** Checks if any of the strings in the given text array exist as top-level keys.
    *   **Example:** `attributes ?| array['price', 'cost']`
    *   **Result:** `true` if either "price" or "cost" is a key.

*   `?&` (All keys exist)
    *   **What it does:** Checks if all of the strings in the given text array exist as top-level keys.
    *   **Example:** `attributes ?& array['brand', 'features']`
