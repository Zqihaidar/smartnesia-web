const { GoogleGenerativeAI } = require("@google/generative-ai");

const apiKey = process.env.GEMINI_API_KEY || "dummy-key";

module.exports = async function (context, req) {
    context.log('Processing Chatbot Webhook Request via Gemini AI.');

    try {
        const userMessage = req.body?.message || "";

        if (apiKey === "dummy-key" || apiKey === "") {
            // Fallback jika API key belum diisi oleh user di local.settings.json
            context.res = {
                status: 200,
                body: { response: "AI belum diaktifkan sepenuhnya. Silakan masukkan GEMINI_API_KEY Anda di local.settings.json untuk berinteraksi dengan asisten cerdas SmartNesia." }
            };
            return;
        }

        const genAI = new GoogleGenerativeAI(apiKey);

        // Memakai model gemini-1.5-flash dan mengatur system instruction
        const model = genAI.getGenerativeModel({
            model: "gemini-1.5-flash",
            systemInstruction: "Anda adalah asisten cerdas untuk SmartNesia. Jawab dalam bahasa Indonesia yang ramah, sopan, dan profesional. SmartNesia adalah aplikasi layanan publik dan pariwisata terpadu. Aplikasi ini memiliki fitur: 1. Pemesanan Wisata (Booking destinasi seperti Borobudur, Bromo, Raja Ampat, dll beserta metode pembayarannya), 2. E-Ticket (QR Code tiket digital), 3. Layanan Publik, 4. Event, 5. Pusat Bantuan & Keamanan. Jawablah pertanyaan user berdasarkan informasi fitur-fitur di atas. Jika ditanya harga wisata, beri rentang 30rb - 500rb tergantung destinasi."
        });

        // Generate response dari Gemini
        const result = await model.generateContent(userMessage);
        const botResponse = result.response.text();

        context.res = {
            status: 200,
            body: { response: botResponse }
        };
    } catch (error) {
        context.log.error("Gemini API Error:", error);
        context.res = {
            status: 500,
            body: { response: "Maaf, terjadi kesalahan pada sistem AI kami saat memproses pesan Anda. Pastikan API key sudah benar." }
        };
    }
}
