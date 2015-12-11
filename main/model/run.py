# coding: utf-8

from __future__ import absolute_import

from google.appengine.ext import ndb

from api import fields
import model


class Run(model.Base):
  name = ndb.StringProperty(required=True)
  run_os = ndb.StringProperty(default="linux", choices=["win", "osx", "linux", "android"], verbose_name=u'Operating System')
  run_type = ndb.StringProperty(default="image", choices=["image", "calibration"], verbose_name=u'Type')

  FIELDS = {
      'name': fields.String,
      'run_os': fields.String,
      'run_type': fields.String,
    }

  FIELDS.update(model.Base.FIELDS)
