from http import client
from app import app, raw_resume_dir


from flask import request, jsonify, session, redirect
from datetime import datetime
from ml.resume_parsing import rp_fn
import os
from werkzeug.utils import secure_filename
import uuid
from app.model import fd_db

# allowed extension file to upload
ALLOWED_EXTENSIONS = {'pdf', 'doc', 'docm', 'docx'}


# =========================== ROUTES ===========================

# / -> to get detail of routes
@app.route('/')
def home():
    data = {
        "mes":"Your corporate friends @ thanksbuddy"
    }
    return jsonify(data)

# start server-side session for user


@app.route('/startsession')
def startsession():
    if session.get("name"):
        print(f"data  {session} ")
        res = {"response": "session already started"}
    else:
        try:
            session["name"] = 'client'

            # storing list of parsed data
            session['data'] = []
            # creation time of data
            session['creaded_time'] = datetime.now()
            # updation time of data
            session['update_time'] = datetime.now()

            res = {"response": "session started"}
        except Exception as e:
            print(e)
            res = {"response": "session failed"}
    return jsonify(res)

# upload resume for parsing


@app.route('/addresume', methods=['POST'])
def add_data():
    try:
        if not session.get("name"):
            # return redirect("/startsession")
            # start session
            print(f"start {startsession()}")

        # ------------------ store it raw ------------------
        try:
            resume = request.files['resume']
        except Exception as e:
            print(e)
            return jsonify({"response": "No selected file"})

        print(f"r: {resume.filename}")

        ext = resume.filename.split('.')[1]

        if ext not in ALLOWED_EXTENSIONS:
            return jsonify({"response": f"wrong extension file \n only {ALLOWED_EXTENSIONS}"})

        # create uqine file name
        file_name = uuid.uuid4().hex[:15].upper() + '.' + ext

        print(f"object len: {file_name} resume {resume.filename} {file_name}")
        resume.save(os.path.join(raw_resume_dir, secure_filename(file_name)))

        # ------------------ TODO: parsing of resume ------------------
        st_parse = datetime.now()
        parsed_resume_data = rp_fn(file_name)
        end_parse = datetime.now()

        data = {
            'st_parse': st_parse,
            'end_parse': end_parse,
            'resume': parsed_resume_data

        }
        # ------------------ Updating using session id ------------------

        # data added to server side session

        session['update_time'] = datetime.now()
        session['data'].append(data)

        res = {"response": "resume added done"}
    except Exception as e:
        print(e)
        res = {"response": "resume added failed"}

    return jsonify(res)

# return final parsed resume


@app.route("/submit")
def submit():
    try:
        if not session.get("name"):
            res = {"response": "session expired"}
        else:
            data = {
                "parsed_data": session["data"],
                'creaded_time': session['creaded_time'],
                'update_time': session['update_time']
            }
            res = {"response": data}
            # end session and deleting from mongodb
            session.clear()
            print(res)
    except ValueError as exc:
        print('error:', exc.args[0])
        res = {"response": "failed"}
    return jsonify(res)


# add data to the form
@app.route('/addformdata', methods=['POST'])
def addformdata():
    try:
        data = request.get_json(force=True)
        print(f"req: {data}\n====\n")

        First_name = data['First_name'] if 'First_name' in data else None

        Last_name = data['Last_name'] if 'Last_name' in data else None
        Email = data['Email'] if 'Email' in data else None
        Mobile = data['Mobile'] if 'Mobile' in data else None
        Total_year_of_experience = data['Total_year_of_experience'] if 'Total_year_of_experience' in data else None
        Present_company = data['Present_company'] if 'Present_company' in data else None
        Present_designation = data['Present_designation'] if 'Present_designation' in data else None
        Present_employer_start_month = data['Present_employer_start_month'] if 'Present_employer_start_month' in data else None
        Present_employer_start_year = data['Present_employer_start_year'] if 'Present_employer_start_year' in data else None
        Graduation_completion_year = data['Graduation_completion_year'] if 'Graduation_completion_year' in data else None
        Graduation_institute = data['Graduation_institute'] if 'Graduation_institute' in data else None
        Skillsets = data['Skillsets'] if 'Skillsets' in data else None
        Notice_Period = data['Notice_Period'] if 'Notice_Period' in data else None
        Current_CTC = data['Current_CTC'] if 'Current_CTC' in data else None
        Expected_CTC = data['Expected_CTC'] if 'Expected_CTC' in data else None
        Resume_link = data['Resume_link'] if 'Resume_link' in data else None

        fd = {
            "First_name": First_name,
            "Last_name": Last_name,
            "Email": Email,
            "Mobile": Mobile,
            "Total_year_of_experience": Total_year_of_experience,
            "Present_company": Present_company,
            "Present_designation": Present_designation,
            "Present_employer_start_month": Present_employer_start_month,
            "Present_employer_start_year": Present_employer_start_year,
            "Graduation_completion_year": Graduation_completion_year,
            "Graduation_institute": Graduation_institute,
            "Skillsets": Skillsets,
            "Notice_Period": Notice_Period,
            "Current_CTC": Current_CTC,
            "Expected_CTC": Expected_CTC,
            "Resume_link": Resume_link
        }

        response = fd_db.insert_one(fd)

        res = {"response": f"done"}
    except Exception as e:
        print(e)
        res = {"response": "failed"}

    return jsonify(res)

# finding skillsets in database as stated


@app.route('/findskillsets', methods=['POST'])
def findskillsets():
    try:
        data = request.get_json(force=True)
        print(f"req: {data}\n====\n")
        Skillsets = data['Skillsets']
        print(Skillsets)
        sk = list(fd_db.find({"Skillsets": {"$in": Skillsets}}))
        # for i in sk:
        #     print(i)
        res = {"response": f"done {sk}"}
    except Exception as e:
        res = {"response": f"failed"}

    return jsonify(res)
