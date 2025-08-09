const otpRepo = require('../repositories/otp_repository');
const userRepo = require('../repositories/user_repository');

exports.sendOtp = async (phone) => {
    const user = await userRepo.findByPhone(phone);
    if (!user) throw new Error('No user found with this phone number');

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 5 * 60000); // 5 mins expiry
    const expiresAtSql = expiresAt.toISOString().slice(0, 19).replace('T', ' ');

    await otpRepo.deleteOtp(phone);
    await otpRepo.createOtp({ phone, code: otp, expiresAt: expiresAtSql });

    console.log(`OTP for ${phone}: ${otp}`);
};

exports.verifyOtp = async (phone, code) => {
    const record = await otpRepo.findOtp(phone, code);
    if (!record) return false;

    if (new Date(record.expires_at) < new Date()) {
        await otpRepo.deleteOtp(phone);
        return false;
    }

    await otpRepo.deleteOtp(phone);
    const updated = await userRepo.setPhoneVerified(phone);

    return updated; // true if user updated, false otherwise
};