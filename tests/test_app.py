import json
from app import app

def test_root_status_code():
    client = app.test_client()
    resp = client.get("/")
    assert resp.status_code == 200

def test_root_payload():
    client = app.test_client()
    resp = client.get("/")
    data = json.loads(resp.data)
    assert data["message"] == "Hello DevOps"
    assert data["status"] == "ok"

