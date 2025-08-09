const bcrypt = require('bcrypt');
const userRepo = require('../repositories/user_repository');
const otpRepo = require('../repositories/otp_repository');
const { signToken } = require('../utils/jwt');

const signup = async ({ email, username, password, phone }) => {

    const existsEmail = await userRepo.findByEmail(email);
    if (existsEmail) {
        console.log('Email already in use')
        throw new Error('Email already in use')
    };

    const existsUser = await userRepo.findByUsername(username);
    if (existsUser) {
        console.log('Username already in use');
        throw new Error('Username already in use')
    };

    const existsPhone = await userRepo.findByPhone(phone);
    if (existsPhone) {
        console.log('Phone number already in use')
        throw new Error('Phone number already in use')
    };

    const hashed = await bcrypt.hash(password, 12);
    const user = await userRepo.createUser({ email, username, password: hashed, phone });

    // do not return password
    const safeUser = { id: user.id, email: user.email, username: user.username, phone: user.phone, phone_verified: user.phone_verified };
    return { user: safeUser, otpSent: true };
};


const login = async ({ email, password }) => {
    const user = await userRepo.findByEmail(email);
    if (!user) {
        console.log('Invalid email or password');
        throw new Error('Invalid email or password');
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
        console.log('Invalid email or password');
        throw new Error('Invalid email or password')
    };

    const safeUser = {
        id: user.id,
        email: user.email,
        username: user.username,
        phone: user.phone,
        phone_verified: 0
    };

    const token = signToken(safeUser);

    return { user: safeUser, token };
};

module.exports = { signup, login };