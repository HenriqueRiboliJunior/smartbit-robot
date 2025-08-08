import psycopg2

def delete_account_by_email(email):

    query = f"DELETE FROM accounts WHERE email = '{email}';"

    conn = psycopg2.connect(
        host='localhost',
        database='smartbit',
        user='postgres',
        password='QAx@123'
    )

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()