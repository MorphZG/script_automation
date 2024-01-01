'''
script should copy all files listed in paths array to destination_path directory. while doing so it
should append the number to destination file.
'''
import shutil
import os

file_source = ["/home/zoran/coding_documents/Learn-code/freecodecamp/relational database/09 learn bash and SQL by building a bike rental shop/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/chatGPT/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/100_days_of_code/37 Habit tracking, API post requests & headers/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/100_days_of_code/38 Workout tracking using google sheets/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/100_days_of_code/40 capstone p2 Flight club/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/100_days_of_code/35 Keys, authentication, environment variables, send SMS/.env",
         "/home/zoran/coding_documents/Learn-code/python_learning/100_days_of_code/39 capstone p1 Flight deal finder/.env",
         "/home/zoran/coding_documents/Learn-code/app_brewery web_development_bootcamp/weather project/.env",
         "/home/zoran/coding_documents/Learn-code/app_brewery web_development_bootcamp/newsletter-signup/node_modules/.pnpm/psl@1.9.0/node_modules/psl/.env",
         "/home/zoran/coding_documents/Learn-code/app_brewery web_development_bootcamp/newsletter-signup/.env"]

destination_path = "/home/zoran/coding_documents/Learn-code/environment files/"
counter = 1
new_files = []

for file in file_source:
    path, filename = os.path.split(file)  # split the filename from the path
    destination_filename = os.path.join(destination_path, f'{filename}{counter}')  # create the string with target path and new filename
    shutil.copyfile(file, destination_filename) # copy the file
    counter += 1

'''
Now i have another problem. I don't know where each of those files belongs to. Since those are environment variables
it is important to have them in the right directory or deployed with the right app. I should insert full path string to the first line.

'''
