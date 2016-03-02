# coding: utf-8

from __future__ import absolute_import

import hashlib

from google.appengine.ext import ndb

from api import fields
import model
import util
import config


class Feedback(model.Base):
  message = ndb.TextProperty(required=True)
  email = ndb.StringProperty(default='')

  FIELDS = {
      'message': fields.String,
      'email': fields.String,
    }

  FIELDS.update(model.Base.FIELDS)
