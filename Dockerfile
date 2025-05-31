# Użyj oficjalnego obrazu Pythona 3.12
FROM python:3.12-slim

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie plików wymagań i instalacja zależności
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Kopiowanie kodu źródłowego
COPY . .

# Ustawienie zmiennych środowiskowych
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Port, na którym działa aplikacja
EXPOSE 8001

# Uruchomienie aplikacji
CMD ["uvicorn", "summerizer:app", "--host", "0.0.0.0", "--port", "8001"]
