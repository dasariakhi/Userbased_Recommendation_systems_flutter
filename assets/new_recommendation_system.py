import pandas as pd
import numpy as np
import csv
# from sklearn.metrics.pairwise import cosine_similarity
# from scipy.stats import pearsonr
from sklearn.metrics import pairwise_distances



users = pd.read_csv('C:/Users/akhil/Desktop/flutter/recommendationsystems/assets/restaurents_visited.csv')
places = pd.read_csv('C:/Users/akhil/Desktop/flutter/recommendationsystems/assets/cusine_and_type.csv')


input_user = 'U999'

if input_user in users['userID'].values:
# This is for new user. Load the restaurant data
   restaurant_data = pd.read_csv('C:/Users/akhil/Desktop/flutter/recommendationsystems/assets/restaurents_visited.csv')

# Calculate the overall rating
   restaurant_data['overall_rating'] = (users['rating'] + users['food_rating'] + users['service_rating']) / 3

# Sort restaurants by overall rating
   ranked_restaurants = restaurant_data.sort_values(by='overall_rating', ascending=False)

# Select top m restaurants
   m = 20
   recommended_restaurants = ranked_restaurants.head(m)

# Display recommended restaurants to the user
   print(recommended_restaurants['placeID'])

else: 

    # Merge users and places datasets
    combine = pd.merge(users, places, on='placeID', how='inner')

    # Create user-place matrix
    matrix = combine.pivot_table(index='userID', columns='placeID', values='rating')

    # Normalize user-item matrix
    matrix_norm = matrix.subtract(matrix.mean(axis=1), axis='rows')

    # User similarity matrix using Pearson correlation
    user_similarity = matrix_norm.T.corr()

    # Pick a user ID
    picked_userID = input("please provide userID")

    # Remove picked user ID from the candidate list
    user_similarity.drop(index=picked_userID, inplace=True)

    # Take a look at the data
    user_similarity.head()

    # Number of similar users
    n = 15

    # User similarity threashold
    user_similarity_threshold = 0.3

    # Get top n similar users
    similar_users = user_similarity[user_similarity[picked_userID] > user_similarity_threshold][picked_userID].sort_values(
        ascending=False)[:n]

    # Restaurants that the input user has visited
    picked_userid_visited = matrix_norm[matrix_norm.index == picked_userID].dropna(axis=1, how='all')

    # Restaurants that similar users visited. Remove restauranst that none of the similar users have visited
    similar_user_restaurants = matrix_norm[matrix_norm.index.isin(similar_users.index)].dropna(axis=1, how='all')

    # Remove the visited restaurants from the list that input user vistited
    similar_user_restaurants.drop(picked_userid_visited.columns, axis=1, inplace=True, errors='ignore')

    # Take a look at the data
    similar_user_restaurants

    # A dictionary to store item scores
    restaurant_score = {}

    # Loop through restaurants
    for i in similar_user_restaurants.columns:
        # Get the ratings for restaurant i
        restaurants_rating: object = similar_user_restaurants[i]
        # Create a variable to store the score
        total = 0
        # Create a variable to store the number of scores
        count = 0
        # Loop through similar users
        for u in similar_users.index:
            # If the restaurants has rating
            if not pd.isna(restaurants_rating[u]):
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
    print(ranked_restaurant_score.head(m))


# Example values received from frontend
userID = 'U1003'
placeID = 135085
rating = 4.5
food_rating = 4.0
service_rating = 4.0

# Append the ratings to the file
with open('restaurants_visited.csv', mode='a', newline='') as file:
    writer = csv.writer(file)
    writer.writerow([userID, placeID, rating, food_rating, service_rating])