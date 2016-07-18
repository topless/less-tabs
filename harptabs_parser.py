#!/usr/bin/env python3
# coding: utf-8

import os
import json
import requests
from bs4 import BeautifulSoup

MIN_SONG_ID = 4
MAX_SONG_ID = 24205
PROPERTIES = ["Song Name:", "By:", "Genre:", "Key:", "Harp Type:", "Posted By:", "Song:"]

URL = 'http://www.harptabs.com/'
# TODO: Get a list of songs, find their page link.


def main():
  for song_id in range(MIN_SONG_ID, MIN_SONG_ID + 5):
    song_soup = get_song(song_id)
    is_valid, result = get_song_info(song_soup)
    if is_valid:
      print(song_id, result['name'])
      result['harptab_id'] = song_id
      save_file(result)


def get_song(song_id):
  url = "{}song.php?ID={}".format(URL, song_id)
  try:
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'html.parser')
    return soup
  except Exception as e:
    print(e)


def get_song_info(soup):
  result = {}
  is_valid = True
  for prop in soup.find_all(string=PROPERTIES):
    name, content = validate(prop)
    if not content:
      is_valid = False
    result[name] = content
  return is_valid, result


def validate(entry):
  prop_key = entry.lower()[:-1].replace("\"", "").replace("\'", "")
  prop_value_soup = entry.parent.parent.find_next_sibling("td")
  if prop_key == 'song name':
    return ('name', prop_value_soup.text.replace("!", "")
                                        .replace(".", "")
                                        .replace("\"", "")
                                        .replace("\'", "")
                                        .replace(u'\xa0', u' ')
                                        .strip())
  if prop_key == 'harp type':
    return 'harp', prop_value_soup.text.replace(u'\xa0', u' ').lower().strip()
  if prop_key == 'song':
    # If song validates we are good to go!
    return prop_key, parse_song(prop_value_soup)
  return prop_key, prop_value_soup.text


# NOTE: This will not work, if there is non-valid html in song template.
def parse_song(song_soup):
  output = ""
  for item in song_soup.find_all(string=True):
    output = "{}\n{}\n".format(output.strip(), item.replace(u'\u00a0', u' ').strip())
  return output


def save_file(data):
  filename = "{}.json".format(os.path.join('songs', data['name']))
  with open(filename, 'w') as reply_file:
    reply_file.write(json.dumps(data))


if __name__ == '__main__':
  main()
