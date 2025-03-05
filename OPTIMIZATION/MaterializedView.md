# Using Materialized View for JSON Field Extraction

Using a **Materialized View (MV)** to pre-extract JSON fields would significantly improve query performance. Instead of extracting JSON fields dynamically during each query, the fields will already be stored in a structured format, leading to faster retrieval and reduced processing costs.

---

## 🔹 Why a Materialized View is Faster?

1. **Pre-Extracted Data**: JSON fields (like `sessionId`, `orderDate`, etc.) are already stored in separate columns, eliminating the need for `JSON_VALUE()` extraction at query time.
2. **Reduced Query Complexity**: Queries using the MV avoid the expensive `JSON_VALUE()` and `UNNEST()` operations, making them faster and more cost-efficient.
3. **Automatic Refresh**: BigQuery automatically updates the MV when the base table changes, ensuring fresh data without manual updates.
4. **Optimized Storage**: Since only relevant extracted data is stored, queries scan a smaller dataset, improving performance and reducing costs.

---

## 🔹 Comparison: Without vs. With Materialized View

| Approach                      | Processing Cost                      | Query Speed  | Storage Efficiency                            |
| ----------------------------- | ------------------------------------- | ------------ | --------------------------------------------- |
| **Querying JSON directly**     | High (due to `JSON_VALUE()` and `UNNEST()`) | Slow         | Efficient but expensive for frequent queries  |
| **Using Materialized View**    | Low (pre-processed)                  | Fast         | Uses extra storage but speeds up queries     |

---

## 🚀 Suggested Optimization for Your Use Case

You can modify your function and procedure to use a **Materialized View** instead of dynamically extracting JSON in every query.

### 1️⃣ Create a Materialized View with Extracted Fields

```sql
CREATE MATERIALIZED VIEW `OLEG.EXTRACTEDORDERS` AS
SELECT 
    MESSAGE_ID,
    MESSAGE_PUBLISHDATE,
    JSON_VALUE(PAYLOAD, "$.sessionId") AS SESSION_ID,
    JSON_VALUE(PAYLOAD, "$.orderDate") AS ORDER_DATE,
    JSON_VALUE(PAYLOAD, "$.accountType") AS ACCOUNT_TYPE
FROM `OLEG.MESSAGELOG`
WHERE MESSAGE_STATUS = 'RECEIVED';
```
## 🔹 Benefit:
Queries will run faster since extracted fields are precomputed.

---

### 2️⃣ Update Your Function to Query from the Materialized View

Modify to query the MV instead of the raw table:

```sql
AS (( 
    SELECT ARRAY_AGG(STRUCT(
        MESSAGE,
        PUBLISHDATE,
        MESSAGE_SOURCE,
        data, 
        "RECEIVED" AS MESSAGE_STATUS,
        CURRENT_TIMESTAMP() AS CREATEDDATE,
        INSERT_TIME,
        CAST(NULL AS TIMESTAMP) AS PROCESSED_ON,
        CAST(NULL AS JSON) AS ERRORS 
    ))
    FROM `OLEG.extracted_orders` -- Use Materialized View!
    WHERE MESSAGE_PUBLISHDATE > (
        SELECT LASTREFRESH 
        FROM `OLEG.UPDATETIME`
        WHERE SOURCENAME = 'OZTABLE'
    ) 
    AND (LOWER(IDTYPE) = 'NEW' OR ACCOUNT_TYPE IS NULL)
    AND (BULK_FLAG IS NULL OR BULK_FLAG != 'true')
));
```

## 🔹 Benefit:

- ✅ No need to extract JSON fields dynamically in every function call.
- ✅ Faster function execution due to reduced processing overhead.

### 3️⃣ Update Your Procedure to Use the Function

```sql
CREATE OR REPLACE PROCEDURE `OLEG.UPLOADMESSAGE`()
BEGIN 
    INSERT INTO `OLEG.MESSAGELOG` 
    SELECT * FROM UNNEST(`OLEG.RETREIVEDATA`());

    UPDATE `OLEG.UPDATETIME`
    SET UPDATETIME = COALESCE(
        (SELECT MAX(CREATED_ON) FROM OLEG.MESSAGELOG`),
        CURRENT_TIMESTAMP()
    )
    WHERE SOURCENAME = 'OZTABLE';
END;
```

## 🔹 Benefit:

- ✅ Inserts data faster without JSON parsing overhead.
- ✅ Updates `UPDATETIME` efficiently.

---

## 🔹 Final Takeaway

🚀 **Switching to a Materialized View for JSON extraction is a huge performance win!**

- ✅ Queries will be much faster since JSON is pre-processed.
- ✅ Function and Procedure execution will be optimized.
- ✅ Reduced query costs due to efficient storage and partition pruning.
