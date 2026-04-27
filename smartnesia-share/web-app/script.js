document.addEventListener('DOMContentLoaded', () => {

    // ==========================================
    // DOM ELEMENTS
    // ==========================================
    const landingPage = document.getElementById('landing-page');
    const dashboardApp = document.getElementById('dashboard-app');
    
    // Modals
    const loginModal = document.getElementById('login-modal');
    const alertModal = document.getElementById('alert-modal');
    const layananModal = document.getElementById('layanan-modal');
    
    // Triggers
    const loginTriggers = document.querySelectorAll('.login-trigger-btn');
    const closeLoginBtn = document.getElementById('close-login');
    const loginSubmitBtn = document.getElementById('login-submit-btn');
    const logoutBtn = document.getElementById('logout-btn');
    
    // Sidebar Navigation
    const navItems = document.querySelectorAll('.sidebar-nav .nav-item');
    const appSections = document.querySelectorAll('.app-section');
    
    // Mobile menu
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.querySelector('.sidebar');
    
    // Chatbot
    const chatInput = document.getElementById('chat-input-app');
    const sendBtn = document.getElementById('send-btn-app');
    const chatMessagesContainer = document.getElementById('chat-messages-container');
    
    // Wisata Container
    const wisataContainer = document.getElementById('wisata-container');

    // ==========================================
    // MOCK DATA: WISATA & EVENT
    // ==========================================
    const wisataData = [
        {
            title: "Taman Nasional Bromo Tengger Semeru",
            category: "Taman Nasional",
            price: "Rp 35.000",
            img: "url('bromo baru.jpg')",
            location: "Jawa Timur, Indonesia",
            rating: "4.8",
            reviews_count: "12.500",
            facilities: [
                { icon: "directions_car", name: "Parkir" },
                { icon: "wc", name: "Toilet" },
                { icon: "restaurant", name: "Makan" },
                { icon: "camera_alt", name: "Spot Foto" }
            ],
            reviews: [
                { user: "Budi Santoso", rating: "5.0", text: "Pemandangan sunrise sangat indah! Wajib dikunjungi setidaknya sekali seumur hidup.", img: "bromobaru.jpg" },
                { user: "Siti Aminah", rating: "4.5", text: "Hawanya sangat dingin, pastikan bawa jaket tebal. Pemandangan kawahnya luar biasa." }
            ]
        },
        {
            title: "Candi Borobudur",
            category: "Candi & Sejarah",
            price: "Rp 50.000",
            img: "url('sunrise borobudur.webp')",
            location: "Magelang, Jawa Tengah",
            rating: "4.9",
            reviews_count: "45.000",
            facilities: [
                { icon: "directions_car", name: "Parkir" },
                { icon: "wheelchair_pickup", name: "Akses Difabel" },
                { icon: "store", name: "Souvenir" },
                { icon: "mosque", name: "Mushola" }
            ],
            reviews: [
                { user: "Andi Wijaya", rating: "5.0", text: "Sangat megah dan sarat akan nilai sejarah. Penataan areanya juga rapi." },
                { user: "Ratna", rating: "4.8", text: "Tempat yang damai, sangat direkomendasikan datang di pagi hari untuk menghindari keramaian." }
            ]
        },
        {
            title: "Prambanan Jazz Festival 2026",
            category: "Event Konser",
            price: "Rp 350.000",
            img: "url('prambanan.jpg')",
            location: "Sleman, DI Yogyakarta",
            rating: "4.7",
            reviews_count: "2.300",
            facilities: [
                { icon: "music_note", name: "Stage" },
                { icon: "fastfood", name: "Food Court" },
                { icon: "wc", name: "Toilet" },
                { icon: "local_hospital", name: "Medis" }
            ],
            reviews: [
                { user: "Kiki", rating: "5.0", text: "Event tahunan yang selalu dinanti. Lineup tahun ini luar biasa!" },
                { user: "Deni", rating: "4.5", text: "Suasananya magis, mendengarkan musik jazz dengan latar belakang candi." }
            ]
        },
        {
            title: "Taman Nasional Komodo",
            category: "Taman Nasional",
            price: "Rp 150.000",
            img: "url('taman nasional komodo.webp')",
            location: "Nusa Tenggara Timur",
            rating: "4.9",
            reviews_count: "8.900",
            facilities: [
                { icon: "directions_boat", name: "Kapal" },
                { icon: "tour", name: "Guide" },
                { icon: "restaurant", name: "Makan" },
                { icon: "camera_alt", name: "Spot Foto" }
            ],
            reviews: [
                { user: "Reza", rating: "5.0", text: "Pengalaman yang tak terlupakan melihat komodo di habitat aslinya." },
                { user: "Rini", rating: "4.9", text: "Pantai Pink-nya sangat cantik. Wajib ikut island hopping." }
            ]
        }
    ];

    // ==========================================
    // INITIALIZATION
    // ==========================================
    renderWisataData();

    // ==========================================
    // LOGIN & NAVIGATION LOGIC
    // ==========================================
    
    // Open Login Modal
    loginTriggers.forEach(btn => {
        btn.addEventListener('click', () => {
            loginModal.classList.add('active');
        });
    });

    // Close Login Modal
    closeLoginBtn.addEventListener('click', () => {
        loginModal.classList.remove('active');
    });

    // Submit Login -> Go to Dashboard
    loginSubmitBtn.addEventListener('click', () => {
        loginModal.classList.remove('active');
        landingPage.classList.remove('active');
        dashboardApp.classList.add('active');
    });

    // Logout -> Go to Landing Page
    logoutBtn.addEventListener('click', () => {
        dashboardApp.classList.remove('active');
        landingPage.classList.add('active');
        // Reset to home view
        switchAppView('home-view');
        // Reset sidebar on mobile
        sidebar.classList.remove('open');
    });

    // Mobile Sidebar Toggle
    mobileMenuBtn.addEventListener('click', () => {
        sidebar.classList.toggle('open');
    });

    // Dashboard View Switching
    navItems.forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = item.getAttribute('data-target');
            switchAppView(targetId);
            if(window.innerWidth <= 768) {
                sidebar.classList.remove('open');
            }
        });
    });

    function switchAppView(targetId) {
        navItems.forEach(nav => {
            if (nav.getAttribute('data-target') === targetId) {
                nav.classList.add('active');
            } else {
                nav.classList.remove('active');
            }
        });
        
        appSections.forEach(section => {
            if (section.id === targetId) {
                section.classList.add('active');
            } else {
                section.classList.remove('active');
            }
        });
    }

    // ==========================================
    // ALERT MODAL LOGIC
    // ==========================================
    const closeAlertBtn = document.getElementById('close-alert-btn');
    closeAlertBtn.addEventListener('click', () => {
        alertModal.classList.remove('active');
    });

    function showAlert(title, message, isSuccess = true) {
        document.getElementById('alert-title').innerText = title;
        document.getElementById('alert-message').innerText = message;
        
        const iconSpan = document.querySelector('#alert-icon span');
        if(isSuccess) {
            iconSpan.innerText = 'check_circle';
            iconSpan.className = 'material-icons-outlined text-primary';
        } else {
            iconSpan.innerText = 'error';
            iconSpan.className = 'material-icons-outlined';
            iconSpan.style.color = '#d32f2f';
        }
        
        alertModal.classList.add('active');
    }

    // ==========================================
    // PROCEDURES DEFINITION (LAYANAN PUBLIK)
    // ==========================================
    const procedures = {
        'ktp': {
            title: "KTP Digital (IKD)",
            goal: "Aktivasi Identitas Kependudukan Digital melalui ponsel.",
            steps: [
                { type: 'input', label: 'Masukkan NIK', placeholder: '16 Digit NIK Anda' },
                { type: 'input', label: 'Kode OTP', placeholder: 'Masukkan 6 Digit OTP yang dikirim via SMS' },
                { type: 'loading', text: 'Memvalidasi data ke database Dukcapil...' },
                { type: 'success', text: 'KTP Digital berhasil diaktifkan. Anda dapat melihatnya di menu Profil.' }
            ]
        },
        'kk': {
            title: "Kartu Keluarga",
            goal: "Pembaruan atau pengajuan perubahan data KK.",
            steps: [
                { type: 'input', label: 'Jenis Perubahan', placeholder: 'Misal: Tambah Anggota / Pindah' },
                { type: 'upload', text: 'Upload Dokumen Pendukung (Akta/KTP)' },
                { type: 'loading', text: 'Petugas sedang memverifikasi pengajuan Anda...' },
                { type: 'success', text: 'KK baru diterbitkan. Silakan unduh KK terbaru Anda.' }
            ]
        },
        'nib': {
            title: "Izin Usaha (NIB)",
            goal: "Pendaftaran Nomor Induk Berusaha.",
            steps: [
                { type: 'input', label: 'Nama Usaha', placeholder: 'Masukkan Nama Usaha Anda' },
                { type: 'input', label: 'Jenis Usaha', placeholder: 'Misal: Kuliner, Jasa, dll.' },
                { type: 'upload', text: 'Upload Dokumen Persyaratan' },
                { type: 'loading', text: 'Sistem melakukan validasi kelayakan...' },
                { type: 'success', text: 'NIB berhasil diterbitkan. Anda dapat mengunduh NIB Anda.' }
            ]
        },
        'halal': {
            title: "Sertifikasi Halal",
            goal: "Pengajuan sertifikasi halal melalui self-declare.",
            steps: [
                { type: 'input', label: 'Nama Produk', placeholder: 'Masukkan nama produk yang diajukan' },
                { type: 'upload', text: 'Upload Data Bahan Baku' },
                { type: 'input', label: 'Pernyataan Self-Declare', placeholder: 'Ketik "SAYA MENYATAKAN HALAL"' },
                { type: 'loading', text: 'Memproses pengajuan ke BPJPH...' },
                { type: 'success', text: 'Sertifikat Halal berhasil diterbitkan.' }
            ]
        },
        'pbb': {
            title: "Pajak PBB",
            goal: "Cek dan bayar Pajak Bumi dan Bangunan.",
            steps: [
                { type: 'input', label: 'Nomor Objek Pajak (NOP)', placeholder: 'Masukkan 18 Digit NOP' },
                { type: 'payment', amount: 'Rp 250.000', method: 'Pilih Metode Pembayaran' },
                { type: 'loading', text: 'Memproses pembayaran...' },
                { type: 'success', text: 'Pembayaran Pajak PBB berhasil. Bukti bayar dapat diunduh.' }
            ]
        },
        'samsat': {
            title: "E-Samsat",
            goal: "Pembayaran pajak kendaraan bermotor secara online.",
            steps: [
                { type: 'input', label: 'Nomor Polisi (Plat)', placeholder: 'Contoh: B 1234 ABC' },
                { type: 'payment', amount: 'Rp 450.000', method: 'Pilih Metode Pembayaran' },
                { type: 'loading', text: 'Mengonfirmasi pembayaran dengan pihak Samsat...' },
                { type: 'success', text: 'Pembayaran E-Samsat berhasil. E-TBPKP tersedia secara digital.' }
            ]
        }
    };

    // DOM Elements for Procedure
    const procedureModal = document.getElementById('procedure-modal');
    const closeProcedureBtn = document.getElementById('close-procedure');
    const procTitle = document.getElementById('procedure-title');
    const procGoal = document.getElementById('procedure-goal');
    const stepIndicator = document.getElementById('step-indicator');
    const procBody = document.getElementById('procedure-body');
    const procFooter = document.getElementById('procedure-footer');

    let currentProcedure = null;
    let currentStepIndex = 0;

    window.startProcedure = function(procId) {
        currentProcedure = procedures[procId];
        currentStepIndex = 0;
        
        if(currentProcedure) {
            procTitle.innerText = currentProcedure.title;
            procGoal.innerText = currentProcedure.goal;
            procedureModal.classList.add('active');
            renderStep();
        }
    };

    closeProcedureBtn.addEventListener('click', () => {
        procedureModal.classList.remove('active');
    });

    function renderStep() {
        if(!currentProcedure) return;
        
        const step = currentProcedure.steps[currentStepIndex];
        const totalSteps = currentProcedure.steps.length;

        // Render Step Indicator
        stepIndicator.innerHTML = '';
        for(let i=0; i<totalSteps; i++) {
            const dot = document.createElement('div');
            dot.className = 'step-dot' + (i <= currentStepIndex ? ' active' : '');
            stepIndicator.appendChild(dot);
        }

        // Render Body
        procBody.innerHTML = '';
        if (step.type === 'input') {
            procBody.innerHTML = `
                <div class="input-group">
                    <label>${step.label}</label>
                    <input type="text" placeholder="${step.placeholder}" id="proc-input">
                </div>
            `;
        } else if (step.type === 'upload') {
            procBody.innerHTML = `
                <div class="upload-box" onclick="this.innerHTML='<span class=\\'material-icons-outlined\\' style=\\'color:#4CAF50;\\'>check_circle</span><p>File berhasil diunggah</p>'">
                    <span class="material-icons-outlined">cloud_upload</span>
                    <p>${step.text}</p>
                    <small style="color:var(--primary-color);">Klik untuk upload simulasi</small>
                </div>
            `;
        } else if (step.type === 'payment') {
            procBody.innerHTML = `
                <div style="text-align:center; padding: 20px;">
                    <p style="color:var(--text-muted); margin-bottom:5px;">Total Tagihan</p>
                    <h2 style="color:var(--primary-color); font-size: 28px; margin-bottom: 20px;">${step.amount}</h2>
                    <p style="color:var(--text-main);">Silakan klik Lanjut untuk masuk ke menu pembayaran.</p>
                </div>
            `;
        } else if (step.type === 'loading') {
            procBody.innerHTML = `
                <div class="loading-spinner-container">
                    <div class="loading-spinner"></div>
                    <p style="color:var(--primary-color); font-weight:600;">${step.text}</p>
                </div>
            `;
            // Auto progress logic
            setTimeout(() => {
                nextStep();
            }, 2500);
        } else if (step.type === 'success') {
            procBody.innerHTML = `
                <div class="success-message">
                    <span class="material-icons-outlined">check_circle</span>
                    <h3>Selesai</h3>
                    <p style="color:var(--text-muted);">${step.text}</p>
                </div>
            `;
        }

        // Render Footer
        procFooter.innerHTML = '';
        if (step.type !== 'loading' && step.type !== 'success') {
            if (currentStepIndex > 0) {
                const backBtn = document.createElement('button');
                backBtn.className = 'secondary-btn';
                backBtn.style.flex = '1';
                backBtn.innerText = 'Kembali';
                backBtn.onclick = prevStep;
                procFooter.appendChild(backBtn);
            }
            const nextBtn = document.createElement('button');
            nextBtn.className = 'primary-btn';
            nextBtn.style.flex = '2';
            nextBtn.innerText = 'Lanjut';
            nextBtn.onclick = () => {
                // simple validation simulasi
                const input = document.getElementById('proc-input');
                if(input && input.value.trim() === '') {
                    input.style.borderColor = 'red';
                    return;
                }
                
                if (step.type === 'payment') {
                    procedureModal.classList.remove('active');
                    bookTicket(currentProcedure.title, step.amount, 'layanan');
                    return;
                }
                
                nextStep();
            };
            procFooter.appendChild(nextBtn);
        } else if (step.type === 'success') {
            const finishBtn = document.createElement('button');
            finishBtn.className = 'primary-btn';
            finishBtn.style.width = '100%';
            finishBtn.innerText = 'Unduh / Tutup';
            finishBtn.onclick = () => {
                procedureModal.classList.remove('active');
            };
            procFooter.appendChild(finishBtn);
        }
    }

    function nextStep() {
        if(currentStepIndex < currentProcedure.steps.length - 1) {
            currentStepIndex++;
            renderStep();
        }
    }

    function prevStep() {
        if(currentStepIndex > 0) {
            currentStepIndex--;
            renderStep();
        }
    }

    // ==========================================
    // WISATA & EVENT LOGIC
    // ==========================================
    function renderWisataData() {
        if(!wisataContainer) return;
        
        wisataContainer.innerHTML = '';
        
        wisataData.forEach((item, index) => {
            const card = document.createElement('div');
            card.className = 'wisata-card';
            card.style.cursor = 'pointer';
            card.onclick = () => showDetailWisata(index);
            
            card.innerHTML = `
                <div class="wisata-img" style="background: ${item.img}; background-size: cover; background-position: center;"></div>
                <div class="wisata-info">
                    <small style="color: var(--primary-color); font-weight: 600; margin-bottom: 4px; display: block;">${item.category}</small>
                    <h3>${item.title}</h3>
                    <p>Jelajahi keindahan dan keunikan destinasi ini secara langsung.</p>
                    <div class="wisata-price-row">
                        <span class="wisata-price">${item.price}</span>
                        <button class="primary-btn btn-small" onclick="event.stopPropagation(); bookTicket('${item.title}', '${item.price}')">Pesan</button>
                    </div>
                </div>
            `;
            
            wisataContainer.appendChild(card);
        });
    }

    window.showDetailWisata = function(index) {
        const item = wisataData[index];
        if(!item) return;

        document.getElementById('detail-img').style.backgroundImage = item.img;
        document.getElementById('detail-title').innerText = item.title;
        document.getElementById('detail-location-text').innerText = item.location;
        document.getElementById('detail-rating').innerText = item.rating;
        document.getElementById('detail-reviews').innerText = item.reviews_count;
        document.getElementById('detail-price-text').innerText = item.price;
        
        // Facilities
        const facContainer = document.getElementById('detail-facilities');
        facContainer.innerHTML = '';
        item.facilities.forEach(f => {
            facContainer.innerHTML += `
                <div class="facility-item">
                    <span class="material-icons-outlined">${f.icon}</span>
                    <span>${f.name}</span>
                </div>
            `;
        });

        // Reviews
        const revContainer = document.getElementById('detail-review-grid');
        revContainer.innerHTML = '';
        item.reviews.forEach(r => {
            let imgsHtml = '';
            if (r.img) {
                imgsHtml = `<div class="review-imgs"><img src="${r.img}" alt="Review Image"></div>`;
            }
            revContainer.innerHTML += `
                <div class="review-card">
                    <div class="review-header">
                        <span class="review-user">${r.user}</span>
                        <span class="review-stars"><span class="material-icons-outlined" style="font-size:14px; vertical-align:middle;">star</span> ${r.rating}</span>
                    </div>
                    <p class="review-text">${r.text}</p>
                    ${imgsHtml}
                </div>
            `;
        });

        // Set Pesan Sekarang button
        const btnPesan = document.getElementById('btn-pesan-sekarang');
        btnPesan.onclick = () => {
            bookTicket(item.title, item.price);
        };

        switchAppView('detail-wisata-view');
        window.scrollTo(0, 0);
    }

    // ==========================================
    // PAYMENT LOGIC
    // ==========================================
    let currentOrder = { title: '', price: '', paymentMethod: '', orderId: '', paymentId: '', deadline: '', status: '', type: 'wisata' };
    let ordersHistory = [];

    window.bookTicket = function(title, price, type = 'wisata') {
        currentOrder = { title: title, price: price, paymentMethod: '', orderId: '', paymentId: '', deadline: '', status: '', type: type };
        
        document.getElementById('pembayaran-total-price').innerText = price;
        
        switchAppView('pembayaran-view');
        window.scrollTo(0, 0);
    }

    // Event listeners for payment methods
    const btnBayarSekarang = document.getElementById('btn-bayar-sekarang');

    if(btnBayarSekarang) {
        btnBayarSekarang.addEventListener('click', () => {
            let selectedMethod = document.querySelector('input[name="payment_method"]:checked');
            if (!selectedMethod) {
                showAlert('Peringatan', 'Silakan pilih metode pembayaran terlebih dahulu.', false);
                return;
            }
            
            // Generate order and payment IDs if not already generated
            if (!currentOrder.orderId) {
                currentOrder.orderId = 'KITA - ' + Math.floor(Math.random() * 1000000).toString().padStart(6, '0');
                currentOrder.paymentId = 'RT - PAY' + Math.floor(Math.random() * 1000000).toString().padStart(6, '0');
            }
            
            currentOrder.paymentMethod = selectedMethod.value;
            
            // Dynamic deadline (current time + 5 hours)
            const deadline = new Date(Date.now() + 5 * 60 * 60 * 1000);
            const deadlineText = deadline.toLocaleDateString('id-ID', {day: '2-digit', month: 'long', year: 'numeric'}) + ' ' + deadline.toLocaleTimeString('id-ID', {hour: '2-digit', minute:'2-digit'});
            currentOrder.deadline = deadlineText;
            currentOrder.status = 'pending';

            // Save or update in ordersHistory
            const existingIndex = ordersHistory.findIndex(o => o.orderId === currentOrder.orderId);
            if (existingIndex >= 0) {
                ordersHistory[existingIndex] = {...currentOrder};
            } else {
                ordersHistory.push({...currentOrder});
            }

            // Populate waiting view
            document.getElementById('menunggu-total-price').innerText = currentOrder.price;
            document.getElementById('waiting-order-id').innerText = currentOrder.orderId;
            document.getElementById('waiting-payment-id').innerText = currentOrder.paymentId;
            document.getElementById('payment-deadline-time').innerText = currentOrder.deadline;
            
            // Generate QR or VA instruction
            const instructionQr = document.getElementById('instruction-qr');
            if (currentOrder.paymentMethod === 'QRIS' || ['Gopay', 'Shopeepay', 'Dana', 'Ovo'].includes(currentOrder.paymentMethod)) {
                instructionQr.innerHTML = `
                    <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg" alt="QR Code" style="margin:0 auto;">
                    <p style="margin-top:10px; font-weight:600; color:var(--text-main);">Scan QR untuk Membayar</p>
                `;
            } else {
                // Virtual Account
                const vaCode = '8800' + Math.floor(Math.random() * 100000000);
                instructionQr.innerHTML = `
                    <p style="color:var(--text-muted);">Nomor Virtual Account</p>
                    <div class="va-container">${vaCode}</div>
                    <p style="font-size:12px; color:var(--text-muted);">Gunakan kode ini pada ATM atau m-Banking Anda.</p>
                `;
            }

            switchAppView('menunggu-pembayaran-view');
            window.scrollTo(0, 0);
        });
    }

    const btnRefreshStatus = document.getElementById('btn-refresh-status');
    if(btnRefreshStatus) {
        btnRefreshStatus.addEventListener('click', () => {
            // Simulate loading then success
            btnRefreshStatus.innerHTML = '<div class="loading-spinner" style="width:20px; height:20px; margin:0; border-width:3px; display:inline-block; vertical-align:middle;"></div> Mengecek...';
            
            setTimeout(() => {
                btnRefreshStatus.innerHTML = '<span class="material-icons-outlined">refresh</span> Refresh Status';
                
                // Update status in history
                const existingIndex = ordersHistory.findIndex(o => o.orderId === currentOrder.orderId);
                if (existingIndex >= 0) {
                    ordersHistory[existingIndex].status = 'success';
                }
                
                // Populate success view
                document.getElementById('selesai-total-price').innerText = currentOrder.price;
                document.getElementById('success-order-id').innerText = currentOrder.orderId;
                document.getElementById('success-payment-method').innerText = currentOrder.paymentMethod;
                document.getElementById('success-total-paid').innerText = currentOrder.price;
                
                const today = new Date();
                document.getElementById('success-date').innerText = today.toLocaleDateString('id-ID', {day: '2-digit', month: '2-digit', year: 'numeric'}) + ' ' + today.toLocaleTimeString('id-ID', {hour: '2-digit', minute:'2-digit'});

                switchAppView('selesai-pembayaran-view');
                window.scrollTo(0, 0);
            }, 1500);
        });
    }

    // ==========================================
    // HISTORY LOGIC
    // ==========================================
    window.renderHistory = function(tab) {
        const container = document.getElementById('history-container');
        if (!container) return;
        
        container.innerHTML = '';
        
        const filteredOrders = ordersHistory.filter(o => o.status === (tab === 'belum-bayar' ? 'pending' : 'success'));
        
        if (filteredOrders.length === 0) {
            container.innerHTML = `
                <div class="history-empty">
                    <span class="material-icons-outlined">receipt_long</span>
                    <p>Belum ada riwayat transaksi.</p>
                </div>
            `;
            return;
        }
        
        filteredOrders.forEach(order => {
            const card = document.createElement('div');
            card.className = 'history-card';
            
            let btnHtml = '';
            if (order.status === 'pending') {
                btnHtml = `<button class="primary-btn btn-small" onclick="lanjutBayar('${order.orderId}')">Lanjut Bayar</button>`;
            } else {
                if (order.type === 'layanan') {
                    btnHtml = `<button class="primary-btn btn-small" onclick="unduhResi('${order.orderId}')">Unduh Resi</button>`;
                } else {
                    btnHtml = `<button class="primary-btn btn-small" onclick="lihatTiket('${order.orderId}')">Lihat Tiket</button>`;
                }
            }
            
            card.innerHTML = `
                <div class="history-card-left">
                    <span class="history-badge ${order.status}">${order.status === 'pending' ? 'Belum Bayar' : 'Selesai'}</span>
                    <div class="history-title">${order.title}</div>
                    <div class="history-meta">
                        <span>${order.orderId}</span>
                        <span>${order.paymentMethod || 'Belum dipilih'}</span>
                    </div>
                    <div class="history-price">${order.price}</div>
                </div>
                <div>
                    ${btnHtml}
                </div>
            `;
            container.appendChild(card);
        });
    }

    window.lanjutBayar = function(orderId) {
        const order = ordersHistory.find(o => o.orderId === orderId);
        if(order) {
            currentOrder = {...order};
            
            // Re-populate waiting view
            document.getElementById('menunggu-total-price').innerText = currentOrder.price;
            document.getElementById('waiting-order-id').innerText = currentOrder.orderId;
            document.getElementById('waiting-payment-id').innerText = currentOrder.paymentId;
            document.getElementById('payment-deadline-time').innerText = currentOrder.deadline;
            
            // Generate QR or VA instruction
            const instructionQr = document.getElementById('instruction-qr');
            if (currentOrder.paymentMethod === 'QRIS' || ['Gopay', 'Shopeepay', 'Dana', 'Ovo'].includes(currentOrder.paymentMethod)) {
                instructionQr.innerHTML = `
                    <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg" alt="QR Code" style="margin:0 auto;">
                    <p style="margin-top:10px; font-weight:600; color:var(--text-main);">Scan QR untuk Membayar</p>
                `;
            } else {
                // Virtual Account
                const vaCode = '8800' + Math.floor(Math.random() * 100000000);
                instructionQr.innerHTML = `
                    <p style="color:var(--text-muted);">Nomor Virtual Account</p>
                    <div class="va-container">${vaCode}</div>
                    <p style="font-size:12px; color:var(--text-muted);">Gunakan kode ini pada ATM atau m-Banking Anda.</p>
                `;
            }

            switchAppView('menunggu-pembayaran-view');
        }
    }

    window.lihatTiket = function(orderId) {
        document.getElementById('barcode-order-id').innerText = orderId;
        document.getElementById('barcode-modal').classList.add('active');
    }

    window.unduhResi = function(orderId) {
        showAlert('Unduhan Berhasil', 'Resi tagihan untuk ' + orderId + ' telah berhasil disimpan di perangkat Anda.');
    }

    // Tab Listeners
    const historyTabs = document.querySelectorAll('.history-tab');
    historyTabs.forEach(tab => {
        tab.addEventListener('click', (e) => {
            historyTabs.forEach(t => t.classList.remove('active'));
            e.target.classList.add('active');
            renderHistory(e.target.getAttribute('data-tab'));
        });
    });

    // Fix switchAppView to be globally available so onclick attributes can use it
    window.switchAppView = function(targetId) {
        navItems.forEach(nav => {
            if (nav.getAttribute('data-target') === targetId) {
                nav.classList.add('active');
            } else {
                nav.classList.remove('active');
            }
        });
        
        appSections.forEach(section => {
            if (section.id === targetId) {
                section.classList.add('active');
            } else {
                section.classList.remove('active');
            }
        });

        // if history view is opened, render the active tab
        if (targetId === 'history-view') {
            const activeTab = document.querySelector('.history-tab.active');
            renderHistory(activeTab ? activeTab.getAttribute('data-tab') : 'belum-bayar');
        }
    };


    // ==========================================
    // CHATBOT LOGIC
    // ==========================================
    function addChatMessage(text, sender) {
        const messageDiv = document.createElement('div');
        messageDiv.classList.add('message', sender);
        
        let avatarIcon = sender === 'bot' ? 'smart_toy' : 'person';
        
        messageDiv.innerHTML = `
            <div class="avatar"><span class="material-icons-outlined">${avatarIcon}</span></div>
            <div class="bubble">${text}</div>
        `;
        
        chatMessagesContainer.appendChild(messageDiv);
        chatMessagesContainer.scrollTop = chatMessagesContainer.scrollHeight;
    }
    
    function handleChatSend() {
        const text = chatInput.value.trim();
        if (text === '') return;
        
        addChatMessage(text, 'user');
        chatInput.value = '';
        
        // Mock Bot Response
        setTimeout(() => {
            const responses = [
                "Tentu, saya bisa bantu. Mohon jelaskan lebih spesifik.",
                "Sistem layanan terpadu sedang berjalan normal saat ini.",
                "Untuk panduan wisata, Anda bisa membuka menu 'Wisata & Event' di sebelah kiri.",
                "Pesan diterima. Asisten AI siap membantu Anda."
            ];
            const randomReply = responses[Math.floor(Math.random() * responses.length)];
            addChatMessage(randomReply, 'bot');
        }, 1200);
    }
    
    if(sendBtn) {
        sendBtn.addEventListener('click', handleChatSend);
    }
    
    if(chatInput) {
        chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                handleChatSend();
            }
        });
    }

});
