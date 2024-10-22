from flask import Flask, request, jsonify
from pydantic import BaseModel, ValidationError

# Initialize Flask app
app = Flask(__name__)

# Pydantic model for request data validation
class Item(BaseModel):
    name: str
    price: float
    quantity: int

@app.route('/items', methods=['POST'])
def create_item():
    try:
        # Parse and validate the incoming request data
        data = request.json
        item = Item(**data)
        return jsonify(item.dict()), 201
    except ValidationError as e:
        # Return validation errors if the input data is invalid
        return jsonify(e.errors()), 400

# Root route
@app.route('/')
def home():
    return {"message": "Welcome to the Flask-Pydantic app!"}, 200

# To run the app
if __name__ == '__main__':
    app.run(debug=True)
