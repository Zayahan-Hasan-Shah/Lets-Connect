const otpService = require('../services/otp_service');


exports.sendOtp = async (req, res) => {
  try {
    const { phone } = req.body;
    await otpService.sendOtp(phone);
    console.log(`✅ OTP sent successfully`)
    res.json({ success: true, message: 'OTP sent successfully' });
  } catch (err) {
    console.error("Status : 500");
    console.error("OTP Failed to sent : ", err.message)
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.verifyOtp = async (req, res) => {
  try {
    const { phone, otp } = req.body;
    const success = await otpService.verifyOtp(phone, otp);

    if (!success) {
      console.log('Invalid or expired OTP');
      return res.status(400).json({ success: false, message: 'Invalid or expired OTP' });
    }
    console.log('Phone number verified successfully');
    res.json({ success: true, message: 'Phone number verified successfully' });
  } catch (err) {
    console.error("Status : 500");
    console.error("OTP Failed to Verify : ", err.message)
    res.status(500).json({ success: false, message: err.message });
  }
};