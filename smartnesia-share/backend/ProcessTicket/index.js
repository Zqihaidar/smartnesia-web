const crypto = require("crypto");

module.exports = async function (context, req) {
    context.log('Processing Ticket Validation via Azure Functions.');

    try {
        const payload = req.body;
        
        // Simulating QR Code Encryption
        const qrHash = crypto.createHash('sha256').update(JSON.stringify(payload)).digest('hex');

        // Dummy ticket creation
        const newTicket = { id: Date.now().toString(), userId: payload.userId, qrHash: qrHash, status: "Active" };

        context.res = {
            status: 200,
            body: { 
              message: "Tiket berhasil diproses",
              ticket: newTicket
            }
        };
    } catch (error) {
        context.log.error(error);
        context.res = {
            status: 500,
            body: { error: "Terjadi kesalahan internal server saat memproses tiket." }
        };
    }
}
