import uvicorn
from fastapi import FastAPI
from typing import Dict, List, Optional
from pydantic import BaseModel
from joblib import load

app = FastAPI()

model = load("anomaly-model.joblib")

class PredictionRequest(BaseModel):
    feature_vector: List[float] # input to model - [mean: float, sd: float]
    score: Optional[bool] = False


@app.post("/prediction")
def predict(req: PredictionRequest) -> Dict:
    '''
    Send a PredictionRequest in the following format: 
    
    {  
        "feature_vector": [0, 0],  
        "score": false  
    }  
    
    and check whether the "feature_vector" is an inlier.

    Set "score" to true to get the anomaly score.
    '''
    response = {}

    prediction = model.predict([req.feature_vector])
    response["is_inlier"] = int(prediction[0])

    if req.score:
        score = model.score_samples([req.feature_vector])
        response["anomaly_score"] = score[0]
    
    return response


@app.get("/model_information")
def model_information():
    '''
    Get the model's parameters
    '''
    return model.get_params()


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)