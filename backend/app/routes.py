import pickle
import pandas as pd
from flask import request, jsonify, session, redirect
import json

from app import app
# from ml import movie_list

similarity = pickle.load(open('ml/similarity.pkl','rb'))
movies_dict = pickle.load(open('ml/movie_list.pkl', 'rb'))
movies = pd.DataFrame(movies_dict)

# print(similarity)
# with open('movie_list.pkl', 'rb') as fp:
#     data = pickle.load(fp)
#     movies = pd.DataFrame(data)
    




# / -> to get detail of routes
@app.route('/')
def home():
    # print(movies)
    data = {
        "mes":"MRS "
    }
    return jsonify(data)
 
@app.route('/getMovies')
def getMovies():
    json_data = movies['movie_id'].values.tolist()
    # json_data = ["abc","def"]
    response = jsonify({"data":json_data})
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response
    
    # return jsonify(json_data)


@app.route('/sendRecomendation')
def sendRecomendation():
    selected_movie = search = request.args.get("movie")
    recommended_movie_id= recommend(selected_movie)
    
    
    json_data = jsonify(recommended_movie_id)
    print(recommended_movie_id)
    response = jsonify({"data":recommended_movie_id})
    response.headers.add('Access-Control-Allow-Origin', '*')


    return response
    # return jsonify(json_data)


def fetch_poster(movie_id):
    url = "https://api.themoviedb.org/3/movie/{}?api_key=8265bd1679663a7ea12ac168da84d2e8&language=en-US".format(movie_id)
    data = requests.get(url)
    data = data.json()
    poster_path = data['poster_path']
    full_path = "https://image.tmdb.org/t/p/w500/" + poster_path
    return full_path

def recommend(movie):
    print(movie)
    recommended_movie_id = []
    # print("{} checking".format(movies.loc[movies['title'] == movie].index[0]))
    try:
        index = movies.loc[movies['title'] == movie].index[0]
        print("index: {}".format(index))
        distances = sorted(list(enumerate(similarity[index])), reverse=True, key=lambda x: x[1])
        for i in distances[1:6]:
            # fetch the movie poster
            movie_id = movies.iloc[i[0]].movie_id
            print("{}:{}".format(movie_id,type(movie_id)))
            recommended_movie_id.append(int(movie_id))

    
    except Exception as e:
        print(e)
        res = {"response": "resume added failed"}
        print(e)

    return recommended_movie_id
