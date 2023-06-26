from fastapi.testclient import TestClient
from main import get_application

def test_chat_dolly() -> None:
    app = get_application()
    with TestClient(app) as client:
        response = client.post(
            "/api/v1/chat/completions",
            json={
                "model": "falcon-7b",
                "messages": [{"role": "user", "content": "Hello!"}],
            },
        )
        assert response.status_code == 200