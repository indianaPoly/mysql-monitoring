from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pymysql
from datetime import datetime

app = FastAPI()

# 이거 완료
class Product(BaseModel):
    product_id: int
    market_name: str
    product_name: str
    product_price: int

class Order(BaseModel):
    user_id: int
    product_id: int

def get_db():
    return pymysql.connect(
        host="mysql",
        user="",
        password="",
        database="",
        charset='utf8mb4',
        autocommit=True
    )

@app.get("/products")
def get_product():
    db = get_db()
    try:
        with db.cursor() as cursor:
            cursor.execute(
                """
                SELECT
                    p.product_id as product_id,
                    m.market_name as market_name,
                    p.product_name as product_name,
                    p.product_price as product_price
                FROM products p
                JOIN market m ON p.market_id = m.market_id;
                """
            )
            rows = cursor.fetchall()

            products = [
                Product(
                    product_id=row[0],
                    market_name=row[1],
                    product_name=row[2],
                    product_price=row[3]
                ) for row in rows
            ]

            return products
    
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        db.close()

@app.post("/order")
def create_order(order: Order):
    db = get_db()
    try:
        with db.cursor() as cursor:
            cursor.execute(
                """
                INSERT INTO orders (user_id, product_id)
                VALUES (%s, %s)
                """,
                (order.user_id, order.product_id)
            )
    
        return {"message": "Review saved"}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
    finally:
        db.close()