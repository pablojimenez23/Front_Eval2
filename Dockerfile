# Build
FROM python:3.11-alpine AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

#Produccion
FROM python:3.11-alpine
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
ENV PORT=5000
ENV DEBUG=False
ENV BACKEND_URL=http://localhost:3000
ENV SECRET_KEY=clave_secreta_por_defecto
EXPOSE 5000
CMD ["python", "app.py"]