# coding: utf-8

from __future__ import absolute_import


from google.appengine.ext import ndb

from api import fields
import model


class Song(model.Base):
  name = ndb.StringProperty(required=True)
  instrument = ndb.StringProperty(default='harmonica')
  artist = ndb.StringProperty()
  genre = ndb.StringProperty()
  tab = ndb.TextProperty()
  harp_key = ndb.StringProperty()
  harp_type = ndb.StringProperty()
  posted_by = ndb.StringProperty()
  harptab_id = ndb.IntegerProperty()

  FIELDS = {
    'name': fields.String,
    'instrument': fields.String,
    'artist': fields.String,
    'genre': fields.String,
    'tab': fields.String,
    'harp_key': fields.String,
    'harp_type': fields.String,
    'posted_by': fields.String,
    'harptab_id': fields.Integer
  }

  FIELDS.update(model.Base.FIELDS)
