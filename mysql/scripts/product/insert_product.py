import random

output = []

for i in range(1, 300):
    market_id = random.randint(1, 5)
    product_name = f"product {i}"
    price = random.randint(10000, 100000)

    sql = f"({market_id}, '{product_name}', {price})"
    output.append(sql)

with open("./insert_product.sql", "w") as f:
    f.write("INSERT INTO products (market_id, product_name, product_price) VALUES\n")
    f.write(",\n".join(output))
    f.write(";\n")