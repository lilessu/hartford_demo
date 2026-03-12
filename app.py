from flask import Flask, render_template, request, send_file
from db import run_sql_file, insert_jobs
from scrape import scrape_all_job_details, dedupe_jobs_by_url
import io
from datetime import datetime

app = Flask(__name__)

QUERY_FILES = {
    "avg_salary": "sql/queries/avg_salary.sql",

    "avg_salary_by_category": "sql/queries/avg_salary_by_category.sql",
    "avg_salary_by_location": "sql/queries/avg_salary_by_location.sql",
    "avg_salary_by_work_mode": "sql/queries/avg_salary_by_work_mode.sql",
    "avg_salary_by_category_location": "sql/queries/avg_salary_by_category_location.sql",

    "jobs_by_category": "sql/queries/jobs_by_category.sql",
    "jobs_by_location": "sql/queries/jobs_by_location.sql",
    "jobs_by_work_mode": "sql/queries/jobs_by_work_mode.sql",

    "category_by_location": "sql/queries/category_by_location.sql",
    "category_by_work_mode": "sql/queries/category_by_work_mode.sql",

    "work_mode_by_category": "sql/queries/work_mode_by_category.sql",

    "top_salary_jobs": "sql/queries/top_salary_jobs.sql",

    "full_export": "sql/queries/full_export.sql"
}


@app.route("/", methods=["GET", "POST"])
def index():
    results = None
    columns = []
    selected_query = None
    message = None

    if request.method == "POST":
        action = request.form.get("action")

        if action == "run_query":
            selected_query = request.form.get("query_name")

            if selected_query in QUERY_FILES:
                df = run_sql_file(QUERY_FILES[selected_query])
                results = df.to_dict(orient="records")
                columns = list(df.columns)

        elif action == "refresh_data":
            jobs = scrape_all_job_details()
            jobs = dedupe_jobs_by_url(jobs)
            insert_jobs(jobs)
            message = f"Refresh complete. Loaded {len(jobs)} job postings into staging."

    return render_template(
        "index.html",
        results=results,
        columns=columns,
        selected_query=selected_query,
        message=message
    )

    
from flask import send_file
from datetime import datetime
import io

@app.route("/export_csv")
def export_csv():

    df = run_sql_file("sql/queries/full_export.sql")

    output = io.StringIO()
    df.to_csv(output, index=False)
    output.seek(0)

    bytes_io = io.BytesIO()
    bytes_io.write(output.getvalue().encode("utf-8"))
    bytes_io.seek(0)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    filename = f"hartford_jobs_export_{timestamp}.csv"

    return send_file(
        bytes_io,
        mimetype="text/csv",
        as_attachment=True,
        download_name=filename
    )

if __name__ == "__main__":
    app.run(debug=True)