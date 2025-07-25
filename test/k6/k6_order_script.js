import http from "k6/http";
import { check, sleep } from "k6";
import { randomIntBetween } from 'https://jslib.k6.io/k6-utils/1.4.0/index.js';

export const options = {
  vus: 120,
  duration: '30m', // 30분 동안 1000명 유지
};

const BASE_URL = 'http://localhost:8000';

export default function () {
    const userId = randomIntBetween(1, 9999);

    if (Math.random() < 0.5) {
        // 읽기만 하는 로직
        const res = http.get(`${BASE_URL}/products`);
        check(res, {
            'GET /products status is 200': (r) => r.status === 200
        });
    } else {
        // 읽고 주문을 하는 로직
        const res = http.get(`${BASE_URL}/products`);
        check(res, {
            'GET /products status is 200': (r) => r.status === 200
        });

        const products = res.json();
        if (products.length > 0) {
            const randomProduct = products[randomIntBetween(1, products.length-1)]

            const orderRespose = http.post(`${BASE_URL}/order`,
                JSON.stringify({
                    user_id: userId,
                    product_id: randomProduct.product_id
                }),
                {
                    headers: { 'Content-Type': 'application/json' }
                }
            );

            check(orderRespose, {
                'POST /order status is 200': (r) => r.status === 200,
            });
        }
    }

    sleep(10);
}