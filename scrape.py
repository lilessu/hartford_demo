import requests
from bs4 import BeautifulSoup as bs4
import re
from datetime import datetime
from db import insert_jobs
import json
from collections import Counter

BASE_URL = "https://www.jointhehartford.com"
debug = True


def get_all_job_urls():
    all_urls = []
    soup = get_gallery_soup(1)
    last_page = get_last_page_number(soup)

    for page in range(1, last_page + 1):

        if debug:
            print(f"scraping gallery page {page}")

        soup = get_gallery_soup(page)
        page_urls = get_job_urls_from_page(soup)

        all_urls.extend(page_urls)

    if debug:
        print(f"total jobs found: {len(all_urls)}")

    return all_urls




def get_job_urls_from_page(soup):
    job_urls = []
    main = soup.find("main", id="main-content")
    job_list = main.find("ul", class_="results-content", id="job-list-section")
    jobs = job_list.find_all("li")

    for job in jobs:
        link = job.find("a", href=True)
        if link:
            href = link["href"]
            full_url = BASE_URL + href
            job_urls.append(full_url)

    return job_urls



def get_gallery_soup(page):
    url = BASE_URL + "/jobs/?page_jobs=" + str(page)
    response = requests.get(url)
    response.raise_for_status()
    soup = bs4(response.text, "html.parser")
    return soup



def get_last_page_number(soup):
    main = soup.find("main", id="main-content")
    pagination = main.find("div", class_="pagination")
    page_links = pagination.find_all("a", class_="page")

    page_numbers = []

    for link in page_links:
        text = link.get_text(strip=True)
        if text.isdigit():
            page_numbers.append(int(text))
    
    return max(page_numbers)

def scrape_all_job_details():
    job_urls = get_all_job_urls()
    all_job_data = []

    for url in job_urls:
        if debug:
            print(f"scrape_all_job_details: scraping job page: {url}")

        job_data = scrape_job_page(url)
        all_job_data.append(job_data)

    return all_job_data

def scrape_job_page(url): 
    soup = get_soup_from_url(url)
    main = soup.find("main", id="main-content")
    job_details = main.find("div", id="job-details", class_="job-details-content")

    dl = job_details.find("dl") #dl is a list that contains: location, category, type, jobref

    # get job title
    search_headings = main.find("div", class_="search-headings")
    title = search_headings.find("h1").get_text(strip=True)

    # get location, category, type, jobref from dl
    items = dl.find_all("div")

    details = {}
    for item in items:
        key = item.find("dt").get_text(strip=True).rstrip(":").lower()
        value = item.find("dd").get_text(strip=True).lower()
        details[key] = value

    # employment type is full time, part time. work mode is hybrid, remote, in office
    employment_type, work_mode = parse_employment_info(details["employment type"])

    # extract all description text
    desc_div = job_details.find("div", class_="copy")
    desc = desc_div.get_text(separator="\n", strip=True)

    min_sal = None
    max_sal = None
    match = re.search(r"\$([\d,]+)\s*-\s*\$([\d,]+)", desc)
    if match:
        min_sal = int(match.group(1).replace(",", ""))
        max_sal = int(match.group(2).replace(",", ""))
    

    retrieved_at = datetime.utcnow().isoformat()

    job_data = {
        "url": url,
        "title": title,
        "location": details["location"],
        "category": details["category"],
        "employment_type": employment_type,
        "work_mode": work_mode,
        "jobref": details["job ref"],
        "desc": desc,
        "min_sal": min_sal,
        "max_sal": max_sal,
        "date_retrieved": retrieved_at
    }

    if debug:
        print(f"scrape_job_page: returning job_data for {job_data["title"]}, {job_data["jobref"]}")

    return job_data

def parse_employment_info(type_text):
    parts = [part.strip() for part in type_text.split(",")]
    employment_type = parts[0] if len(parts) > 0 else None
    work_mode = "in office" # this is the default if not specified

    if len(parts) > 1:
        if "remote" in parts[1]:
            work_mode = "remote"
        elif "hybrid" in parts[1]:
            work_mode = "hybrid"

    return employment_type, work_mode


def get_soup_from_url(url): 
    response = requests.get(url)
    response.raise_for_status()
    soup = bs4(response.text, "html.parser")
    return soup

def dedupe_jobs_by_url(jobs):
    seen = set()
    unique_jobs = []

    for job in jobs:
        url = job["url"]

        if url not in seen:
            seen.add(url)
            unique_jobs.append(job)

    return unique_jobs




def main():
    
    jobs = scrape_all_job_details()
    if debug:
        print(f"before dedupe: {len(jobs)} postings")
    
    jobs = dedupe_jobs_by_url(jobs)
    if debug:
        print(f"after dedupe: {len(jobs)} postings")

    with open("jobs.json", "w", encoding="utf-8") as f:
        json.dump(jobs, f, indent=2)
        

    insert_jobs(jobs)

if __name__ == "__main__":
    main()