import csv
import pyautogui
import time
from datetime import datetime

def filter_on_odd_indices(elements_list):
    return [x for i, x in enumerate(elements_list) if i % 2 != 0 ]

def get_text_nodes(element_list):
    new_list =  list(map(lambda element:element.get_attribute('textContent'),element_list))
    new_list =  list(map(lambda itemstr:itemstr.replace("\n",""),new_list))
    new_list = list(map(lambda itemstr: itemstr.replace("\t", ""), new_list))
    new_list = list(map(lambda itemstr: itemstr.strip(), new_list))
    return new_list

def get_str_parts(element_list):
    new_list = list(map(lambda element: element.split("  "), element_list))
    new_list = list(map(lambda list_of_strings: list(filter(lambda x:x!='',list_of_strings)), new_list))
    return new_list

def read_csv_file(filename):
    data = []
    with open(filename,'r') as csvfile:
        reader =  csv.reader(csvfile)
        for row  in  reader:
            data.append(row)
    return data

def click_element_using_image_recognition(file):
    pyautogui.useImageNotFoundException()
    time.sleep(3)
    try:
        element_location = pyautogui.locateOnScreen(file)
        pyautogui.click(element_location)
    except:
        raise Exception("Element to click on could not be found.")

def string_is_a_timestamp(string, format="%Y-%m-%d %H:%M:%S"):
    try:
        datetime.strptime(string, format)
        return True
    except ValueError:
        return False