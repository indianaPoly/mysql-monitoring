import random

output = []

for i in range(1, 10000):
    user_id = i
    random_number = random.randint(1, 500)
    email = f"{random_number}_{i}@example.com"
    password = f"{random_number}_i_password"

    sql = f"({user_id}, '{email}', '{password}')"
    output.append(sql)

with open("./insert_users.sql", "w") as f:
    f.write("INSERT INTO users (user_id, email, password) VALUES\n")
    f.write(",\n".join(output))
    f.write(";\n")