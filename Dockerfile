FROM python:3.9-slim

WORKDIR /app

# 先複製 requirements.txt 以利用 Docker 快取機制
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製專案原始碼
COPY . .

# 曝露應用程式 port
EXPOSE 8000

# 啟動 Gunicorn 取代 Flask 內建的開發伺服器
# -w 4 代表開啟 4 個 worker process 處理併發請求
# app:app 代表執行 app.py 裡的 app 實例
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
