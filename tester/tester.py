import random
import requests
import pandas as pd

test_dataset = pd.read_csv("./jupyter/test.csv")
# test_dataset = pd.read_csv("./jupyter/demo.csv")
# shuffle dataset
test_dataset = test_dataset.sample(frac=1).reset_index(drop=True)

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

# predict on a subset
test_dataset[:1000].apply(predict, axis=1)
# test_dataset.apply(predict, axis=1) # uncomment to predict on full test set

model_info = requests.get(
    model_information_endpoint
)

print("Model Information:")
print(model_info)
