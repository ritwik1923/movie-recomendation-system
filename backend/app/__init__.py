'''
                ROUTES summary
/               -> get      = get detail of all route
'''

from flask import Flask
import os

# from ml import movie_list

# from ml import resume_parsing

# =========================== INIT ===========================

# init flask app
app = Flask(__name__)

# save raw resume
raw_resume_dir = os.path.join('app', 'raw_resume')
if os.path.isdir(raw_resume_dir) == False:
    os.makedirs(raw_resume_dir)


from app import routes 