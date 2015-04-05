# coding: utf-8

from __future__ import absolute_import

from flask.ext import restful
import flask
from api import helpers

import auth
import config
import model
import task

from main import api_v1


@api_v1.resource('/feedback/', endpoint='api.feedback')
class FeedbackAPI(restful.Resource):

  def post(self):
    if not config.CONFIG_DB.feedback_email:
      return flask.abort(418)
    data = flask.request.get_json()
    feedback_db = model.Feedback(
      message=data['message'],
      email=data['email'],
    )
    feedback_db.put()
    body = '%s\n\n%s' % (feedback_db.message, feedback_db.email)
    kwargs = {'reply_to': feedback_db.email} if feedback_db.email else {}
    task.send_mail_notification('%s...' % body[:48].strip(), body, **kwargs)
    return helpers.make_response(feedback_db, model.Feedback.FIELDS)
