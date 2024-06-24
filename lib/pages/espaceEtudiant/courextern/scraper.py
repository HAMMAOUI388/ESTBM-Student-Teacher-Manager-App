import csv
import json

csv_file_path = 'coursera-course-detail-data.csv'
json_file_path = 'coursera-course-detail-data.json'

# Read the CSV file and convert it to a JSON format
with open(csv_file_path, 'r', encoding='utf-8') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    json_data = [row for row in csv_reader]

# Write the JSON data to a new file
with open(json_file_path, 'w', encoding='utf-8') as json_file:
    json.dump(json_data, json_file, ensure_ascii=False, indent=4)
