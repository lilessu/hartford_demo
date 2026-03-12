import psycopg2
import pandas as pd 




def get_connection():
    conn = psycopg2.connect(
        host="localhost", 
        dbname="hartford_jobs",
        user="postgres",
        password="postgres",
        port=5432
    )
    return conn

def insert_jobs(jobs):
    conn = get_connection()
    cur = conn.cursor()

    for job in jobs:
        cur.execute(
            """
            INSERT INTO staging (
                jobref,
                title,
                location,
                category,
                employment_type,
                work_mode,
                description,
                min_sal,
                max_sal,
                url,
                date_retrieved
            )
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            ON CONFLICT (jobref) DO NOTHING
            """,
            (
                job["jobref"],
                job["title"],
                job["location"],
                job["category"],
                job["employment_type"],
                job["work_mode"],
                job["desc"],
                job["min_sal"],
                job["max_sal"],
                job["url"],
                job["date_retrieved"]
            )
        )

    conn.commit()
    cur.close()
    conn.close()

def run_sql_file(path):
    with open(path, "r", encoding="utf-8") as f:
        query = f.read()

    conn = get_connection()
    df = pd.read_sql_query(query, conn)
    conn.close()
    return df
    