# Użyj oficjalnego obrazu Pythona 3.12
FROM python:3.12-slim as builder

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie plików wymagań i instalacja zależności
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Ostateczny obraz
FROM python:3.12-slim

# Ustawienie katalogu roboczego
WORKDIR /

# Skopiuj zainstalowane pakiety z buildera
COPY --from=builder /root/.local /root/.local

# Upewnij się, że skrypty w .local są w PATH
ENV PATH=/root/.local/bin:$PATH

# Utwórz użytkownika aplikacji
RUN useradd -m appuser && \
    chown -R appuser:appuser /app

# Ustawienie zmiennych środowiskowych
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH=/app/app

# Skopiuj kod źródłowy
COPY --chown=appuser:appuser . .

# Przełącz na użytkownika appuser
# USER appuser

# Port, na którym działa aplikacja
EXPOSE 8001

# Uruchomienie aplikacji
CMD ["uvicorn", "summerizer:app", "--host", "0.0.0.0", "--port", "8001", "--workers", "4", "--timeout-keep-alive", "60"]
