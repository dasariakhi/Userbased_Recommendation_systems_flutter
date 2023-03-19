import csv
from flask import Flask, jsonify, request
import pandas as pd
import numpy as np
from sklearn.metrics import pairwise_distances

app = Flask(__name__)

# Load data files
users = pd.read_csv('restaurents_visited.csv')
places = pd.read_csv('cusine_and_type.csv')
combine = pd.merge(users, places, on='placeID', how='inner')
matrix = combine.pivot_table(index='userID', columns='placeID', values='rating')
matrix_norm = matrix.subtract(matrix.mean(axis=1), axis='rows')
user_similarity = matrix_norm.T.corr()
@app.route('/add_rating', methods=['POST'])
def add_rating():
    # Get the ratings data from the request
    data = request.get_json()

    # Extract the relevant fields from the data
    userID = data.get('userID')
    placeID = data.get('placeID')
    rating = data.get('rating')
    food_rating = data.get('food_rating')
    service_rating = data.get('service_rating')

    # Append the ratings to the file
    with open('restaurents_visited.csv', mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow([userID, placeID, rating, food_rating, service_rating])

    # Return a success message
    response_body = {'message': 'Ratings added successfully'}
    response_status = 200
    response_headers = {'Content-Type': 'application/json'}
    return jsonify(response_body), response_status, response_headers


@app.route('/recommend', methods=['POST'])
def recommend():
    # Get user ID from request
    data = request.get_json()
    picked_userID = data['userID']

    # Number of similar users
    n = 15

    # User similarity threshold
    user_similarity_threshold = 0.5

    # Get top n similar users
    similar_users = user_similarity[user_similarity[picked_userID] > user_similarity_threshold][picked_userID].sort_values(
        ascending=False)[:n]

    # Restaurants that the input user has visited
    
    picked_userid_visited = matrix_norm[matrix_norm.index == picked_userID].dropna(axis=1, how='all')

    # Restaurants that similar users visited. Remove restaurants that none of the similar users have visited
    similar_user_restaurants = matrix_norm[matrix_norm.index.isin(similar_users.index)].dropna(axis=1, how='all')
    similar_user_restaurants.drop(picked_userid_visited.columns, axis=1, inplace=True, errors='ignore')

    # A dictionary to store item scores
    restaurant_score = {}

    # Loop through restaurants
    for i in similar_user_restaurants.columns:
        # Get the ratings for restaurant i
        restaurants_rating = similar_user_restaurants[i]
        # Create a variable to store the score
        total = 0
        # Create a variable to store the number of scores
        count = 0
        # Loop through similar users
        for u in similar_users.index:
            # If the restaurants has rating
            if pd.isna(restaurants_rating[u]) == False:
                # Score is the sum of user similarity score multiply by the restaurants rating
                score = similar_users[u] * restaurants_rating[u]
                # Add the score to the total score for the restaurants so far
                total += score
                # Add 1 to the count
                count += 1
        # Get the average score for the restaurant
        restaurant_score[i] = total / count

    # Convert dictionary to pandas dataframe
    restaurant_score = pd.DataFrame(restaurant_score.items(), columns=['place', 'rating'])

    # Sort the restaurants by score
    ranked_restaurant_score = restaurant_score.sort_values(by='rating', ascending=False)

    # Select top m restaurants
    m = 20

    # Return top m restaurants
    return jsonify({'restaurants': ranked_restaurant_score.head(m).to_dict('records')})


if __name__ == '__main__':
    app.run(debug=True)

