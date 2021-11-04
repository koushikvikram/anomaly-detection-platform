import random
import requests
import pandas as pd

test_dataset = pd.read_csv("./jupyter/test.csv")

prediction_endpoint = "http://localhost:8000/prediction"
model_information_endpoint = "http://localhost:8000/model_information"

def predict(feature_vector):
    score = random.randrange(10) < 3
    response = requests.post(
        prediction_endpoint,
        json={
            "feature_vector": feature_vector.tolist(),
            "score": score
        }
    )
    print(response.text)

test_dataset.apply(predict, axis=1)

model_info = requests.get(
    model_information_endpoint
)

print("Model Information:")
print(model_info)
