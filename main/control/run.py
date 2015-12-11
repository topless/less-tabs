# coding: utf-8

from flask.ext import wtf
from google.appengine.ext import ndb
import flask
import wtforms

import auth
import config
import model
import util

from main import app


###############################################################################
# Update
###############################################################################
class RunUpdateForm(wtf.Form):
  name = wtforms.StringField(
      model.Run.name._verbose_name,
      [wtforms.validators.required()],
      filters=[util.strip_filter],
    )
  run_os = wtforms.StringField(
      model.Run.run_os._verbose_name,
      [wtforms.validators.optional()],
      filters=[util.strip_filter],
    )
  run_type = wtforms.StringField(
      model.Run.run_type._verbose_name,
      [wtforms.validators.optional()],
      filters=[util.strip_filter],
    )


@app.route('/run/create/', methods=['GET', 'POST'])
@app.route('/run/<int:run_id>/update/', methods=['GET', 'POST'])
def run_update(run_id=0):
  if run_id:
    run_db = model.Run.get_by_id(run_id)
  else:
    run_db = model.Run()

  if not run_db:
    flask.abort(404)

  form = RunUpdateForm(obj=run_db)

  if form.validate_on_submit():
    form.populate_obj(run_db)
    run_db.put()
    return flask.redirect(flask.url_for('run_view', run_id=run_db.key.id()))

  return flask.render_template(
      'run/run_update.html',
      title=run_db.name if run_id else 'New Run',
      html_class='run-update',
      form=form,
      run_db=run_db,
    )


###############################################################################
# List
###############################################################################
@app.route('/run/')
def run_list():
  run_dbs, run_cursor = model.Run.get_dbs()
  return flask.render_template(
      'run/run_list.html',
      html_class='run-list',
      title='Run List',
      run_dbs=run_dbs,
      next_url=util.generate_next_url(run_cursor),
      api_url=flask.url_for('api.run.list'),
    )


###############################################################################
# View
###############################################################################
@app.route('/run/<int:run_id>/')
def run_view(run_id):
  run_db = model.Run.get_by_id(run_id)
  if not run_db:
    flask.abort(404)

  return flask.render_template(
      'run/run_view.html',
      html_class='run-view',
      title=run_db.name,
      run_db=run_db,
      api_url=flask.url_for('api.run', run_key=run_db.key.urlsafe() if run_db.key else ''),
    )


###############################################################################
# Admin List
###############################################################################
@app.route('/admin/run/')
@auth.admin_required
def admin_run_list():
  run_dbs, run_cursor = model.Run.get_dbs(
      order=util.param('order') or '-modified',
    )
  return flask.render_template(
      'run/admin_run_list.html',
      html_class='admin-run-list',
      title='Run List',
      run_dbs=run_dbs,
      next_url=util.generate_next_url(run_cursor),
      api_url=flask.url_for('api.admin.run.list'),
    )


###############################################################################
# Admin Update
###############################################################################
class RunUpdateAdminForm(RunUpdateForm):
  pass


@app.route('/admin/run/create/', methods=['GET', 'POST'])
@app.route('/admin/run/<int:run_id>/update/', methods=['GET', 'POST'])
@auth.admin_required
def admin_run_update(run_id=0):
  if run_id:
    run_db = model.Run.get_by_id(run_id)
  else:
    run_db = model.Run()

  if not run_db:
    flask.abort(404)

  form = RunUpdateAdminForm(obj=run_db)

  if form.validate_on_submit():
    form.populate_obj(run_db)
    run_db.put()
    return flask.redirect(flask.url_for('admin_run_list', order='-modified'))

  return flask.render_template(
      'run/admin_run_update.html',
      title=run_db.name if run_id else 'New Run',
      html_class='admin-run-update',
      form=form,
      run_db=run_db,
      back_url_for='admin_run_list',
      api_url=flask.url_for('api.admin.run', run_key=run_db.key.urlsafe() if run_db.key else ''),
    )
