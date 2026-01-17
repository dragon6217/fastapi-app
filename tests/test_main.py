from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    # 아래 메시지가 main.py에 적힌 것과 일치해야 성공합니다.
    assert response.json() == {"message": "Hello World - v1", "status": "running"}