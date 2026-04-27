# SmartNesia: Aplikasi Layanan Cerdas Indonesia

Aplikasi SmartNesia dibuat menggunakan HTML, CSS, dan Vanilla JavaScript untuk sisi frontend (Single Page Application) dan Microsoft Azure untuk backend.

## Teknologi Utama
1. **Frontend**: HTML, CSS, JavaScript (Vanilla SPA)
2. **Backend**: Node.js (Azure Functions)
3. **Database**: Azure Cosmos DB (Free Tier)
4. **AI & Chatbot**: Azure AI Studio & Azure OpenAI Service
5. **Notifikasi**: Azure Notification Hubs (Free Tier)

## Struktur Folder 📂

- `web-app/`: Berisi kode Web Frontend (Login, Dashboard, Chatbot, Layanan Publik, Wisata, Profil, E-Ticket).
- `backend/`: Sistem Backend menggunakan Azure Functions (Chatbot Webhook, Process Ticket CosmosDB).

---

## 📱 FRONTEND (WEB APP)

Kode aplikasi Web telah disiapkan di folder `web-app`. Anda hanya membutuhkan web browser untuk menjalankannya.

### Cara Menjalankan Frontend
1. Buka folder `web-app`.
2. Klik ganda pada file `index.html` untuk membukanya di browser (seperti Chrome, Firefox, atau Edge).
3. Anda juga dapat menggunakan ekstensi seperti Live Server di VS Code untuk pengalaman yang lebih baik.

Antarmuka sudah dirancang sangat modern, sesuai standar aplikasi layanan masyarakat digital. Menerapkan konsep SPA (Single Page Application) murni.

---

## ☁️ BACKEND (AZURE FUNCTIONS)

Sistem backend menggunakan Azure Functions, sehingga tidak ada biaya operasional (Serverless consumption plan) yang relevan untuk layanan masyarakat.

### Setup Azure Functions Local Environment
1. Buka terminal di folder backend:
   ```bash
   cd backend
   ```
2. Install npm dependencies:
   ```bash
   npm install
   ```
3. Jalankan Azure Functions secara lokal menggunakan Azure Functions Core Tools:
   ```bash
   npm start
   ```
   *Atau*
   ```bash
   func start
   ```

### Fitur Backend
- **ChatbotWebhook** (`backend/ChatbotWebhook`): Merupakan API yang memproses Chatbot menggunakan *Azure OpenAI Service*. Berpotensi membalas pesan terkait layanan & wisata langsung layaknya asisten.
- **ProcessTicket** (`backend/ProcessTicket`): API Endpoint yang menerima request tiket, men-generate QR Code Enkripsi, menyimpan transaksi ke dalam *Azure Cosmos DB (Free Tier)*.

### Integrasi Dukcapil / E-Samsat
Sesuai rancangan, backend ini mudah diintegrasikan dengan API Eksternal (API Dukcapil dsb) via standard HTTP requests `axios` yang sudah terinstall di package.json.

---

*Disiapkan dan dikembangkan oleh tim AI untuk mempermudah transisi layanan publik tanpa batas biaya infrastruktur awal menggunakan Azure.*
