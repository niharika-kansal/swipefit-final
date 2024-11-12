import pandas as pd
import os
import cv2
import numpy as np
import random
import matplotlib.pyplot as plt

json_output_path = '/content/csvjson.json'  # Upload File path 
attributes_df = pd.read_json(json_output_path)

Q = np.zeros((len(attributes_df), 2))

alpha = 0.2
gamma = 0.9
epsilon = 0.3
min_epsilon = 0.05
epsilon_decay = 0.99

def update_q_table(state, action, reward, next_state):
    next_max = np.max(Q[next_state])
    Q[state, action] += alpha * (reward + gamma * next_max - Q[state, action])

def epsilon_greedy(state):
    global epsilon
    if random.uniform(0, 1) < epsilon:
        return random.choice([0, 1])
    else:
        return np.argmax(Q[state])

last_recommended_state = None

def recommend_image(state, user_feedback):
    global epsilon, last_recommended_state

    reward = 1 if user_feedback == 'like' else -1
    action = epsilon_greedy(state)

    possible_states = list(range(len(attributes_df)))
    if last_recommended_state is not None:
        possible_states.remove(last_recommended_state)

    if epsilon < 0.1:
        next_state = np.argmax(Q[:, action])
        if next_state == last_recommended_state:
            next_state = random.choice(possible_states)
    else:
        next_state = random.choice(possible_states)

    update_q_table(state, action, reward, next_state)

    epsilon = max(min_epsilon, epsilon * epsilon_decay)

    last_recommended_state = next_state

    return attributes_df.iloc[next_state]['filename'], next_state

current_state = 0
feedback_sequence = ['like', 'dislike', 'like','like','dislike']

for user_feedback in feedback_sequence:
    recommended_image, current_state = recommend_image(current_state, user_feedback)
    recommended_image_path = os.path.join('/content/', recommended_image)

    if os.path.exists(recommended_image_path):
        recommended_image_cv = cv2.imread(recommended_image_path)
        if recommended_image_cv is not None:
            recommended_image_rgb = cv2.cvtColor(recommended_image_cv, cv2.COLOR_BGR2RGB)
            plt.imshow(recommended_image_rgb)
            plt.axis('off')
            plt.show()
        else:
            print(f"Failed to load the image at {recommended_image_path}")
    else:
        print(f"Image not found at {recommended_image_path}")

    print(f"User feedback: {user_feedback}")
