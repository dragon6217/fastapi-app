# 1. 베이스 이미지: 파이썬 3.12이 깔린 가벼운 데비안 리눅스
FROM python:3.12-slim

# 2. uv 설치: 로컬 환경과 동일한 패키지 관리를 위해 uv 복사
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 3. 작업 디렉토리 설정: 컨테이너 내부의 /app 폴더에서 일을 시작함
WORKDIR /app

# 4. 의존성 파일 복사: 라이브러리 목록만 먼저 복사 (캐싱 효율화)
COPY pyproject.toml uv.lock ./

# 5. 패키지 설치: 로컬 .venv와 동일한 환경을 컨테이너 시스템에 구축
RUN uv sync --frozen --no-cache

# 6. 소스 코드 복사: 실제 로직(main.py 등)을 복사
COPY . .

# 7. 실행 명령: 서버 실행 (uvicorn)
# --host 0.0.0.0은 외부 접속을 허용하기 위함입니다.
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]