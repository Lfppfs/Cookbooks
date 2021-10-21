# see the docs of bs4 at https://www.crummy.com/software/BeautifulSoup/bs4/doc/
# useful commands (but not necessary to solve the exercises) are marked with # *
# these exercises are from the udemy python course, see the link >
# https://github.com/Pierian-Data/Complete-Python-3-Bootcamp/blob/master/13-Web-Scraping/01-Web-Scraping-Exercises.ipynb

import requests
import bs4
import re

# TASK: Use requests library and BeautifulSoup to connect to http://quotes.toscrape.com/ and get the HMTL text
# from the homepage

content = requests.get('http://quotes.toscrape.com/')
# print(content) # *
# print(type(content)) # *
# print(content.text) # *
# print(dir(content)) # *

# TASK: Get the names of all the authors on the first page.
content = requests.get('http://quotes.toscrape.com/page/1/')
content_soup = bs4.BeautifulSoup(content.text, 'lxml')
print(content_soup.prettify())
# print(content_soup) # *
# print(dir(content_soup)) # *
# print(content_soup.has_attr('author')) # *
authors_object = content_soup.select('small')
# print(authors_object) # *
# print(authors_object[0]) # *
# print(authors_object[0].text) # *

for i in authors_object:
    print(i.text)

print('\n\n\n\n---------------------------------------------\n\n\n\n')

# TASK: Create a list of all the quotes on the first page.
# print(content_soup.find_all('span')) # *
# print(content_soup.find('span.class="text".itemprop="text"')) # *
# print(content_soup.prettify()) # *
# print(content_soup.span) # *
# print(content_soup.span.text) # *
# print(content_soup.span['class']) # *
# print(content_soup.span.has_attr("class")) # *
# print(content_soup.span["class"] == ['text']) # *

# two ways of doing this, both use the find_all method:
# 1st way
# using a function to define exactly what a tag and its attributes and contents should match
# see https://www.crummy.com/software/BeautifulSoup/bs4/doc/#searching-the-tree for details


def whatiwanttofind(tag):
    if tag.name == 'span' and tag.has_attr("class") and tag["class"] == ['text']:
        return tag.string


list1 = content_soup.find_all(whatiwanttofind)
for i in list1:
    print(i.text)

# 2nd way
for i in content_soup.find_all("span"):
    if i.has_attr("class") and i["class"] == ['text']:
        print(i.text)

print('\n\n\n\n---------------------------------------------\n\n\n\n')

# TASK: Inspect the site and use Beautiful Soup to extract the top ten tags from the requests text
# shown on the top right from the home page (e.g Love,Inspirational,Life, etc...).
# this is similar to the one above
content = requests.get('http://quotes.toscrape.com/')
content_soup = bs4.BeautifulSoup(content.text, 'lxml')
# print(content_soup.select('span')) # *
# print(content_soup.select('span')[-3]) # *

# this works for one tag
# print(content_soup.select('span')[-3].select('a')[0].text) # *

# this works for all tags
for i in content_soup.select('span'):
    if i.has_attr('class') and i["class"] == ['tag-item']:
        print(i.text)

print('\n\n\n\n---------------------------------------------\n\n\n\n')

# TASK: Notice how there is more than one page, and subsequent pages look like this http://quotes.toscrape.com/page/2/.
# Use what you know about for loops and string concatenation to loop through all the pages and
# get all the unique authors on the website. Keep in mind there are many ways to achieve this, also note
# that you will need to somehow figure out how to check that your loop is on the last page
# with quotes. For debugging purposes, I will let you know that there are only 10 pages, so
# the last page is http://quotes.toscrape.com/page/10/, but try to create a loop that is robust enough
# that it wouldn't matter to know the amount of pages beforehand, perhaps use try/except for this, its up to you!

page_number = 1
content = requests.get(f'http://quotes.toscrape.com/page/{page_number}/')
content_soup = bs4.BeautifulSoup(content.text, 'lxml')
pattern = re.compile("No quotes found")
all_authors = set()

# if a page doesn't have any more quotes, it shows the string 'No quotes found'
# therefore we can use re.search to look for this pattern, and if it is found (if it is != None),
# we haven't reached the last page yet
while pattern.search(content_soup.text) == None:
    authors_object = content_soup.select('small')
    # sets only have unique elements
    single_page_authors = set(x.text for x in authors_object)
    all_authors.update(single_page_authors)  # joins two sets with their union
    print(f'page {page_number} has quotes')
    page_number += 1
    content = requests.get(f'http://quotes.toscrape.com/page/{page_number}/')
    content_soup = bs4.BeautifulSoup(content.text, 'lxml')
print(all_authors)
