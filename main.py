from fastapi import FastAPI

# for test
app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World - v1", "status": "running"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "query": q}